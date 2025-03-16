import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:screen_protector/screen_protector.dart';
import 'dart:async';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'notification_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart'; // Check platform
import 'package:image_picker/image_picker.dart';
import 'package:kanhagold/main.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await requestPermissions();

  runApp(MyApp());
}

Future<void> requestPermissions() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Request Camera permission
  var cameraStatus = await Permission.camera.request();
  if (cameraStatus.isGranted) {
    print("Camera permission granted");
  } else {
    print("Camera permission denied");
  }

  // Request Microphone permission
  var micStatus = await Permission.microphone.request();
  if (micStatus.isGranted) {
    print("Microphone permission granted");
  } else {
    print("Microphone permission denied");
  }




}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(message.notification?.title.toString());
}

bool _isSplashVisible = true;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HDJ',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
        ),
        colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
      ),
      home: WebViewScreen(mainUrl: 'https://catalogue.dashrathgold.com/'),

    );
  }
}

class WebViewScreen extends StatefulWidget {
  final String mainUrl;
  WebViewScreen({required this.mainUrl});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late InAppWebViewController _webViewController;
  bool _isNetworkAvailable = true;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  String? _fcmToken;



  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    super.initState();
    // setCookie();
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value){
      print('value');
      print(value);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_webViewController != null) {
        await _webViewController!.setSettings(
          settings: InAppWebViewSettings(
            supportZoom: false,

          ),
        );
      }
    });
    _startSplashTimer();
    _enableScreenProtection();
    _checkNetworkConnectivity();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((result) async {
      bool hasInternet = await _hasInternetAccess();
      _updateNetworkStatus(hasInternet);
    });
  }
  void _startSplashTimer() {
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _isSplashVisible = false;
      });
    });
  }
  Future<void> _enableScreenProtection() async {
    try {
      if (Platform.isAndroid) {
        await ScreenProtector.protectDataLeakageOn();
      } else if (Platform.isIOS) {
        await ScreenProtector.preventScreenshotOn();
      }
    } catch (e) {
      print("Error enabling screen protection: $e");
    }
  }
  void _updateNetworkStatus(bool hasInternet) {
    setState(() {
      _isNetworkAvailable = hasInternet;
    });

    if (hasInternet && _webViewController != null) {
      Future.delayed(Duration(seconds: 3), () {
        if (_isNetworkAvailable) {
          _webViewController.reload(); // Reload WebView after 4 seconds
        }
      });
    }
  }
  Future<void> _checkNetworkConnectivity() async {
    bool hasInternet = await _hasInternetAccess();
    setState(() {
      _isNetworkAvailable = hasInternet;
    });
    _updateNetworkStatus(hasInternet);
  }
  Future<bool> _hasInternetAccess() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
  Future<bool> _onWillPop() async {
    Uri? currentUrl = await _webViewController.getUrl();
    print('currentUrl: $currentUrl'); // Debugging

    // Check if the current URL is the same as the main URL
    // if (currentUrl != null && currentUrl.toString() == widget.mainUrl) {
    if (currentUrl != null && currentUrl.toString() == "https://catalogue.dashrathgold.com/") {
      bool shouldExit = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Exit App"),
            content: Text("Are you sure you want to exit the app?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("No"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text("Yes"),
              ),
            ],
          );
        },
      );
      return shouldExit ?? true; // Return the result from the dialog
    }

    // If not the same URL, check if we can go back
    if (await _webViewController.canGoBack()) {
      _webViewController.goBack();
      return Future.value(false); // Don't exit, go back in the WebView
    } else {
      return Future.value(true); // No history to go back, allow exit
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            title: Text('HDJ'),
            centerTitle: true,
          ),
        ),
        body: Stack(
          children: [
        AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _isNetworkAvailable
                ? InAppWebView(
              initialUrlRequest: URLRequest(url: WebUri(widget.mainUrl)),

              initialSettings: InAppWebViewSettings(
                supportZoom: false,
                useWideViewPort: false,
                builtInZoomControls: false,
                displayZoomControls: false,

              ),


              onWebViewCreated: (InAppWebViewController controller) {
                _webViewController = controller;
                _webViewController.evaluateJavascript(source: """
    document.addEventListener('gesturestart', function(event) {
      event.preventDefault();
    });
  """);

                // Register the JavaScript handler
                _webViewController.addJavaScriptHandler(
                  handlerName: 'onItemDetailsClicked',
                  callback: (args) {
                    if (args.isNotEmpty) {
                      _handleItemDetailsClicked(args[0]);
                    }
                  },
                );

                _webViewController.addJavaScriptHandler(
                  handlerName: 'openUrlInBrowser',
                  callback: (args) {
                    if (args.isNotEmpty) {
                      _openUrlInBrowser(args[0]); // Call the browser opening function
                    }
                  },
                );

                _webViewController.addJavaScriptHandler(
                  handlerName: 'updateFcmToken',
                  callback: (args) {
                    if (args.isNotEmpty) {
                      _updateFcmToken(args[0]); // Call the browser opening function
                    }
                  },
                );

                controller.addJavaScriptHandler(
                  handlerName: "filePicker",
                  callback: (args) async {
                    String? option = await showFilePickerDialog();
                    if (option != null) {
                      List<String>? filePaths = await pickFile(option);
                      if (filePaths != null && filePaths.isNotEmpty) {
                        List<String> base64Files = [];
                        for (var filePath in filePaths) {
                          String base64File = await convertFileToBase64(filePath);
                          base64Files.add("data:image/png;base64,$base64File");
                        }
                        return base64Files;
                      }
                    }
                    return null;
                  },
                );

                controller.addJavaScriptHandler(
                  handlerName: 'onItemDetailsClicked',
                  callback: (args) {
                    if (args.isNotEmpty) {
                      _handleItemDetailsClicked(args[0]);
                    }
                  },
                );

              },
              onLoadStart: (controller, url) {},
              onLoadStop: (controller, url) async {

                await controller.evaluateJavascript(source: """
    var meta = document.createElement('meta');
    meta.name = 'viewport';
    meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';
    document.getElementsByTagName('head')[0].appendChild(meta);
  """);

                if (url != null) {

                  if (url.toString() == "https://catalogue.gbjewelsync.com/login") {
                    await controller.loadUrl(
                      urlRequest: URLRequest(
                        url: WebUri("https://catalogue.gbjewelsync.com/login/NMG"),
                      ),
                    );
                  }
                  if (url.toString() == "https://catalogue.gbjewelsync.com/signup") {
                    await controller.loadUrl(
                      urlRequest: URLRequest(
                        url: WebUri("https://catalogue.gbjewelsync.com/signup/NMG"),
                      ),
                    );
                  }
                }
              },
            )
                : NoNetworkPage(onRetry: _checkNetworkConnectivity),
        ),
            // Splash screen overlay
            if (_isSplashVisible)
              Positioned.fill(
                child: Center(
                  child: Image.asset(
                    'assets/Splash.jpg',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
          ],
        )
      ),
    );
  }
  void _handleItemDetailsClicked(String dataHref) {
    if (Platform.isAndroid) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              WebViewScreen(mainUrl: dataHref),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      );
    }
  }
  Future<void> _openUrlInBrowser(String url) async {
    setState(() {
      _isSplashVisible = false; // Hide splash screen when this method is triggered

    });

    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
    } else {
      print("Could not launch $url");
    }
  }
  Future<void> _updateFcmToken(String token1) async {
    print("Hii Hello Method Called");
    final token = await FirebaseMessaging.instance.getToken();
    setState(() {
      _fcmToken = token;
    });
    print("FCM Token: $_fcmToken");

    setState(() {
      _fcmToken = token;
    });

    final Map<String, String> headers = {
      'Authorization': 'Bearer $token1',
    };

    print('here');
    print(_fcmToken);
    print("here is passed token : $token1");
    final response = await http.get(
        Uri.parse('https://catalogue.dashrathgold.com/api/catalogue/banners?device_token=$_fcmToken'), headers: headers);

    if (response.statusCode == 200) {
      print("token passed");
    }
  }




  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Future<void> setCookie() async {
  //   await cookieManager.setCookie(
  //     url: Uri.parse("https://catalogue.gbjewelsync.com/"),
  //     name: "flutter_app_code",
  //     value: "kng",
  //     domain: "catalogue.gbjewelsync.com",
  //     path: "/",
  //     isSecure: true,
  //     isHttpOnly: false,
  //     sameSite: HTTPCookieSameSite.LAX,
  //   );
  //
  //   print("Cookie set: $myCookieName = $myCookieValue");
  // }


  Future<String?> showFilePickerDialog() async {
    return await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select an Option"),
          content: Text("Would you like to use the Camera or File Picker?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop('camera');
              },
              child: Text("Camera"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop('file');
              },
              child: Text("File Picker"),
            ),
          ],
        );
      },
    );
  }

  Future<List<String>?> pickFile(String option) async {
    if (option == 'camera') {
      var status = await Permission.camera.request();
      if (!status.isGranted) return null;

      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.camera);
      return image != null ? [image.path] : null;
    } else if (option == 'file') {
      // var status = await Permission.manageExternalStorage.request();
      // if (!status.isGranted) return null;

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowCompression: true,
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        return result.files.map((file) => file.path!).toList();
      }
    }
    return null;
  }

  // void _handleItemDetailsClicked(String dataHref) {
  //   if (Platform.isAndroid) {
  //     Navigator.push(
  //       context,
  //       PageRouteBuilder(
  //         pageBuilder: (context, animation, secondaryAnimation) => WebViewScreen(initialUrl: dataHref),
  //         transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //           const begin = Offset(1.0, 0.0);
  //           const end = Offset.zero;
  //           const curve = Curves.easeInOut;
  //
  //           var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  //           var offsetAnimation = animation.drive(tween);
  //
  //           return SlideTransition(
  //             position: offsetAnimation,
  //             child: child,
  //           );
  //         },
  //       ),
  //     );
  //   }
  // }

  Future<String> convertFileToBase64(String filePath) async {
    File file = File(filePath);
    List<int> fileBytes = await file.readAsBytes();
    return base64Encode(fileBytes);
  }
}

class NoNetworkPage extends StatelessWidget {
  final VoidCallback onRetry;

  NoNetworkPage({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color for full screen
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off, size: 150, color: Colors.grey),
              // Bigger icon
              SizedBox(height: 30),
              Text(
                "No Internet Connection",
                style: TextStyle(fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "Please check your connection and try again.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text("Retry", style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



