// // // // // // // import 'dart:io';
// // // // // // // import 'dart:async';
// // // // // // // import 'package:flutter/material.dart';
// // // // // // // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // // // // // // import 'package:screen_protector/screen_protector.dart';
// // // // // // // import 'package:url_launcher/url_launcher.dart';
// // // // // // // import 'package:http/http.dart' as http;
// // // // // // // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // // // // // //
// // // // // // // void main() {
// // // // // // //   runApp(MyApp());
// // // // // // // }
// // // // // // //
// // // // // // // class MyApp extends StatelessWidget {
// // // // // // //   @override
// // // // // // //   Widget build(BuildContext context) {
// // // // // // //     return MaterialApp(
// // // // // // //       debugShowCheckedModeBanner: false,
// // // // // // //       title: 'KNG',
// // // // // // //       theme: ThemeData(
// // // // // // //         brightness: Brightness.light,
// // // // // // //         scaffoldBackgroundColor: Colors.white,
// // // // // // //         appBarTheme: AppBarTheme(
// // // // // // //           backgroundColor: Colors.white,
// // // // // // //           iconTheme: IconThemeData(color: Colors.black),
// // // // // // //           titleTextStyle: TextStyle(color: Colors.black),
// // // // // // //         ),
// // // // // // //         textTheme: TextTheme(
// // // // // // //           bodyLarge: TextStyle(color: Colors.black),
// // // // // // //         ),
// // // // // // //         colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
// // // // // // //       ),
// // // // // // //       home: SplashScreen(),
// // // // // // //     );
// // // // // // //   }
// // // // // // // }
// // // // // // //
// // // // // // // class SplashScreen extends StatefulWidget {
// // // // // // //   @override
// // // // // // //   _SplashScreenState createState() => _SplashScreenState();
// // // // // // // }
// // // // // // //
// // // // // // // class _SplashScreenState extends State<SplashScreen> {
// // // // // // //
// // // // // // //   bool _isWebViewLoaded = false;
// // // // // // //
// // // // // // //   @override
// // // // // // //   void initState() {
// // // // // // //     super.initState();
// // // // // // //
// // // // // // //
// // // // // // //
// // // // // // //     Timer(Duration(seconds: 3), () {
// // // // // // //       Navigator.pushReplacement(
// // // // // // //         context,
// // // // // // //         MaterialPageRoute(builder: (context) => WebViewScreen(mainUrl: 'https://catalogue.gbjewelsync.com')),
// // // // // // //       );
// // // // // // //     });
// // // // // // //
// // // // // // //
// // // // // // //   }
// // // // // // //
// // // // // // //   @override
// // // // // // //   Widget build(BuildContext context) {
// // // // // // //     double screenWidth = MediaQuery.of(context).size.width;
// // // // // // //     double screenHeight = MediaQuery.of(context).size.height;
// // // // // // //     return Scaffold(
// // // // // // //
// // // // // // //       backgroundColor: Colors.white,
// // // // // // //       body: Container(
// // // // // // //         child: Column(
// // // // // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // // // // //           children: [
// // // // // // //             Image.asset(
// // // // // // //               'assets/splash.gif',
// // // // // // //               // 'assets/logo 1.png',
// // // // // // //               width: screenWidth, // 80% of the screen width
// // // // // // //               height: screenHeight, // 40% of the screen height
// // // // // // //               fit: BoxFit.cover,
// // // // // // //             ),
// // // // // // //           ],
// // // // // // //         ),
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }
// // // // // // // }
// // // // // // //
// // // // // // // class WebViewScreen extends StatefulWidget {
// // // // // // //   final String mainUrl;
// // // // // // //   WebViewScreen({required this.mainUrl});
// // // // // // //
// // // // // // //   @override
// // // // // // //   _WebViewScreenState createState() => _WebViewScreenState();
// // // // // // // }
// // // // // // // class _WebViewScreenState extends State<WebViewScreen> {
// // // // // // //   late InAppWebViewController _webViewController;
// // // // // // //
// // // // // // //
// // // // // // //   @override
// // // // // // //   void initState() {
// // // // // // //     super.initState();
// // // // // // //
// // // // // // //     _enableScreenProtection();
// // // // // // //   }
// // // // // // //
// // // // // // //   Future<void> _enableScreenProtection() async {
// // // // // // //     try {
// // // // // // //       if (Platform.isAndroid) {
// // // // // // //         await ScreenProtector.protectDataLeakageOn();
// // // // // // //       } else if (Platform.isIOS) {
// // // // // // //         await ScreenProtector.preventScreenshotOn();
// // // // // // //       }
// // // // // // //     } catch (e) {
// // // // // // //       print("Error enabling screen protection: $e");
// // // // // // //     }
// // // // // // //   }
// // // // // // //
// // // // // // //   Future<void> _disableScreenProtection() async {
// // // // // // //     try {
// // // // // // //       if (Platform.isAndroid) {
// // // // // // //         await ScreenProtector.preventScreenshotOn();
// // // // // // //       } else if (Platform.isIOS) {
// // // // // // //         await ScreenProtector.preventScreenshotOn();
// // // // // // //       }
// // // // // // //     } catch (e) {
// // // // // // //       print("Error disabling screen protection: $e");
// // // // // // //     }
// // // // // // //   }
// // // // // // //
// // // // // // //   Future<bool> _onWillPop() async {
// // // // // // //     if (await _webViewController.canGoBack()) {
// // // // // // //       _webViewController.goBack();
// // // // // // //       return Future.value(false);
// // // // // // //     } else {
// // // // // // //       return Future.value(true);
// // // // // // //     }
// // // // // // //   }
// // // // // // //
// // // // // // //   @override
// // // // // // //   Widget build(BuildContext context) {
// // // // // // //     return WillPopScope(
// // // // // // //       onWillPop: _onWillPop,
// // // // // // //       child: Scaffold(
// // // // // // //         appBar: PreferredSize(
// // // // // // //           preferredSize: Size.fromHeight(0),
// // // // // // //           child: AppBar(
// // // // // // //             title: Text('KNG'),
// // // // // // //             centerTitle: true,
// // // // // // //           ),
// // // // // // //         ),
// // // // // // //         body: Stack(
// // // // // // //           children: [
// // // // // // //             InAppWebView(
// // // // // // //               initialUrlRequest: URLRequest(url: WebUri(widget.mainUrl)),
// // // // // // //               initialSettings: InAppWebViewSettings(
// // // // // // //                 supportZoom: false,
// // // // // // //                 useWideViewPort: true,
// // // // // // //                 builtInZoomControls: false,
// // // // // // //                 displayZoomControls: true,
// // // // // // //               ),
// // // // // // //               onWebViewCreated: (InAppWebViewController controller) {
// // // // // // //                 _webViewController = controller;
// // // // // // //
// // // // // // //                 // Register the JavaScript handler
// // // // // // //                 _webViewController.addJavaScriptHandler(
// // // // // // //                   handlerName: 'onItemDetailsClicked',
// // // // // // //                   callback: (args) {
// // // // // // //                     if (args.isNotEmpty) {
// // // // // // //                       _handleItemDetailsClicked(args[0]);
// // // // // // //                     }
// // // // // // //                   },
// // // // // // //                 );
// // // // // // //
// // // // // // //                 _webViewController.addJavaScriptHandler(
// // // // // // //                   handlerName: 'openUrlInBrowser',
// // // // // // //                   callback: (args) {
// // // // // // //                     if (args.isNotEmpty) {
// // // // // // //                       _openUrlInBrowser(args[0]); // Call the browser opening function
// // // // // // //                     }
// // // // // // //                   },
// // // // // // //                 );
// // // // // // //
// // // // // // //                 _webViewController.addJavaScriptHandler(
// // // // // // //                   handlerName: 'updateFcmToken',
// // // // // // //                   callback: (args) {
// // // // // // //                     if (args.isNotEmpty) {
// // // // // // //                       _updateFcmToken(args[0]); // Call the browser opening function
// // // // // // //                     }
// // // // // // //                   },
// // // // // // //                 );
// // // // // // //               },
// // // // // // //               onLoadStart: (InAppWebViewController controller, Uri? url) {
// // // // // // //
// // // // // // //               },
// // // // // // //               onLoadStop: (InAppWebViewController controller, Uri? url) async {
// // // // // // //
// // // // // // //                 if (url != null && url.toString() == "https://catalogue.gbjewelsync.com/login") {
// // // // // // //                   await controller.loadUrl(
// // // // // // //                     urlRequest: URLRequest(url: WebUri("https://catalogue.gbjewelsync.com/login/KNG")),
// // // // // // //                   );
// // // // // // //                 }
// // // // // // //                 if (url != null && url.toString() == "https://catalogue.gbjewelsync.com/signup") {
// // // // // // //                   await controller.loadUrl(
// // // // // // //                     urlRequest: URLRequest(url: WebUri("https://catalogue.gbjewelsync.com/signup/KNG")),
// // // // // // //                   );
// // // // // // //                 }
// // // // // // //                 print("Finished loading: $url");
// // // // // // //               },
// // // // // // //             ),
// // // // // // //
// // // // // // //           ],
// // // // // // //         ),
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }
// // // // // // //
// // // // // // //   void _handleItemDetailsClicked(String dataHref) {
// // // // // // //     if (Platform.isAndroid) {
// // // // // // //       Navigator.push(
// // // // // // //         context,
// // // // // // //         PageRouteBuilder(
// // // // // // //           pageBuilder: (context, animation, secondaryAnimation) =>
// // // // // // //               WebViewScreen(mainUrl: dataHref),
// // // // // // //           transitionsBuilder: (context, animation, secondaryAnimation, child) {
// // // // // // //             const begin = Offset(1.0, 0.0);
// // // // // // //             const end = Offset.zero;
// // // // // // //             const curve = Curves.easeInOut;
// // // // // // //
// // // // // // //             var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
// // // // // // //             var offsetAnimation = animation.drive(tween);
// // // // // // //
// // // // // // //             return SlideTransition(
// // // // // // //               position: offsetAnimation,
// // // // // // //               child: child,
// // // // // // //             );
// // // // // // //           },
// // // // // // //         ),
// // // // // // //       );
// // // // // // //     }
// // // // // // //   }
// // // // // // //
// // // // // // //   Future<void> _openUrlInBrowser(String url) async {
// // // // // // //     final Uri uri = Uri.parse(url);
// // // // // // //
// // // // // // //     if (await canLaunchUrl(uri)) {
// // // // // // //       await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
// // // // // // //     }
// // // // // // //   }
// // // // // // //
// // // // // // //   Future<void> _updateFcmToken(String token) async {
// // // // // // //     print("Hello this is token: "+token);
// // // // // // //
// // // // // // //     String? _fcmToken;
// // // // // // //
// // // // // // //     // final token1 = await NotificationService.instance.getFCMToken();
// // // // // // //     // setState(() {
// // // // // // //     //   _fcmToken = token1;
// // // // // // //     // });
// // // // // // //
// // // // // // //     final Map<String, String> headers = {
// // // // // // //       'Authorization': 'Bearer $token',
// // // // // // //     };
// // // // // // //
// // // // // // //     final response = await http.get(
// // // // // // //         Uri.parse('https://gbjewelsync.com/api/catalogue/banners?device_token=$_fcmToken'), headers: headers);
// // // // // // //
// // // // // // //     if (response.statusCode == 200) {
// // // // // // //       //
// // // // // // //     }
// // // // // // //   }
// // // // // // //
// // // // // // //   @override
// // // // // // //   void dispose() {
// // // // // // //     _disableScreenProtection();
// // // // // // //     super.dispose();
// // // // // // //   }
// // // // // // // }
// // // // // //
// // // // // //
// // // // // // import 'dart:io';
// // // // // // import 'dart:async';
// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // // // // // import 'package:screen_protector/screen_protector.dart';
// // // // // // import 'package:url_launcher/url_launcher.dart';
// // // // // // import 'package:http/http.dart' as http;
// // // // // // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // // // // //
// // // // // // void main() {
// // // // // //   runApp(MyApp());
// // // // // // }
// // // // // //
// // // // // // class MyApp extends StatelessWidget {
// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return MaterialApp(
// // // // // //       debugShowCheckedModeBanner: false,
// // // // // //       title: 'KNG',
// // // // // //       theme: ThemeData(
// // // // // //         brightness: Brightness.light,
// // // // // //         scaffoldBackgroundColor: Colors.white,
// // // // // //         appBarTheme: AppBarTheme(
// // // // // //           backgroundColor: Colors.white,
// // // // // //           iconTheme: IconThemeData(color: Colors.black),
// // // // // //           titleTextStyle: TextStyle(color: Colors.black),
// // // // // //         ),
// // // // // //         textTheme: TextTheme(
// // // // // //           bodyLarge: TextStyle(color: Colors.black),
// // // // // //         ),
// // // // // //         colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
// // // // // //       ),
// // // // // //       home: WebViewScreen(mainUrl: 'https://catalogue.gbjewelsync.com'),
// // // // // //     );
// // // // // //   }
// // // // // // }
// // // // // //
// // // // // // class SplashScreen extends StatefulWidget {
// // // // // //   @override
// // // // // //   _SplashScreenState createState() => _SplashScreenState();
// // // // // // }
// // // // // //
// // // // // // class _SplashScreenState extends State<SplashScreen> {
// // // // // //
// // // // // //   bool _isWebViewLoaded = false;
// // // // // //
// // // // // //   @override
// // // // // //   void initState() {
// // // // // //     super.initState();
// // // // // //
// // // // // //
// // // // // //
// // // // // //     Timer(Duration(seconds: 3), () {
// // // // // //       Navigator.pushReplacement(
// // // // // //         context,
// // // // // //         MaterialPageRoute(builder: (context) => WebViewScreen(mainUrl: 'https://catalogue.gbjewelsync.com')),
// // // // // //       );
// // // // // //     });
// // // // // //
// // // // // //
// // // // // //   }
// // // // // //
// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     double screenWidth = MediaQuery.of(context).size.width;
// // // // // //     double screenHeight = MediaQuery.of(context).size.height;
// // // // // //     return Scaffold(
// // // // // //
// // // // // //       backgroundColor: Colors.white,
// // // // // //       body: Container(
// // // // // //         child: Column(
// // // // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // // // //           children: [
// // // // // //             Image.asset(
// // // // // //               'assets/splash.gif',
// // // // // //               // 'assets/logo 1.png',
// // // // // //               width: screenWidth, // 80% of the screen width
// // // // // //               height: screenHeight, // 40% of the screen height
// // // // // //               fit: BoxFit.cover,
// // // // // //             ),
// // // // // //           ],
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // // }
// // // // // //
// // // // // // class WebViewScreen extends StatefulWidget {
// // // // // //   final String mainUrl;
// // // // // //   WebViewScreen({required this.mainUrl});
// // // // // //
// // // // // //   @override
// // // // // //   _WebViewScreenState createState() => _WebViewScreenState();
// // // // // // }
// // // // // // class _WebViewScreenState extends State<WebViewScreen> {
// // // // // //   late InAppWebViewController _webViewController;
// // // // // //
// // // // // //
// // // // // //   @override
// // // // // //   void initState() {
// // // // // //     super.initState();
// // // // // //
// // // // // //     _enableScreenProtection();
// // // // // //   }
// // // // // //
// // // // // //   Future<void> _enableScreenProtection() async {
// // // // // //     try {
// // // // // //       if (Platform.isAndroid) {
// // // // // //         await ScreenProtector.protectDataLeakageOn();
// // // // // //       } else if (Platform.isIOS) {
// // // // // //         await ScreenProtector.preventScreenshotOn();
// // // // // //       }
// // // // // //     } catch (e) {
// // // // // //       print("Error enabling screen protection: $e");
// // // // // //     }
// // // // // //   }
// // // // // //
// // // // // //   Future<void> _disableScreenProtection() async {
// // // // // //     try {
// // // // // //       if (Platform.isAndroid) {
// // // // // //         await ScreenProtector.preventScreenshotOn();
// // // // // //       } else if (Platform.isIOS) {
// // // // // //         await ScreenProtector.preventScreenshotOn();
// // // // // //       }
// // // // // //     } catch (e) {
// // // // // //       print("Error disabling screen protection: $e");
// // // // // //     }
// // // // // //   }
// // // // // //
// // // // // //   Future<bool> _onWillPop() async {
// // // // // //     if (await _webViewController.canGoBack()) {
// // // // // //       _webViewController.goBack();
// // // // // //       return Future.value(false);
// // // // // //     } else {
// // // // // //       return Future.value(true);
// // // // // //     }
// // // // // //   }
// // // // // //
// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return WillPopScope(
// // // // // //       onWillPop: _onWillPop,
// // // // // //       child: Scaffold(
// // // // // //         appBar: PreferredSize(
// // // // // //           preferredSize: Size.fromHeight(0),
// // // // // //           child: AppBar(
// // // // // //             title: Text('KNG'),
// // // // // //             centerTitle: true,
// // // // // //           ),
// // // // // //         ),
// // // // // //         body: Stack(
// // // // // //           children: [
// // // // // //             InAppWebView(
// // // // // //               initialUrlRequest: URLRequest(url: WebUri(widget.mainUrl)),
// // // // // //               initialSettings: InAppWebViewSettings(
// // // // // //                 supportZoom: false,
// // // // // //                 useWideViewPort: true,
// // // // // //                 builtInZoomControls: false,
// // // // // //                 displayZoomControls: true,
// // // // // //               ),
// // // // // //               onWebViewCreated: (InAppWebViewController controller) {
// // // // // //                 _webViewController = controller;
// // // // // //
// // // // // //                 // Register the JavaScript handler
// // // // // //                 _webViewController.addJavaScriptHandler(
// // // // // //                   handlerName: 'onItemDetailsClicked',
// // // // // //                   callback: (args) {
// // // // // //                     if (args.isNotEmpty) {
// // // // // //                       _handleItemDetailsClicked(args[0]);
// // // // // //                     }
// // // // // //                   },
// // // // // //                 );
// // // // // //
// // // // // //                 _webViewController.addJavaScriptHandler(
// // // // // //                   handlerName: 'openUrlInBrowser',
// // // // // //                   callback: (args) {
// // // // // //                     if (args.isNotEmpty) {
// // // // // //                       _openUrlInBrowser(args[0]); // Call the browser opening function
// // // // // //                     }
// // // // // //                   },
// // // // // //                 );
// // // // // //
// // // // // //                 _webViewController.addJavaScriptHandler(
// // // // // //                   handlerName: 'updateFcmToken',
// // // // // //                   callback: (args) {
// // // // // //                     if (args.isNotEmpty) {
// // // // // //                       _updateFcmToken(args[0]); // Call the browser opening function
// // // // // //                     }
// // // // // //                   },
// // // // // //                 );
// // // // // //               },
// // // // // //               onLoadStart: (InAppWebViewController controller, Uri? url) {
// // // // // //
// // // // // //               },
// // // // // //               onLoadStop: (InAppWebViewController controller, Uri? url) async {
// // // // // //
// // // // // //                 if (url != null && url.toString() == "https://catalogue.gbjewelsync.com/login") {
// // // // // //                   await controller.loadUrl(
// // // // // //                     urlRequest: URLRequest(url: WebUri("https://catalogue.gbjewelsync.com/login/KNG")),
// // // // // //                   );
// // // // // //                 }
// // // // // //                 if (url != null && url.toString() == "https://catalogue.gbjewelsync.com/signup") {
// // // // // //                   await controller.loadUrl(
// // // // // //                     urlRequest: URLRequest(url: WebUri("https://catalogue.gbjewelsync.com/signup/KNG")),
// // // // // //                   );
// // // // // //                 }
// // // // // //                 print("Finished loading: $url");
// // // // // //               },
// // // // // //             ),
// // // // // //
// // // // // //           ],
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // //
// // // // // //   void _handleItemDetailsClicked(String dataHref) {
// // // // // //     if (Platform.isAndroid) {
// // // // // //       Navigator.push(
// // // // // //         context,
// // // // // //         PageRouteBuilder(
// // // // // //           pageBuilder: (context, animation, secondaryAnimation) =>
// // // // // //               WebViewScreen(mainUrl: dataHref),
// // // // // //           transitionsBuilder: (context, animation, secondaryAnimation, child) {
// // // // // //             const begin = Offset(1.0, 0.0);
// // // // // //             const end = Offset.zero;
// // // // // //             const curve = Curves.easeInOut;
// // // // // //
// // // // // //             var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
// // // // // //             var offsetAnimation = animation.drive(tween);
// // // // // //
// // // // // //             return SlideTransition(
// // // // // //               position: offsetAnimation,
// // // // // //               child: child,
// // // // // //             );
// // // // // //           },
// // // // // //         ),
// // // // // //       );
// // // // // //     }
// // // // // //   }
// // // // // //
// // // // // //   Future<void> _openUrlInBrowser(String url) async {
// // // // // //     final Uri uri = Uri.parse(url);
// // // // // //
// // // // // //     if (await canLaunchUrl(uri)) {
// // // // // //       await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
// // // // // //     }
// // // // // //   }
// // // // // //
// // // // // //   Future<void> _updateFcmToken(String token) async {
// // // // // //     print("Hello this is token: "+token);
// // // // // //
// // // // // //     String? _fcmToken;
// // // // // //
// // // // // //     // final token1 = await NotificationService.instance.getFCMToken();
// // // // // //     // setState(() {
// // // // // //     //   _fcmToken = token1;
// // // // // //     // });
// // // // // //
// // // // // //     final Map<String, String> headers = {
// // // // // //       'Authorization': 'Bearer $token',
// // // // // //     };
// // // // // //
// // // // // //     final response = await http.get(
// // // // // //         Uri.parse('https://gbjewelsync.com/api/catalogue/banners?device_token=$_fcmToken'), headers: headers);
// // // // // //
// // // // // //     if (response.statusCode == 200) {
// // // // // //       //
// // // // // //     }
// // // // // //   }
// // // // // //
// // // // // //   @override
// // // // // //   void dispose() {
// // // // // //     _disableScreenProtection();
// // // // // //     super.dispose();
// // // // // //   }
// // // // // // }
// // // // //
// // // // //
// // // // // import 'dart:io';
// // // // // import 'dart:async';
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // // // // import 'package:screen_protector/screen_protector.dart';
// // // // // import 'package:url_launcher/url_launcher.dart';
// // // // // import 'package:http/http.dart' as http;
// // // // // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // // // //
// // // // // void main() {
// // // // //   runApp(MyApp());
// // // // // }
// // // // //
// // // // // class MyApp extends StatelessWidget {
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return MaterialApp(
// // // // //       debugShowCheckedModeBanner: false,
// // // // //       title: 'KNG',
// // // // //       theme: ThemeData(
// // // // //         brightness: Brightness.light,
// // // // //         scaffoldBackgroundColor: Colors.white,
// // // // //         appBarTheme: AppBarTheme(
// // // // //           backgroundColor: Colors.white,
// // // // //           iconTheme: IconThemeData(color: Colors.black),
// // // // //           titleTextStyle: TextStyle(color: Colors.black),
// // // // //         ),
// // // // //         textTheme: TextTheme(
// // // // //           bodyLarge: TextStyle(color: Colors.black),
// // // // //         ),
// // // // //         colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
// // // // //       ),
// // // // //       home: WebViewScreen(mainUrl: 'https://catalogue.gbjewelsync.com'),
// // // // //     );
// // // // //   }
// // // // // }
// // // // // class WebViewScreen extends StatefulWidget {
// // // // //   final String mainUrl;
// // // // //   WebViewScreen({required this.mainUrl});
// // // // //
// // // // //   @override
// // // // //   _WebViewScreenState createState() => _WebViewScreenState();
// // // // // }
// // // // //
// // // // // class _WebViewScreenState extends State<WebViewScreen> {
// // // // //   late InAppWebViewController _webViewController;
// // // // //   bool _isWebViewLoaded = false;
// // // // //   bool _isSplashVisible = true;
// // // // //
// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     _startSplashTimer();
// // // // //     _enableScreenProtection();
// // // // //   }
// // // // //
// // // // //   void _startSplashTimer() {
// // // // //     Future.delayed(Duration(seconds: 3), () {
// // // // //       setState(() {
// // // // //         _isSplashVisible = false;
// // // // //       });
// // // // //     });
// // // // //   }
// // // // //
// // // // //   Future<void> _enableScreenProtection() async {
// // // // //     try {
// // // // //       if (Platform.isAndroid) {
// // // // //         await ScreenProtector.protectDataLeakageOn();
// // // // //       } else if (Platform.isIOS) {
// // // // //         await ScreenProtector.preventScreenshotOn();
// // // // //       }
// // // // //     } catch (e) {
// // // // //       print("Error enabling screen protection: $e");
// // // // //     }
// // // // //   }
// // // // //
// // // // //   Future<void> _disableScreenProtection() async {
// // // // //     try {
// // // // //       if (Platform.isAndroid) {
// // // // //         await ScreenProtector.preventScreenshotOn();
// // // // //       } else if (Platform.isIOS) {
// // // // //         await ScreenProtector.preventScreenshotOn();
// // // // //       }
// // // // //     } catch (e) {
// // // // //       print("Error disabling screen protection: $e");
// // // // //     }
// // // // //   }
// // // // //
// // // // //   Future<bool> _onWillPop() async {
// // // // //     if (await _webViewController.canGoBack()) {
// // // // //       _webViewController.goBack();
// // // // //       return Future.value(false);
// // // // //     } else {
// // // // //       return Future.value(true);
// // // // //     }
// // // // //   }
// // // // //
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return WillPopScope(
// // // // //       onWillPop: _onWillPop,
// // // // //       child: Scaffold(
// // // // //         body: Stack(
// // // // //           children: [
// // // // //             // WebView
// // // // //             InAppWebView(
// // // // //               initialUrlRequest: URLRequest(url: WebUri(widget.mainUrl)),
// // // // //               initialSettings: InAppWebViewSettings(
// // // // //                 supportZoom: false,
// // // // //                 useWideViewPort: true,
// // // // //                 builtInZoomControls: false,
// // // // //                 displayZoomControls: true,
// // // // //               ),
// // // // //               onWebViewCreated: (InAppWebViewController controller) {
// // // // //                 _webViewController = controller;
// // // // //               },
// // // // //               onLoadStart: (controller, url) {
// // // // //                 setState(() {
// // // // //                   _isWebViewLoaded = false; // Show splash screen while loading
// // // // //                 });
// // // // //               },
// // // // //               onLoadStop: (controller, url) async {
// // // // //                 setState(() {
// // // // //                   _isWebViewLoaded = true; // Hide splash when loading completes
// // // // //                 });
// // // // //               },
// // // // //             ),
// // // // //             // Splash Screen
// // // // //             if (_isSplashVisible)
// // // // //               Center(
// // // // //                 child: Image.asset(
// // // // //                   'assets/splash.gif',
// // // // //                   width: MediaQuery.of(context).size.width,
// // // // //                   height: MediaQuery.of(context).size.height,
// // // // //                   fit: BoxFit.cover,
// // // // //                 ),
// // // // //               ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // //
// // // // //   @override
// // // // //   void dispose() {
// // // // //     _disableScreenProtection();
// // // // //     super.dispose();
// // // // //   }
// // // // // }
// // // //
// // // //
// // // // import 'dart:io';
// // // // import 'dart:async';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // // // import 'package:screen_protector/screen_protector.dart';
// // // // import 'package:url_launcher/url_launcher.dart';
// // // // import 'package:http/http.dart' as http;
// // // // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // // //
// // // // void main() {
// // // //   runApp(MyApp());
// // // // }
// // // //
// // // // class MyApp extends StatelessWidget {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return MaterialApp(
// // // //       debugShowCheckedModeBanner: false,
// // // //       title: 'KNG',
// // // //       theme: ThemeData(
// // // //         brightness: Brightness.light,
// // // //         scaffoldBackgroundColor: Colors.white,
// // // //         appBarTheme: AppBarTheme(
// // // //           backgroundColor: Colors.white,
// // // //           iconTheme: IconThemeData(color: Colors.black),
// // // //           titleTextStyle: TextStyle(color: Colors.black),
// // // //         ),
// // // //         textTheme: TextTheme(
// // // //           bodyLarge: TextStyle(color: Colors.black),
// // // //         ),
// // // //         colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
// // // //       ),
// // // //       home: WebViewScreen(mainUrl: 'https://catalogue.gbjewelsync.com'),
// // // //     );
// // // //   }
// // // // }
// // // // class WebViewScreen extends StatefulWidget {
// // // //   final String mainUrl;
// // // //   WebViewScreen({required this.mainUrl});
// // // //
// // // //   @override
// // // //   _WebViewScreenState createState() => _WebViewScreenState();
// // // // }
// // // //
// // // // class _WebViewScreenState extends State<WebViewScreen> {
// // // //   late InAppWebViewController _webViewController;
// // // //   bool _isWebViewLoaded = false;
// // // //   bool _isSplashVisible = true;
// // // //
// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     _startSplashTimer();
// // // //     _enableScreenProtection();
// // // //   }
// // // //
// // // //   void _startSplashTimer() {
// // // //     Future.delayed(Duration(seconds: 3), () {
// // // //       setState(() {
// // // //         _isSplashVisible = false;
// // // //       });
// // // //     });
// // // //   }
// // // //
// // // //   Future<void> _enableScreenProtection() async {
// // // //     try {
// // // //       if (Platform.isAndroid) {
// // // //         await ScreenProtector.protectDataLeakageOn();
// // // //       } else if (Platform.isIOS) {
// // // //         await ScreenProtector.preventScreenshotOn();
// // // //       }
// // // //     } catch (e) {
// // // //       print("Error enabling screen protection: $e");
// // // //     }
// // // //   }
// // // //
// // // //   Future<void> _disableScreenProtection() async {
// // // //     try {
// // // //       if (Platform.isAndroid) {
// // // //         await ScreenProtector.preventScreenshotOn();
// // // //       } else if (Platform.isIOS) {
// // // //         await ScreenProtector.preventScreenshotOn();
// // // //       }
// // // //     } catch (e) {
// // // //       print("Error disabling screen protection: $e");
// // // //     }
// // // //   }
// // // //
// // // //   Future<bool> _onWillPop() async {
// // // //     if (await _webViewController.canGoBack()) {
// // // //       _webViewController.goBack();
// // // //       return Future.value(false);
// // // //     } else {
// // // //       return Future.value(true);
// // // //     }
// // // //   }
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return WillPopScope(
// // // //       onWillPop: _onWillPop,
// // // //       child: Scaffold(
// // // //         body: Stack(
// // // //           children: [
// // // //             // WebView
// // // //             InAppWebView(
// // // //               initialUrlRequest: URLRequest(url: WebUri(widget.mainUrl)),
// // // //               initialSettings: InAppWebViewSettings(
// // // //                 supportZoom: false,
// // // //                 useWideViewPort: true,
// // // //                 builtInZoomControls: false,
// // // //                 displayZoomControls: true,
// // // //               ),
// // // //               onWebViewCreated: (InAppWebViewController controller) {
// // // //                 _webViewController = controller;
// // // //
// // // //                 // Register the JavaScript handler
// // // //                 _webViewController.addJavaScriptHandler(
// // // //                   handlerName: 'onItemDetailsClicked',
// // // //                   callback: (args) {
// // // //                     if (args.isNotEmpty) {
// // // //                       _handleItemDetailsClicked(args[0]);
// // // //                     }
// // // //                   },
// // // //                 );
// // // //
// // // //                 _webViewController.addJavaScriptHandler(
// // // //                   handlerName: 'openUrlInBrowser',
// // // //                   callback: (args) {
// // // //                     if (args.isNotEmpty) {
// // // //                       _openUrlInBrowser(args[0]); // Call the browser opening function
// // // //                     }
// // // //                   },
// // // //                 );
// // // //
// // // //                 _webViewController.addJavaScriptHandler(
// // // //                   handlerName: 'updateFcmToken',
// // // //                   callback: (args) {
// // // //                     if (args.isNotEmpty) {
// // // //                       _updateFcmToken(args[0]); // Call the browser opening function
// // // //                     }
// // // //                   },
// // // //                 );
// // // //               },
// // // //               onLoadStart: (InAppWebViewController controller, Uri? url) {
// // // //
// // // //               },
// // // //               onLoadStop: (InAppWebViewController controller, Uri? url) async {
// // // //
// // // //                 if (url != null && url.toString() == "https://catalogue.gbjewelsync.com/login") {
// // // //                   await controller.loadUrl(
// // // //                     urlRequest: URLRequest(url: WebUri("https://catalogue.gbjewelsync.com/login/KNG")),
// // // //                   );
// // // //                 }
// // // //                 if (url != null && url.toString() == "https://catalogue.gbjewelsync.com/signup") {
// // // //                   await controller.loadUrl(
// // // //                     urlRequest: URLRequest(url: WebUri("https://catalogue.gbjewelsync.com/signup/KNG")),
// // // //                   );
// // // //                 }
// // // //                 print("Finished loading: $url");
// // // //               },
// // // //             ),
// // // //             // Splash Screen
// // // //             if (_isSplashVisible)
// // // //               Center(
// // // //                 child: Image.asset(
// // // //                   'assets/splash.gif',
// // // //                   width: MediaQuery.of(context).size.width,
// // // //                   height: MediaQuery.of(context).size.height,
// // // //                   fit: BoxFit.cover,
// // // //                 ),
// // // //               ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // //   void _handleItemDetailsClicked(String dataHref) {
// // // //     if (Platform.isAndroid) {
// // // //       Navigator.push(
// // // //         context,
// // // //         PageRouteBuilder(
// // // //           pageBuilder: (context, animation, secondaryAnimation) =>
// // // //               WebViewScreen(mainUrl: dataHref),
// // // //           transitionsBuilder: (context, animation, secondaryAnimation, child) {
// // // //             const begin = Offset(1.0, 0.0);
// // // //             const end = Offset.zero;
// // // //             const curve = Curves.easeInOut;
// // // //
// // // //             var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
// // // //             var offsetAnimation = animation.drive(tween);
// // // //
// // // //             return SlideTransition(
// // // //               position: offsetAnimation,
// // // //               child: child,
// // // //             );
// // // //           },
// // // //         ),
// // // //       );
// // // //     }
// // // //   }
// // // //
// // // //   Future<void> _openUrlInBrowser(String url) async {
// // // //     final Uri uri = Uri.parse(url);
// // // //
// // // //     if (await canLaunchUrl(uri)) {
// // // //       await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
// // // //     }
// // // //   }
// // // //
// // // //   Future<void> _updateFcmToken(String token) async {
// // // //     print("Hello this is token: "+token);
// // // //
// // // //     String? _fcmToken;
// // // //
// // // //     // final token1 = await NotificationService.instance.getFCMToken();
// // // //     // setState(() {
// // // //     //   _fcmToken = token1;
// // // //     // });
// // // //
// // // //     final Map<String, String> headers = {
// // // //       'Authorization': 'Bearer $token',
// // // //     };
// // // //
// // // //     final response = await http.get(
// // // //         Uri.parse('https://gbjewelsync.com/api/catalogue/banners?device_token=$_fcmToken'), headers: headers);
// // // //
// // // //     if (response.statusCode == 200) {
// // // //       //
// // // //     }
// // // //   }
// // // //
// // // //   @override
// // // //   void dispose() {
// // // //     _disableScreenProtection();
// // // //     super.dispose();
// // // //   }
// // // // }
// // //
// // // import 'package:connectivity_plus/connectivity_plus.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // // import 'package:screen_protector/screen_protector.dart';
// // // import 'dart:async';
// // // import 'dart:io';
// // // import 'package:url_launcher/url_launcher.dart';
// // // import 'package:http/http.dart' as http;
// // //
// // //
// // // void main() {
// // //   runApp(MyApp());
// // // }
// // //
// // // class MyApp extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       debugShowCheckedModeBanner: false,
// // //       title: 'KNG',
// // //       theme: ThemeData(
// // //         brightness: Brightness.light,
// // //         scaffoldBackgroundColor: Colors.white,
// // //         appBarTheme: AppBarTheme(
// // //           backgroundColor: Colors.white,
// // //           iconTheme: IconThemeData(color: Colors.black),
// // //           titleTextStyle: TextStyle(color: Colors.black),
// // //         ),
// // //         textTheme: TextTheme(
// // //           bodyLarge: TextStyle(color: Colors.black),
// // //         ),
// // //         colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
// // //       ),
// // //       home: WebViewScreen(mainUrl: 'https://catalogue.gbjewelsync.com'),
// // //     );
// // //   }
// // // }
// // //
// // // class WebViewScreen extends StatefulWidget {
// // //   final String mainUrl;
// // //   WebViewScreen({required this.mainUrl});
// // //
// // //   @override
// // //   _WebViewScreenState createState() => _WebViewScreenState();
// // // }
// // //
// // // class _WebViewScreenState extends State<WebViewScreen> {
// // //   late InAppWebViewController _webViewController;
// // //   bool _isWebViewLoaded = false;
// // //   bool _isSplashVisible = true;
// // //   bool _isNetworkAvailable = true;
// // //   late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
// // //
// // //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _startSplashTimer();
// // //     _enableScreenProtection();
// // //     _checkNetworkConnectivity();
// // //     _connectivitySubscription = Connectivity().onConnectivityChanged.listen((result) {
// // //       if (result.isNotEmpty) {
// // //         _updateNetworkStatus(result.first); // Handle first result
// // //       }
// // //     });
// // //   }
// // //
// // //   void _startSplashTimer() {
// // //     Future.delayed(Duration(seconds: 3), () {
// // //       setState(() {
// // //         _isSplashVisible = false;
// // //       });
// // //     });
// // //   }
// // //
// // //   Future<void> _enableScreenProtection() async {
// // //     try {
// // //       if (Platform.isAndroid) {
// // //         await ScreenProtector.protectDataLeakageOn();
// // //       } else if (Platform.isIOS) {
// // //         await ScreenProtector.preventScreenshotOn();
// // //       }
// // //     } catch (e) {
// // //       print("Error enabling screen protection: $e");
// // //     }
// // //   }
// // //
// // //   Future<void> _disableScreenProtection() async {
// // //     try {
// // //       if (Platform.isAndroid) {
// // //         await ScreenProtector.preventScreenshotOn();
// // //       } else if (Platform.isIOS) {
// // //         await ScreenProtector.preventScreenshotOn();
// // //       }
// // //     } catch (e) {
// // //       print("Error disabling screen protection: $e");
// // //     }
// // //   }
// // //
// // //   void _updateNetworkStatus(ConnectivityResult result) {
// // //     setState(() {
// // //       _isNetworkAvailable = result != ConnectivityResult.none; // Check for network availability
// // //     });
// // //   }
// // //
// // //   Future<void> _checkNetworkConnectivity() async {
// // //     // Getting the connectivity result, which may be a List of ConnectivityResult
// // //     final List<ConnectivityResult> connectivityResults = await Connectivity().checkConnectivity();
// // //
// // //     // Assuming we are just interested in the first item in the list (if the list is non-empty)
// // //     if (connectivityResults.isNotEmpty) {
// // //       _updateNetworkStatus(connectivityResults.first);  // Update with the first result in the list
// // //     }
// // //   }
// // //
// // //   Future<bool> _onWillPop() async {
// // //     if (await _webViewController.canGoBack()) {
// // //       _webViewController.goBack();
// // //       return Future.value(false); // Prevent app from exiting if WebView can go back
// // //     } else {
// // //       // Show confirmation dialog
// // //       bool shouldExit = await showDialog(
// // //         context: context,
// // //         builder: (BuildContext context) {
// // //           return AlertDialog(
// // //             title: Text("Exit App"),
// // //             content: Text("Are you sure you want to exit the app?"),
// // //             actions: [
// // //               TextButton(
// // //                 onPressed: () {
// // //                   Navigator.of(context).pop(false); // User pressed "No"
// // //                 },
// // //                 child: Text("No"),
// // //               ),
// // //               TextButton(
// // //                 onPressed: () {
// // //                   Navigator.of(context).pop(true); // User pressed "Yes"
// // //                 },
// // //                 child: Text("Yes"),
// // //               ),
// // //             ],
// // //           );
// // //         },
// // //       );
// // //
// // //       return shouldExit ?? false; // Exit the app if the user confirms
// // //     }
// // //   }
// // //
// // //
// // //   // Future<bool> _onWillPop() async {
// // //   //   if (await _webViewController.canGoBack()) {
// // //   //     _webViewController.goBack();
// // //   //     return Future.value(false);
// // //   //   } else {
// // //   //
// // //   //     return Future.value(true);
// // //   //   }
// // //   // }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return WillPopScope(
// // //       onWillPop: _onWillPop,
// // //       child: Scaffold(
// // //         appBar: PreferredSize(
// // //           preferredSize: Size.fromHeight(0),
// // //           child: AppBar(
// // //             title: Text('KNG'),
// // //             centerTitle: true,
// // //           ),
// // //         ),
// // //         body: Stack(
// // //           children: [
// // //             // Main content (WebView or NoNetworkPage)
// // //             AnimatedSwitcher(
// // //               duration: Duration(milliseconds: 300),
// // //               child: _isNetworkAvailable
// // //                   ? Container(
// // //                 key: ValueKey('WebView'),
// // //                 child: InAppWebView(
// // //                   initialUrlRequest: URLRequest(url: WebUri(widget.mainUrl)),
// // //                   initialSettings: InAppWebViewSettings(
// // //                     supportZoom: false,
// // //                     useWideViewPort: true,
// // //                     builtInZoomControls: false,
// // //                     displayZoomControls: true,
// // //                   ),
// // //                   onWebViewCreated: (InAppWebViewController controller) {
// // //                     _webViewController = controller;
// // //                     // Register the JavaScript handler
// // //                 _webViewController.addJavaScriptHandler(
// // //                   handlerName: 'onItemDetailsClicked',
// // //                   callback: (args) {
// // //                     if (args.isNotEmpty) {
// // //                       _handleItemDetailsClicked(args[0]);
// // //                     }
// // //                   },
// // //                 );
// // //
// // //                 _webViewController.addJavaScriptHandler(
// // //                   handlerName: 'openUrlInBrowser',
// // //                   callback: (args) {
// // //                     if (args.isNotEmpty) {
// // //                       _openUrlInBrowser(args[0]); // Call the browser opening function
// // //                     }
// // //                   },
// // //                 );
// // //
// // //                   },
// // //                   onLoadStart: (InAppWebViewController controller, Uri? url) {},
// // //                   onLoadStop: (InAppWebViewController controller, Uri? url) async {
// // //                     if (url != null && url.toString() == "https://catalogue.gbjewelsync.com/login") {
// // //                       await controller.loadUrl(
// // //                         urlRequest: URLRequest(url: WebUri("https://catalogue.gbjewelsync.com/login/KNG")),
// // //                       );
// // //                     }
// // //                     if (url != null && url.toString() == "https://catalogue.gbjewelsync.com/signup") {
// // //                       await controller.loadUrl(
// // //                         urlRequest: URLRequest(url: WebUri("https://catalogue.gbjewelsync.com/signup/KNG")),
// // //                       );
// // //                     }
// // //                   },
// // //                 ),
// // //               )
// // //                   : Container(
// // //                 key: ValueKey('NoNetwork'),
// // //                 child: NoNetworkPage(
// // //                   onRetry: _checkNetworkConnectivity,
// // //                 ),
// // //               ),
// // //             ),
// // //
// // //             // Splash screen overlay
// // //             if (_isSplashVisible)
// // //               Positioned.fill(
// // //                 child: Center(
// // //                   child: Image.asset(
// // //                     'assets/splash.gif',
// // //                     width: MediaQuery.of(context).size.width,
// // //                     height: MediaQuery.of(context).size.height,
// // //                     fit: BoxFit.cover,
// // //                   ),
// // //                 ),
// // //               ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //
// // //   void _handleItemDetailsClicked(String dataHref) {
// // //     if (Platform.isAndroid) {
// // //       Navigator.push(
// // //         context,
// // //         PageRouteBuilder(
// // //           pageBuilder: (context, animation, secondaryAnimation) =>
// // //               WebViewScreen(mainUrl: dataHref),
// // //           transitionsBuilder: (context, animation, secondaryAnimation, child) {
// // //             const begin = Offset(1.0, 0.0);
// // //             const end = Offset.zero;
// // //             const curve = Curves.easeInOut;
// // //
// // //             var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
// // //             var offsetAnimation = animation.drive(tween);
// // //
// // //             return SlideTransition(
// // //               position: offsetAnimation,
// // //               child: child,
// // //             );
// // //           },
// // //         ),
// // //       );
// // //     }
// // //   }
// // //
// // //   Future<void> _openUrlInBrowser(String url) async {
// // //     final Uri uri = Uri.parse(url);
// // //
// // //     if (await canLaunchUrl(uri)) {
// // //       await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
// // //     }
// // //   }
// // //
// // //   @override
// // //   void dispose() {
// // //     _connectivitySubscription.cancel();  // Cancel the subscription when done
// // //     _disableScreenProtection();
// // //     super.dispose();
// // //   }
// // // }
// // //
// // //
// // // class NoNetworkPage extends StatelessWidget {
// // //   final VoidCallback onRetry;
// // //
// // //   NoNetworkPage({required this.onRetry});
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Center(
// // //       child: Column(
// // //         mainAxisAlignment: MainAxisAlignment.center,
// // //         children: [
// // //           Icon(Icons.wifi_off, size: 100, color: Colors.grey),
// // //           SizedBox(height: 20),
// // //           Text(
// // //             "No Internet Connection",
// // //             style: TextStyle(fontSize: 18, color: Colors.grey),
// // //           ),
// // //           SizedBox(height: 20),
// // //           ElevatedButton(
// // //             onPressed: onRetry,
// // //             child: Text("Retry"),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }
// //
// //
// //
// // import 'package:connectivity_plus/connectivity_plus.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // import 'package:screen_protector/screen_protector.dart';
// // import 'dart:async';
// // import 'dart:io';
// // import 'package:url_launcher/url_launcher.dart';
// // import 'package:http/http.dart' as http;
// //
// //
// // void main() {
// //   runApp(MyApp());
// // }
// //
// // bool _isSplashVisible = true;
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       title: 'KNG',
// //       theme: ThemeData(
// //         brightness: Brightness.light,
// //         scaffoldBackgroundColor: Colors.white,
// //         appBarTheme: AppBarTheme(
// //           backgroundColor: Colors.white,
// //           iconTheme: IconThemeData(color: Colors.black),
// //           titleTextStyle: TextStyle(color: Colors.black),
// //         ),
// //         textTheme: TextTheme(
// //           bodyLarge: TextStyle(color: Colors.black),
// //         ),
// //         colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
// //       ),
// //       home: WebViewScreen(mainUrl: 'https://catalogue.gbjewelsync.com'),
// //     );
// //   }
// // }
// //
// // class WebViewScreen extends StatefulWidget {
// //   final String mainUrl;
// //   WebViewScreen({required this.mainUrl});
// //
// //   @override
// //   _WebViewScreenState createState() => _WebViewScreenState();
// // }
// //
// // class _WebViewScreenState extends State<WebViewScreen> {
// //   late InAppWebViewController _webViewController;
// //   bool _isWebViewLoaded = false;
// //
// //   bool _isNetworkAvailable = true;
// //   late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
// //
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _startSplashTimer();
// //     _enableScreenProtection();
// //     _checkNetworkConnectivity();
// //     _connectivitySubscription = Connectivity().onConnectivityChanged.listen((result) {
// //       if (result.isNotEmpty) {
// //         _updateNetworkStatus(result.first); // Handle first result
// //       }
// //     });
// //   }
// //
// //   void _startSplashTimer() {
// //     Future.delayed(Duration(seconds: 3), () {
// //       setState(() {
// //         _isSplashVisible = false;
// //       });
// //     });
// //   }
// //
// //   Future<void> _enableScreenProtection() async {
// //     try {
// //       if (Platform.isAndroid) {
// //         await ScreenProtector.protectDataLeakageOn();
// //       } else if (Platform.isIOS) {
// //         await ScreenProtector.preventScreenshotOn();
// //       }
// //     } catch (e) {
// //       print("Error enabling screen protection: $e");
// //     }
// //   }
// //
// //   Future<void> _disableScreenProtection() async {
// //     try {
// //       if (Platform.isAndroid) {
// //         await ScreenProtector.preventScreenshotOn();
// //       } else if (Platform.isIOS) {
// //         await ScreenProtector.preventScreenshotOn();
// //       }
// //     } catch (e) {
// //       print("Error disabling screen protection: $e");
// //     }
// //   }
// //
// //   void _updateNetworkStatus(ConnectivityResult result) {
// //     setState(() {
// //       _isNetworkAvailable = result != ConnectivityResult.none; // Check for network availability
// //     });
// //   }
// //
// //   Future<void> _checkNetworkConnectivity() async {
// //     // Getting the connectivity result, which may be a List of ConnectivityResult
// //     final List<ConnectivityResult> connectivityResults = await Connectivity().checkConnectivity();
// //
// //     // Assuming we are just interested in the first item in the list (if the list is non-empty)
// //     if (connectivityResults.isNotEmpty) {
// //       _updateNetworkStatus(connectivityResults.first);  // Update with the first result in the list
// //     }
// //   }
// //
// //   Future<bool> _onWillPop() async {
// //     // Check the current URL in the InAppWebView
// //     Uri? currentUrl = await _webViewController.getUrl();
// //
// //     if (currentUrl != null && currentUrl.toString() == 'https://catalogue.gbjewelsync.com/') {
// //       // Show confirmation dialog when on the specified URL
// //       bool shouldExit = await showDialog(
// //         context: context,
// //         builder: (BuildContext context) {
// //           return AlertDialog(
// //             title: Text("Exit App"),
// //             content: Text("Are you sure you want to exit the app?"),
// //             actions: [
// //               TextButton(
// //                 onPressed: () {
// //                   Navigator.of(context).pop(false); // User pressed "No"
// //                 },
// //                 child: Text("No"),
// //               ),
// //               TextButton(
// //                 onPressed: () {
// //                   Navigator.of(context).pop(true); // User pressed "Yes"
// //                 },
// //                 child: Text("Yes"),
// //               ),
// //             ],
// //           );
// //         },
// //       );
// //
// //       return shouldExit ?? false; // Return user's decision
// //     }
// //
// //     // Default behavior: Go back if possible
// //     if (await _webViewController.canGoBack()) {
// //       _webViewController.goBack();
// //       return Future.value(false); // Prevent app from exiting
// //     } else {
// //       return Future.value(true); // Exit the app
// //     }
// //   }
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return WillPopScope(
// //
// //       onWillPop: _onWillPop,
// //       child: Scaffold(
// //         appBar: PreferredSize(
// //           preferredSize: Size.fromHeight(0),
// //           child: AppBar(
// //             title: Text('KNG'),
// //             centerTitle: true,
// //           ),
// //         ),
// //         body: Stack(
// //           children: [
// //             // Main content (WebView or NoNetworkPage)
// //             AnimatedSwitcher(
// //               duration: Duration(milliseconds: 300),
// //               child: _isNetworkAvailable
// //                   ? Container(
// //                 key: ValueKey('WebView'),
// //                 child: InAppWebView(
// //                   initialUrlRequest: URLRequest(url: WebUri(widget.mainUrl)),
// //                   initialSettings: InAppWebViewSettings(
// //                     supportZoom: false,
// //                     useWideViewPort: true,
// //                     builtInZoomControls: false,
// //                     displayZoomControls: true,
// //                   ),
// //                   onWebViewCreated: (InAppWebViewController controller) {
// //                     _webViewController = controller;
// //                     // Register the JavaScript handler
// //                     _webViewController.addJavaScriptHandler(
// //                       handlerName: 'onItemDetailsClicked',
// //                       callback: (args) {
// //                         if (args.isNotEmpty) {
// //                           _handleItemDetailsClicked(args[0]);
// //                         }
// //                       },
// //                     );
// //
// //                     _webViewController.addJavaScriptHandler(
// //                       handlerName: 'openUrlInBrowser',
// //                       callback: (args) {
// //                         if (args.isNotEmpty) {
// //                           _openUrlInBrowser(args[0]); // Call the browser opening function
// //                         }
// //                       },
// //                     );
// //
// //                   },
// //                   onLoadStart: (InAppWebViewController controller, Uri? url) {},
// //                   onLoadStop: (InAppWebViewController controller, Uri? url) async {
// //                     if (url != null && url.toString() == "https://catalogue.gbjewelsync.com/login") {
// //                       await controller.loadUrl(
// //                         urlRequest: URLRequest(url: WebUri("https://catalogue.gbjewelsync.com/login/KNG")),
// //                       );
// //                     }
// //                     if (url != null && url.toString() == "https://catalogue.gbjewelsync.com/signup") {
// //                       await controller.loadUrl(
// //                         urlRequest: URLRequest(url: WebUri("https://catalogue.gbjewelsync.com/signup/KNG")),
// //                       );
// //                     }
// //                   },
// //                 ),
// //               )
// //                   : Container(
// //                 key: ValueKey('NoNetwork'),
// //                 child: NoNetworkPage(
// //                   onRetry: _checkNetworkConnectivity,
// //                 ),
// //               ),
// //             ),
// //
// //             // Splash screen overlay
// //             if (_isSplashVisible)
// //               Positioned.fill(
// //                 child: Center(
// //                   child: Image.asset(
// //                     'assets/splash.gif',
// //                     width: MediaQuery.of(context).size.width,
// //                     height: MediaQuery.of(context).size.height,
// //                     fit: BoxFit.cover,
// //                   ),
// //                 ),
// //               ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //
// //   void _handleItemDetailsClicked(String dataHref) {
// //     if (Platform.isAndroid) {
// //       Navigator.push(
// //         context,
// //         PageRouteBuilder(
// //           pageBuilder: (context, animation, secondaryAnimation) =>
// //               WebViewScreen(mainUrl: dataHref),
// //           transitionsBuilder: (context, animation, secondaryAnimation, child) {
// //             const begin = Offset(1.0, 0.0);
// //             const end = Offset.zero;
// //             const curve = Curves.easeInOut;
// //
// //             var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
// //             var offsetAnimation = animation.drive(tween);
// //
// //             return SlideTransition(
// //               position: offsetAnimation,
// //               child: child,
// //             );
// //           },
// //         ),
// //       );
// //     }
// //   }
// //
// //   Future<void> _openUrlInBrowser(String url) async {
// //     setState(() {
// //       _isSplashVisible = false; // Hide splash screen when this method is triggered
// //     });
// //
// //     final Uri uri = Uri.parse(url);
// //
// //     if (await canLaunchUrl(uri)) {
// //       await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
// //     } else {
// //       print("Could not launch $url");
// //     }
// //   }
// //
// //
// //   @override
// //   void dispose() {
// //     _connectivitySubscription.cancel();  // Cancel the subscription when done
// //     _disableScreenProtection();
// //     super.dispose();
// //   }
// // }
// //
// //
// // class NoNetworkPage extends StatelessWidget {
// //   final VoidCallback onRetry;
// //
// //   NoNetworkPage({required this.onRetry});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Icon(Icons.wifi_off, size: 100, color: Colors.grey),
// //           SizedBox(height: 20),
// //           Text(
// //             "No Internet Connection",
// //             style: TextStyle(fontSize: 18, color: Colors.grey),
// //           ),
// //           SizedBox(height: 20),
// //           ElevatedButton(
// //             onPressed: onRetry,
// //             child: Text("Retry"),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:screen_protector/screen_protector.dart';
// import 'dart:async';
// import 'dart:io';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:http/http.dart' as http;
// import 'package:firebase_core/firebase_core.dart';
// import 'notification_service.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// void main() async{
//
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//   runApp(MyApp());
// }
//
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async {
//   await Firebase.initializeApp();
//   print(message.notification?.title.toString());
// }
//
//
//
//
// bool _isSplashVisible = true;
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'KNG',
//       theme: ThemeData(
//         brightness: Brightness.light,
//         scaffoldBackgroundColor: Colors.white,
//         appBarTheme: AppBarTheme(
//           backgroundColor: Colors.white,
//           iconTheme: IconThemeData(color: Colors.black),
//           titleTextStyle: TextStyle(color: Colors.black),
//         ),
//         textTheme: TextTheme(
//           bodyLarge: TextStyle(color: Colors.black),
//         ),
//         colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
//       ),
//       home: WebViewScreen(mainUrl: 'https://catalogue.gbjewelsync.com'),
//     );
//   }
// }
//
// class WebViewScreen extends StatefulWidget {
//   final String mainUrl;
//   WebViewScreen({required this.mainUrl});
//
//   @override
//   _WebViewScreenState createState() => _WebViewScreenState();
// }
//
// class _WebViewScreenState extends State<WebViewScreen> {
//   late InAppWebViewController _webViewController;
//   bool _isNetworkAvailable = true;
//   late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
//   String? _fcmToken; // To store the FCM token
//
//
//   @override
//   void initState() {
//     super.initState();
//
//     _fetchFCMToken();
//     _startSplashTimer();
//     _enableScreenProtection();
//     _checkNetworkConnectivity();
//     _connectivitySubscription = Connectivity().onConnectivityChanged.listen((result) {
//       if (result.isNotEmpty) {
//         _updateNetworkStatus(result.first); // Handle first result
//       }
//     });
//   }
//
//   void _startSplashTimer() {
//     Future.delayed(Duration(seconds: 3), () {
//       setState(() {
//         _isSplashVisible = false;
//       });
//     });
//   }
//
//   Future<void> _enableScreenProtection() async {
//     try {
//       if (Platform.isAndroid) {
//         await ScreenProtector.protectDataLeakageOn();
//       } else if (Platform.isIOS) {
//         await ScreenProtector.preventScreenshotOn();
//       }
//     } catch (e) {
//       print("Error enabling screen protection: $e");
//     }
//   }
//
//   Future<void> _disableScreenProtection() async {
//     try {
//       if (Platform.isAndroid) {
//         await ScreenProtector.preventScreenshotOn();
//       } else if (Platform.isIOS) {
//         await ScreenProtector.preventScreenshotOn();
//       }
//     } catch (e) {
//       print("Error disabling screen protection: $e");
//     }
//   }
//
//   void _updateNetworkStatus(ConnectivityResult result) {
//     setState(() {
//       _isNetworkAvailable = result != ConnectivityResult.none; // Check for network availability
//     });
//   }
//
//   Future<void> _checkNetworkConnectivity() async {
//     // Getting the connectivity result, which may be a List of ConnectivityResult
//     final List<ConnectivityResult> connectivityResults = await Connectivity().checkConnectivity();
//
//     // Assuming we are just interested in the first item in the list (if the list is non-empty)
//     if (connectivityResults.isNotEmpty) {
//       _updateNetworkStatus(connectivityResults.first);  // Update with the first result in the list
//     }
//   }
//
//   Future<bool> _onWillPop() async {
//     // Check the current URL in the InAppWebView
//     Uri? currentUrl = await _webViewController.getUrl();
//
//     if (currentUrl != null && currentUrl.toString() == 'https://catalogue.gbjewelsync.com') {
//       // Show confirmation dialog when on the specified URL
//       bool shouldExit = await showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Exit App"),
//             content: Text("Are you sure you want to exit the app?"),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(false); // User pressed "No"
//                 },
//                 child: Text("No"),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(true); // User pressed "Yes"
//                 },
//                 child: Text("Yes"),
//               ),
//             ],
//           );
//         },
//       );
//
//       return shouldExit ?? false; // Return user's decision
//     }
//
//     // Default behavior: Go back if possible
//     if (await _webViewController.canGoBack()) {
//       _webViewController.goBack();
//       return Future.value(false); // Prevent app from exiting
//     } else {
//       return Future.value(true); // Exit the app
//     }
//   }
//
//   Future<void> _fetchFCMToken() async {
//     final token = await NotificationService.instance.getFCMToken();
//
//     setState(() {
//       _fcmToken = token;
//     });
//     print("tokan is" + _fcmToken!);
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//
//       onWillPop: _onWillPop,
//       child: Scaffold(
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(0),
//           child: AppBar(
//             title: Text('KNG'),
//             centerTitle: true,
//           ),
//         ),
//         body: Stack(
//           children: [
//             // Main content (WebView or NoNetworkPage)
//             AnimatedSwitcher(
//               duration: Duration(milliseconds: 300),
//               child: _isNetworkAvailable
//                   ? Container(
//                 key: ValueKey('WebView'),
//                 child: InAppWebView(
//                   initialUrlRequest: URLRequest(url: WebUri(widget.mainUrl)),
//                   initialSettings: InAppWebViewSettings(
//                     supportZoom: false,
//                     useWideViewPort: true,
//                     builtInZoomControls: false,
//                     displayZoomControls: false,
//                   ),
//                   onWebViewCreated: (InAppWebViewController controller) {
//                     _webViewController = controller;
//                     // Register the JavaScript handler
//                     _webViewController.addJavaScriptHandler(
//                       handlerName: 'onItemDetailsClicked',
//                       callback: (args) {
//                         if (args.isNotEmpty) {
//                           _handleItemDetailsClicked(args[0]);
//                         }
//                       },
//                     );
//
//                     _webViewController.addJavaScriptHandler(
//                       handlerName: 'openUrlInBrowser',
//                       callback: (args) {
//                         if (args.isNotEmpty) {
//                           _openUrlInBrowser(args[0]); // Call the browser opening function
//                         }
//                       },
//                     );
//
//                     _webViewController.addJavaScriptHandler(
//                       handlerName: 'updateFcmToken',
//                       callback: (args) {
//                         if (args.isNotEmpty) {
//                           _updateFcmToken(args[0]); // Call the browser opening function
//                         }
//                       },
//                     );
//
//                   },
//                   onLoadStart: (InAppWebViewController controller, Uri? url) {},
//                   onLoadStop: (InAppWebViewController controller, Uri? url) async {
//                     if (url != null && url.toString() == "https://catalogue.gbjewelsync.com/login") {
//                       await controller.loadUrl(
//                         urlRequest: URLRequest(url: WebUri("https://catalogue.gbjewelsync.com/login/KNG")),
//                       );
//                     }
//                     if (url != null && url.toString() == "https://catalogue.gbjewelsync.com/signup") {
//                       await controller.loadUrl(
//                         urlRequest: URLRequest(url: WebUri("https://catalogue.gbjewelsync.com/signup/KNG")),
//                       );
//                     }
//                   },
//                 ),
//               )
//                   : Container(
//                 key: ValueKey('NoNetwork'),
//                 child: NoNetworkPage(
//                   onRetry: _checkNetworkConnectivity,
//                 ),
//               ),
//             ),
//
//             // Splash screen overlay
//             if (_isSplashVisible)
//               Positioned.fill(
//                 child: Center(
//                   child: Image.asset(
//                     'assets/splash.gif',
//                     width: MediaQuery.of(context).size.width,
//                     height: MediaQuery.of(context).size.height,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   void _handleItemDetailsClicked(String dataHref) {
//     if (Platform.isAndroid) {
//       Navigator.push(
//         context,
//         PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation) =>
//               WebViewScreen(mainUrl: dataHref),
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             const begin = Offset(1.0, 0.0);
//             const end = Offset.zero;
//             const curve = Curves.easeInOut;
//
//             var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//             var offsetAnimation = animation.drive(tween);
//
//             return SlideTransition(
//               position: offsetAnimation,
//               child: child,
//             );
//           },
//         ),
//       );
//     }
//   }
//
//   Future<void> _openUrlInBrowser(String url) async {
//     setState(() {
//       _isSplashVisible = false; // Hide splash screen when this method is triggered
//     });
//
//     final Uri uri = Uri.parse(url);
//
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
//     } else {
//       print("Could not launch $url");
//     }
//   }
//
//   Future<void> _updateFcmToken(String token1) async {
//     final token = await NotificationService.instance.getFCMToken();
//
//     setState(() {
//       _fcmToken = token;
//     });
//
//     final Map<String, String> headers = {
//       'Authorization': 'Bearer $token1',
//     };
//
//     print('here');
//     print(_fcmToken);
//     print("here is passed token : $token1");
//     final response = await http.get(
//         Uri.parse('https://gbjewelsync.com/api/catalogue/banners?device_token=$_fcmToken'), headers: headers);
//
//     if (response.statusCode == 200) {
//       print("token passed");
//     }
//   }
//
//   @override
//   void dispose() {
//     _connectivitySubscription.cancel();  // Cancel the subscription when done
//     _disableScreenProtection();
//     super.dispose();
//   }
// }
//
// class NoNetworkPage extends StatelessWidget {
//   final VoidCallback onRetry;
//
//   NoNetworkPage({required this.onRetry});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.wifi_off, size: 100, color: Colors.grey),
//           SizedBox(height: 20),
//           Text(
//             "No Internet Connection",
//             style: TextStyle(fontSize: 18, color: Colors.grey),
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: onRetry,
//             child: Text("Retry"),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // class MyApp extends StatelessWidget {
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       title: 'KNG',
// //       theme: ThemeData(
// //         brightness: Brightness.light,
// //         scaffoldBackgroundColor: Colors.white,
// //         appBarTheme: AppBarTheme(
// //           backgroundColor: Colors.white,
// //           iconTheme: IconThemeData(color: Colors.black),
// //           titleTextStyle: TextStyle(color: Colors.black),
// //         ),
// //         textTheme: TextTheme(
// //           bodyLarge: TextStyle(color: Colors.black),
// //         ),
// //         colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
// //       ),
// //       home: WebViewScreen(mainUrl: 'https://catalogue.gbjewelsync.com'),
// //     );
// //   }
// // }


// // // // // // // import 'dart:io';
// // // // // // // import 'dart:async';
// // // // // // // import 'package:flutter/material.dart';
// // // // // // // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // // // // // // import 'package:screen_protector/screen_protector.dart';
// // // // // // // import 'package:url_launcher/url_launcher.dart';
// // // // // // // import 'package:http/http.dart' as http;
// // // // // // // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // // // // // //
// // // // // // // void main() {
// // // // // // //   runApp(MyApp());
// // // // // // // }
// // // // // // //
// // // // // // // class MyApp extends StatelessWidget {
// // // // // // //   @override
// // // // // // //   Widget build(BuildContext context) {
// // // // // // //     return MaterialApp(
// // // // // // //       debugShowCheckedModeBanner: false,
// // // // // // //       title: 'KNG',
// // // // // // //       theme: ThemeData(
// // // // // // //         brightness: Brightness.light,
// // // // // // //         scaffoldBackgroundColor: Colors.white,
// // // // // // //         appBarTheme: AppBarTheme(
// // // // // // //           backgroundColor: Colors.white,
// // // // // // //           iconTheme: IconThemeData(color: Colors.black),
// // // // // // //           titleTextStyle: TextStyle(color: Colors.black),
// // // // // // //         ),
// // // // // // //         textTheme: TextTheme(
// // // // // // //           bodyLarge: TextStyle(color: Colors.black),
// // // // // // //         ),
// // // // // // //         colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
// // // // // // //       ),
// // // // // // //       home: SplashScreen(),
// // // // // // //     );
// // // // // // //   }
// // // // // // // }
// // // // // // //
// // // // // // // class SplashScreen extends StatefulWidget {
// // // // // // //   @override
// // // // // // //   _SplashScreenState createState() => _SplashScreenState();
// // // // // // // }
// // // // // // //
// // // // // // // class _SplashScreenState extends State<SplashScreen> {
// // // // // // //
// // // // // // //   bool _isWebViewLoaded = false;
// // // // // // //
// // // // // // //   @override
// // // // // // //   void initState() {
// // // // // // //     super.initState();
// // // // // // //
// // // // // // //
// // // // // // //
// // // // // // //     Timer(Duration(seconds: 3), () {
// // // // // // //       Navigator.pushReplacement(
// // // // // // //         context,
// // // // // // //         MaterialPageRoute(builder: (context) => WebViewScreen(mainUrl: 'https://catalogue.gbjewelsync.com')),
// // // // // // //       );
// // // // // // //     });
// // // // // // //
// // // // // // //
// // // // // // //   }
// // // // // // //
// // // // // // //   @override
// // // // // // //   Widget build(BuildContext context) {
// // // // // // //     double screenWidth = MediaQuery.of(context).size.width;
// // // // // // //     double screenHeight = MediaQuery.of(context).size.height;
// // // // // // //     return Scaffold(
// // // // // // //
// // // // // // //       backgroundColor: Colors.white,
// // // // // // //       body: Container(
// // // // // // //         child: Column(
// // // // // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // // // // //           children: [
// // // // // // //             Image.asset(
// // // // // // //               'assets/splash.gif',
// // // // // // //               // 'assets/logo 1.png',
// // // // // // //               width: screenWidth, // 80% of the screen width
// // // // // // //               height: screenHeight, // 40% of the screen height
// // // // // // //               fit: BoxFit.cover,
// // // // // // //             ),
// // // // // // //           ],
// // // // // // //         ),
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }
// // // // // // // }
// // // // // // //
// // // // // // // class WebViewScreen extends StatefulWidget {
// // // // // // //   final String mainUrl;
// // // // // // //   WebViewScreen({required this.mainUrl});
// // // // // // //
// // // // // // //   @override
// // // // // // //   _WebViewScreenState createState() => _WebViewScreenState();
// // // // // // // }
// // // // // // // class _WebViewScreenState extends State<WebViewScreen> {
// // // // // // //   late InAppWebViewController _webViewController;
// // // // // // //
// // // // // // //
// // // // // // //   @override
// // // // // // //   void initState() {
// // // // // // //     super.initState();
// // // // // // //
// // // // // // //     _enableScreenProtection();
// // // // // // //   }
// // // // // // //
// // // // // // //   Future<void> _enableScreenProtection() async {
// // // // // // //     try {
// // // // // // //       if (Platform.isAndroid) {
// // // // // // //         await ScreenProtector.protectDataLeakageOn();
// // // // // // //       } else if (Platform.isIOS) {
// // // // // // //         await ScreenProtector.preventScreenshotOn();
// // // // // // //       }
// // // // // // //     } catch (e) {
// // // // // // //       print("Error enabling screen protection: $e");
// // // // // // //     }
// // // // // // //   }
// // // // // // //
// // // // // // //   Future<void> _disableScreenProtection() async {
// // // // // // //     try {
// // // // // // //       if (Platform.isAndroid) {
// // // // // // //         await ScreenProtector.preventScreenshotOn();
// // // // // // //       } else if (Platform.isIOS) {
// // // // // // //         await ScreenProtector.preventScreenshotOn();
// // // // // // //       }
// // // // // // //     } catch (e) {
// // // // // // //       print("Error disabling screen protection: $e");
// // // // // // //     }
// // // // // // //   }
// // // // // // //
// // // // // // //   Future<bool> _onWillPop() async {
// // // // // // //     if (await _webViewController.canGoBack()) {
// // // // // // //       _webViewController.goBack();
// // // // // // //       return Future.value(false);
// // // // // // //     } else {
// // // // // // //       return Future.value(true);
// // // // // // //     }
// // // // // // //   }
// // // // // // //
// // // // // // //   @override
// // // // // // //   Widget build(BuildContext context) {
// // // // // // //     return WillPopScope(
// // // // // // //       onWillPop: _onWillPop,
// // // // // // //       child: Scaffold(
// // // // // // //         appBar: PreferredSize(
// // // // // // //           preferredSize: Size.fromHeight(0),
// // // // // // //           child: AppBar(
// // // // // // //             title: Text('KNG'),
// // // // // // //             centerTitle: true,
// // // // // // //           ),
// // // // // // //         ),
// // // // // // //         body: Stack(
// // // // // // //           children: [
// // // // // // //             InAppWebView(
// // // // // // //               initialUrlRequest: URLRequest(url: WebUri(widget.mainUrl)),
// // // // // // //               initialSettings: InAppWebViewSettings(
// // // // // // //                 supportZoom: false,
// // // // // // //                 useWideViewPort: true,
// // // // // // //                 builtInZoomControls: false,
// // // // // // //                 displayZoomControls: true,
// // // // // // //               ),
// // // // // // //               onWebViewCreated: (InAppWebViewController controller) {
// // // // // // //                 _webViewController = controller;
// // // // // // //
// // // // // // //                 // Register the JavaScript handler
// // // // // // //                 _webViewController.addJavaScriptHandler(
// // // // // // //                   handlerName: 'onItemDetailsClicked',
// // // // // // //                   callback: (args) {
// // // // // // //                     if (args.isNotEmpty) {
// // // // // // //                       _handleItemDetailsClicked(args[0]);
// // // // // // //                     }
// // // // // // //                   },
// // // // // // //                 );
// // // // // // //
// // // // // // //                 _webViewController.addJavaScriptHandler(
// // // // // // //                   handlerName: 'openUrlInBrowser',
// // // // // // //                   callback: (args) {
// // // // // // //                     if (args.isNotEmpty) {
// // // // // // //                       _openUrlInBrowser(args[0]); // Call the browser opening function
// // // // // // //                     }
// // // // // // //                   },
// // // // // // //                 );
// // // // // // //
// // // // // // //                 _webViewController.addJavaScriptHandler(
// // // // // // //                   handlerName: 'updateFcmToken',
// // // // // // //                   callback: (args) {
// // // // // // //                     if (args.isNotEmpty) {
// // // // // // //                       _updateFcmToken(args[0]); // Call the browser opening function
// // // // // // //                     }
// // // // // // //                   },
// // // // // // //                 );
// // // // // // //               },
// // // // // // //               onLoadStart: (InAppWebViewController controller, Uri? url) {
// // // // // // //
// // // // // // //               },
// // // // // // //               onLoadStop: (InAppWebViewController controller, Uri? url) async {
// // // // // // //
// // // // // // //                 if (url != null && url.toString() == "https://catalogue.gbjewelsync.com/login") {
// // // // // // //                   await controller.loadUrl(
// // // // // // //                     urlRequest: URLRequest(url: WebUri("https://catalogue.gbjewelsync.com/login/KNG")),
// // // // // // //                   );
// // // // // // //                 }
// // // // // // //                 if (url != null && url.toString() == "https://catalogue.gbjewelsync.com/signup") {
// // // // // // //                   await controller.loadUrl(
// // // // // // //                     urlRequest: URLRequest(url: WebUri("https://catalogue.gbjewelsync.com/signup/KNG")),
// // // // // // //                   );
// // // // // // //                 }
// // // // // // //                 print("Finished loading: $url");
// // // // // // //               },
// // // // // // //             ),
// // // // // // //
// // // // // // //           ],
// // // // // // //         ),
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }
// // // // // // //
// // // // // // //   void _handleItemDetailsClicked(String dataHref) {
// // // // // // //     if (Platform.isAndroid) {
// // // // // // //       Navigator.push(
// // // // // // //         context,
// // // // // // //         PageRouteBuilder(
// // // // // // //           pageBuilder: (context, animation, secondaryAnimation) =>
// // // // // // //               WebViewScreen(mainUrl: dataHref),
// // // // // // //           transitionsBuilder: (context, animation, secondaryAnimation, child) {
// // // // // // //             const begin = Offset(1.0, 0.0);
// // // // // // //             const end = Offset.zero;
// // // // // // //             const curve = Curves.easeInOut;
// // // // // // //
// // // // // // //             var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
// // // // // // //             var offsetAnimation = animation.drive(tween);
// // // // // // //
// // // // // // //             return SlideTransition(
// // // // // // //               position: offsetAnimation,
// // // // // // //               child: child,
// // // // // // //             );
// // // // // // //           },
// // // // // // //         ),
// // // // // // //       );
// // // // // // //     }
// // // // // // //   }
// // // // // // //
// // // // // // //   Future<void> _openUrlInBrowser(String url) async {
// // // // // // //     final Uri uri = Uri.parse(url);
// // // // // // //
// // // // // // //     if (await canLaunchUrl(uri)) {
// // // // // // //       await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
// // // // // // //     }
// // // // // // //   }
// // // // // // //
// // // // // // //   Future<void> _updateFcmToken(String token) async {
// // // // // // //     print("Hello this is token: "+token);
// // // // // // //
// // // // // // //     String? _fcmToken;
// // // // // // //
// // // // // // //     // final token1 = await NotificationService.instance.getFCMToken();
// // // // // // //     // setState(() {
// // // // // // //     //   _fcmToken = token1;
// // // // // // //     // });
// // // // // // //
// // // // // // //     final Map<String, String> headers = {
// // // // // // //       'Authorization': 'Bearer $token',
// // // // // // //     };
// // // // // // //
// // // // // // //     final response = await http.get(
// // // // // // //         Uri.parse('https://gbjewelsync.com/api/catalogue/banners?device_token=$_fcmToken'), headers: headers);
// // // // // // //
// // // // // // //     if (response.statusCode == 200) {
// // // // // // //       //
// // // // // // //     }
// // // // // // //   }
// // // // // // //
// // // // // // //   @override
// // // // // // //   void dispose() {
// // // // // // //     _disableScreenProtection();
// // // // // // //     super.dispose();
// // // // // // //   }
// // // // // // // }
// // // // // //
// // // // // //
// // // // // // import 'dart:io';
// // // // // // import 'dart:async';
// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // // // // // import 'package:screen_protector/screen_protector.dart';
// // // // // // import 'package:url_launcher/url_launcher.dart';
// // // // // // import 'package:http/http.dart' as http;
// // // // // // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // // // // //
// // // // // // void main() {
// // // // // //   runApp(MyApp());
// // // // // // }
// // // // // //
// // // // // // class MyApp extends StatelessWidget {
// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return MaterialApp(
// // // // // //       debugShowCheckedModeBanner: false,
// // // // // //       title: 'KNG',
// // // // // //       theme: ThemeData(
// // // // // //         brightness: Brightness.light,
// // // // // //         scaffoldBackgroundColor: Colors.white,
// // // // // //         appBarTheme: AppBarTheme(
// // // // // //           backgroundColor: Colors.white,
// // // // // //           iconTheme: IconThemeData(color: Colors.black),
// // // // // //           titleTextStyle: TextStyle(color: Colors.black),
// // // // // //         ),
// // // // // //         textTheme: TextTheme(
// // // // // //           bodyLarge: TextStyle(color: Colors.black),
// // // // // //         ),
// // // // // //         colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
// // // // // //       ),
// // // // // //       home: WebViewScreen(mainUrl: 'https://catalogue.gbjewelsync.com'),
// // // // // //     );
// // // // // //   }
// // // // // // }
// // // // // //
// // // // // // class SplashScreen extends StatefulWidget {
// // // // // //   @override
// // // // // //   _SplashScreenState createState() => _SplashScreenState();
// // // // // // }
// // // // // //
// // // // // // class _SplashScreenState extends State<SplashScreen> {
// // // // // //
// // // // // //   bool _isWebViewLoaded = false;
// // // // // //
// // // // // //   @override
// // // // // //   void initState() {
// // // // // //     super.initState();
// // // // // //
// // // // // //
// // // // // //
// // // // // //     Timer(Duration(seconds: 3), () {
// // // // // //       Navigator.pushReplacement(
// // // // // //         context,
// // // // // //         MaterialPageRoute(builder: (context) => WebViewScreen(mainUrl: 'https://catalogue.gbjewelsync.com')),
// // // // // //       );
// // // // // //     });
// // // // // //
// // // // // //
// // // // // //   }
// // // // // //
// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     double screenWidth = MediaQuery.of(context).size.width;
// // // // // //     double screenHeight = MediaQuery.of(context).size.height;
// // // // // //     return Scaffold(
// // // // // //
// // // // // //       backgroundColor: Colors.white,
// // // // // //       body: Container(
// // // // // //         child: Column(
// // // // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // // // //           children: [
// // // // // //             Image.asset(
// // // // // //               'assets/splash.gif',
// // // // // //               // 'assets/logo 1.png',
// // // // // //               width: screenWidth, // 80% of the screen width
// // // // // //               height: screenHeight, // 40% of the screen height
// // // // // //               fit: BoxFit.cover,
// // // // // //             ),
// // // // // //           ],
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // // }
// // // // // //
// // // // // // class WebViewScreen extends StatefulWidget {
// // // // // //   final String mainUrl;
// // // // // //   WebViewScreen({required this.mainUrl});
// // // // // //
// // // // // //   @override
// // // // // //   _WebViewScreenState createState() => _WebViewScreenState();
// // // // // // }
// // // // // // class _WebViewScreenState extends State<WebViewScreen> {
// // // // // //   late InAppWebViewController _webViewController;
// // // // // //
// // // // // //
// // // // // //   @override
// // // // // //   void initState() {
// // // // // //     super.initState();
// // // // // //
// // // // // //     _enableScreenProtection();
// // // // // //   }
// // // // // //
// // // // // //   Future<void> _enableScreenProtection() async {
// // // // // //     try {
// // // // // //       if (Platform.isAndroid) {
// // // // // //         await ScreenProtector.protectDataLeakageOn();
// // // // // //       } else if (Platform.isIOS) {
// // // // // //         await ScreenProtector.preventScreenshotOn();
// // // // // //       }
// // // // // //     } catch (e) {
// // // // // //       print("Error enabling screen protection: $e");
// // // // // //     }
// // // // // //   }
// // // // // //
// // // // // //   Future<void> _disableScreenProtection() async {
// // // // // //     try {
// // // // // //       if (Platform.isAndroid) {
// // // // // //         await ScreenProtector.preventScreenshotOn();
// // // // // //       } else if (Platform.isIOS) {
// // // // // //         await ScreenProtector.preventScreenshotOn();
// // // // // //       }
// // // // // //     } catch (e) {
// // // // // //       print("Error disabling screen protection: $e");
// // // // // //     }
// // // // // //   }
// // // // // //
// // // // // //   Future<bool> _onWillPop() async {
// // // // // //     if (await _webViewController.canGoBack()) {
// // // // // //       _webViewController.goBack();
// // // // // //       return Future.value(false);
// // // // // //     } else {
// // // // // //       return Future.value(true);
// // // // // //     }
// // // // // //   }
// // // // // //
// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return WillPopScope(
// // // // // //       onWillPop: _onWillPop,
// // // // // //       child: Scaffold(
// // // // // //         appBar: PreferredSize(
// // // // // //           preferredSize: Size.fromHeight(0),
// // // // // //           child: AppBar(
// // // // // //             title: Text('KNG'),
// // // // // //             centerTitle: true,
// // // // // //           ),
// // // // // //         ),
// // // // // //         body: Stack(
// // // // // //           children: [
// // // // // //             InAppWebView(
// // // // // //               initialUrlRequest: URLRequest(url: WebUri(widget.mainUrl)),
// // // // // //               initialSettings: InAppWebViewSettings(
// // // // // //                 supportZoom: false,
// // // // // //                 useWideViewPort: true,
// // // // // //                 builtInZoomControls: false,
// // // // // //                 displayZoomControls: true,
// // // // // //               ),
// // // // // //               onWebViewCreated: (InAppWebViewController controller) {
// // // // // //                 _webViewController = controller;
// // // // // //
// // // // // //                 // Register the JavaScript handler
// // // // // //                 _webViewController.addJavaScriptHandler(
// // // // // //                   handlerName: 'onItemDetailsClicked',
// // // // // //                   callback: (args) {
// // // // // //                     if (args.isNotEmpty) {
// // // // // //                       _handleItemDetailsClicked(args[0]);
// // // // // //                     }
// // // // // //                   },
// // // // // //                 );
// // // // // //
// // // // // //                 _webViewController.addJavaScriptHandler(
// // // // // //                   handlerName: 'openUrlInBrowser',
// // // // // //                   callback: (args) {
// // // // // //                     if (args.isNotEmpty) {
// // // // // //                       _openUrlInBrowser(args[0]); // Call the browser opening function
// // // // // //                     }
// // // // // //                   },
// // // // // //                 );
// // // // // //
// // // // // //                 _webViewController.addJavaScriptHandler(
// // // // // //                   handlerName: 'updateFcmToken',
// // // // // //                   callback: (args) {
// // // // // //                     if (args.isNotEmpty) {
// // // // // //                       _updateFcmToken(args[0]); // Call the browser opening function
// // // // // //                     }
// // // // // //                   },
// // // // // //                 );
// // // // // //               },
// // // // // //               onLoadStart: (InAppWebViewController controller, Uri? url) {
// // // // // //
// // // // // //               },
// // // // // //               onLoadStop: (InAppWebViewController controller, Uri? url) async {
// // // // // //
// // // // // //                 if (url != null && url.toString() == "https://catalogue.gbjewelsync.com/login") {
// // // // // //                   await controller.loadUrl(
// // // // // //                     urlRequest: URLRequest(url: WebUri("https://catalogue.gbjewelsync.com/login/KNG")),
// // // // // //                   );
// // // // // //                 }
// // // // // //                 if (url != null && url.toString() == "https://catalogue.gbjewelsync.com/signup") {
// // // // // //                   await controller.loadUrl(
// // // // // //                     urlRequest: URLRequest(url: WebUri("https://catalogue.gbjewelsync.com/signup/KNG")),
// // // // // //                   );
// // // // // //                 }
// // // // // //                 print("Finished loading: $url");
// // // // // //               },
// // // // // //             ),
// // // // // //
// // // // // //           ],
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // //
// // // // // //   void _handleItemDetailsClicked(String dataHref) {
// // // // // //     if (Platform.isAndroid) {
// // // // // //       Navigator.push(
// // // // // //         context,
// // // // // //         PageRouteBuilder(
// // // // // //           pageBuilder: (context, animation, secondaryAnimation) =>
// // // // // //               WebViewScreen(mainUrl: dataHref),
// // // // // //           transitionsBuilder: (context, animation, secondaryAnimation, child) {
// // // // // //             const begin = Offset(1.0, 0.0);
// // // // // //             const end = Offset.zero;
// // // // // //             const curve = Curves.easeInOut;
// // // // // //
// // // // // //             var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
// // // // // //             var offsetAnimation = animation.drive(tween);
// // // // // //
// // // // // //             return SlideTransition(
// // // // // //               position: offsetAnimation,
// // // // // //               child: child,
// // // // // //             );
// // // // // //           },
// // // // // //         ),
// // // // // //       );
// // // // // //     }
// // // // // //   }
// // // // // //
// // // // // //   Future<void> _openUrlInBrowser(String url) async {
// // // // // //     final Uri uri = Uri.parse(url);
// // // // // //
// // // // // //     if (await canLaunchUrl(uri)) {
// // // // // //       await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
// // // // // //     }
// // // // // //   }
// // // // // //
// // // // // //   Future<void> _updateFcmToken(String token) async {
// // // // // //     print("Hello this is token: "+token);
// // // // // //
// // // // // //     String? _fcmToken;
// // // // // //
// // // // // //     // final token1 = await NotificationService.instance.getFCMToken();
// // // // // //     // setState(() {
// // // // // //     //   _fcmToken = token1;
// // // // // //     // });
// // // // // //
// // // // // //     final Map<String, String> headers = {
// // // // // //       'Authorization': 'Bearer $token',
// // // // // //     };
// // // // // //
// // // // // //     final response = await http.get(
// // // // // //         Uri.parse('https://gbjewelsync.com/api/catalogue/banners?device_token=$_fcmToken'), headers: headers);
// // // // // //
// // // // // //     if (response.statusCode == 200) {
// // // // // //       //
// // // // // //     }
// // // // // //   }
// // // // // //
// // // // // //   @override
// // // // // //   void dispose() {
// // // // // //     _disableScreenProtection();
// // // // // //     super.dispose();
// // // // // //   }
// // // // // // }
// // // // //
// // // // //
// // // // // import 'dart:io';
// // // // // import 'dart:async';
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // // // // import 'package:screen_protector/screen_protector.dart';
// // // // // import 'package:url_launcher/url_launcher.dart';
// // // // // import 'package:http/http.dart' as http;
// // // // // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // // // //
// // // // // void main() {
// // // // //   runApp(MyApp());
// // // // // }
// // // // //
// // // // // class MyApp extends StatelessWidget {
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return MaterialApp(
// // // // //       debugShowCheckedModeBanner: false,
// // // // //       title: 'KNG',
// // // // //       theme: ThemeData(
// // // // //         brightness: Brightness.light,
// // // // //         scaffoldBackgroundColor: Colors.white,
// // // // //         appBarTheme: AppBarTheme(
// // // // //           backgroundColor: Colors.white,
// // // // //           iconTheme: IconThemeData(color: Colors.black),
// // // // //           titleTextStyle: TextStyle(color: Colors.black),
// // // // //         ),
// // // // //         textTheme: TextTheme(
// // // // //           bodyLarge: TextStyle(color: Colors.black),
// // // // //         ),
// // // // //         colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
// // // // //       ),
// // // // //       home: WebViewScreen(mainUrl: 'https://catalogue.gbjewelsync.com'),
// // // // //     );
// // // // //   }
// // // // // }
// // // // // class WebViewScreen extends StatefulWidget {
// // // // //   final String mainUrl;
// // // // //   WebViewScreen({required this.mainUrl});
// // // // //
// // // // //   @override
// // // // //   _WebViewScreenState createState() => _WebViewScreenState();
// // // // // }
// // // // //
// // // // // class _WebViewScreenState extends State<WebViewScreen> {
// // // // //   late InAppWebViewController _webViewController;
// // // // //   bool _isWebViewLoaded = false;
// // // // //   bool _isSplashVisible = true;
// // // // //
// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     _startSplashTimer();
// // // // //     _enableScreenProtection();
// // // // //   }
// // // // //
// // // // //   void _startSplashTimer() {
// // // // //     Future.delayed(Duration(seconds: 3), () {
// // // // //       setState(() {
// // // // //         _isSplashVisible = false;
// // // // //       });
// // // // //     });
// // // // //   }
// // // // //
// // // // //   Future<void> _enableScreenProtection() async {
// // // // //     try {
// // // // //       if (Platform.isAndroid) {
// // // // //         await ScreenProtector.protectDataLeakageOn();
// // // // //       } else if (Platform.isIOS) {
// // // // //         await ScreenProtector.preventScreenshotOn();
// // // // //       }
// // // // //     } catch (e) {
// // // // //       print("Error enabling screen protection: $e");
// // // // //     }
// // // // //   }
// // // // //
// // // // //   Future<void> _disableScreenProtection() async {
// // // // //     try {
// // // // //       if (Platform.isAndroid) {
// // // // //         await ScreenProtector.preventScreenshotOn();
// // // // //       } else if (Platform.isIOS) {
// // // // //         await ScreenProtector.preventScreenshotOn();
// // // // //       }
// // // // //     } catch (e) {
// // // // //       print("Error disabling screen protection: $e");
// // // // //     }
// // // // //   }
// // // // //
// // // // //   Future<bool> _onWillPop() async {
// // // // //     if (await _webViewController.canGoBack()) {
// // // // //       _webViewController.goBack();
// // // // //       return Future.value(false);
// // // // //     } else {
// // // // //       return Future.value(true);
// // // // //     }
// // // // //   }
// // // // //
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return WillPopScope(
// // // // //       onWillPop: _onWillPop,
// // // // //       child: Scaffold(
// // // // //         body: Stack(
// // // // //           children: [
// // // // //             // WebView
// // // // //             InAppWebView(
// // // // //               initialUrlRequest: URLRequest(url: WebUri(widget.mainUrl)),
// // // // //               initialSettings: InAppWebViewSettings(
// // // // //                 supportZoom: false,
// // // // //                 useWideViewPort: true,
// // // // //                 builtInZoomControls: false,
// // // // //                 displayZoomControls: true,
// // // // //               ),
// // // // //               onWebViewCreated: (InAppWebViewController controller) {
// // // // //                 _webViewController = controller;
// // // // //               },
// // // // //               onLoadStart: (controller, url) {
// // // // //                 setState(() {
// // // // //                   _isWebViewLoaded = false; // Show splash screen while loading
// // // // //                 });
// // // // //               },
// // // // //               onLoadStop: (controller, url) async {
// // // // //                 setState(() {
// // // // //                   _isWebViewLoaded = true; // Hide splash when loading completes
// // // // //                 });
// // // // //               },
// // // // //             ),
// // // // //             // Splash Screen
// // // // //             if (_isSplashVisible)
// // // // //               Center(
// // // // //                 child: Image.asset(
// // // // //                   'assets/splash.gif',
// // // // //                   width: MediaQuery.of(context).size.width,
// // // // //                   height: MediaQuery.of(context).size.height,
// // // // //                   fit: BoxFit.cover,
// // // // //                 ),
// // // // //               ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // //
// // // // //   @override
// // // // //   void dispose() {
// // // // //     _disableScreenProtection();
// // // // //     super.dispose();
// // // // //   }
// // // // // }
// // // //
// // // //
// // // // import 'dart:io';
// // // // import 'dart:async';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // // // import 'package:screen_protector/screen_protector.dart';
// // // // import 'package:url_launcher/url_launcher.dart';
// // // // import 'package:http/http.dart' as http;
// // // // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // // //
// // // // void main() {
// // // //   runApp(MyApp());
// // // // }
// // // //
// // // // class MyApp extends StatelessWidget {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return MaterialApp(
// // // //       debugShowCheckedModeBanner: false,
// // // //       title: 'KNG',
// // // //       theme: ThemeData(
// // // //         brightness: Brightness.light,
// // // //         scaffoldBackgroundColor: Colors.white,
// // // //         appBarTheme: AppBarTheme(
// // // //           backgroundColor: Colors.white,
// // // //           iconTheme: IconThemeData(color: Colors.black),
// // // //           titleTextStyle: TextStyle(color: Colors.black),
// // // //         ),
// // // //         textTheme: TextTheme(
// // // //           bodyLarge: TextStyle(color: Colors.black),
// // // //         ),
// // // //         colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
// // // //       ),
// // // //       home: WebViewScreen(mainUrl: 'https://catalogue.gbjewelsync.com'),
// // // //     );
// // // //   }
// // // // }
// // // // class WebViewScreen extends StatefulWidget {
// // // //   final String mainUrl;
// // // //   WebViewScreen({required this.mainUrl});
// // // //
// // // //   @override
// // // //   _WebViewScreenState createState() => _WebViewScreenState();
// // // // }
// // // //
// // // // class _WebViewScreenState extends State<WebViewScreen> {
// // // //   late InAppWebViewController _webViewController;
// // // //   bool _isWebViewLoaded = false;
// // // //   bool _isSplashVisible = true;
// // // //
// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     _startSplashTimer();
// // // //     _enableScreenProtection();
// // // //   }
// // // //
// // // //   void _startSplashTimer() {
// // // //     Future.delayed(Duration(seconds: 3), () {
// // // //       setState(() {
// // // //         _isSplashVisible = false;
// // // //       });
// // // //     });
// // // //   }
// // // //
// // // //   Future<void> _enableScreenProtection() async {
// // // //     try {
// // // //       if (Platform.isAndroid) {
// // // //         await ScreenProtector.protectDataLeakageOn();
// // // //       } else if (Platform.isIOS) {
// // // //         await ScreenProtector.preventScreenshotOn();
// // // //       }
// // // //     } catch (e) {
// // // //       print("Error enabling screen protection: $e");
// // // //     }
// // // //   }
// // // //
// // // //   Future<void> _disableScreenProtection() async {
// // // //     try {
// // // //       if (Platform.isAndroid) {
// // // //         await ScreenProtector.preventScreenshotOn();
// // // //       } else if (Platform.isIOS) {
// // // //         await ScreenProtector.preventScreenshotOn();
// // // //       }
// // // //     } catch (e) {
// // // //       print("Error disabling screen protection: $e");
// // // //     }
// // // //   }
// // // //
// // // //   Future<bool> _onWillPop() async {
// // // //     if (await _webViewController.canGoBack()) {
// // // //       _webViewController.goBack();
// // // //       return Future.value(false);
// // // //     } else {
// // // //       return Future.value(true);
// // // //     }
// // // //   }
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return WillPopScope(
// // // //       onWillPop: _onWillPop,
// // // //       child: Scaffold(
// // // //         body: Stack(
// // // //           children: [
// // // //             // WebView
// // // //             InAppWebView(
// // // //               initialUrlRequest: URLRequest(url: WebUri(widget.mainUrl)),
// // // //               initialSettings: InAppWebViewSettings(
// // // //                 supportZoom: false,
// // // //                 useWideViewPort: true,
// // // //                 builtInZoomControls: false,
// // // //                 displayZoomControls: true,
// // // //               ),
// // // //               onWebViewCreated: (InAppWebViewController controller) {
// // // //                 _webViewController = controller;
// // // //
// // // //                 // Register the JavaScript handler
// // // //                 _webViewController.addJavaScriptHandler(
// // // //                   handlerName: 'onItemDetailsClicked',
// // // //                   callback: (args) {
// // // //                     if (args.isNotEmpty) {
// // // //                       _handleItemDetailsClicked(args[0]);
// // // //                     }
// // // //                   },
// // // //                 );
// // // //
// // // //                 _webViewController.addJavaScriptHandler(
// // // //                   handlerName: 'openUrlInBrowser',
// // // //                   callback: (args) {
// // // //                     if (args.isNotEmpty) {
// // // //                       _openUrlInBrowser(args[0]); // Call the browser opening function
// // // //                     }
// // // //                   },
// // // //                 );
// // // //
// // // //                 _webViewController.addJavaScriptHandler(
// // // //                   handlerName: 'updateFcmToken',
// // // //                   callback: (args) {
// // // //                     if (args.isNotEmpty) {
// // // //                       _updateFcmToken(args[0]); // Call the browser opening function
// // // //                     }
// // // //                   },
// // // //                 );
// // // //               },
// // // //               onLoadStart: (InAppWebViewController controller, Uri? url) {
// // // //
// // // //               },
// // // //               onLoadStop: (InAppWebViewController controller, Uri? url) async {
// // // //
// // // //                 if (url != null && url.toString() == "https://catalogue.gbjewelsync.com/login") {
// // // //                   await controller.loadUrl(
// // // //                     urlRequest: URLRequest(url: WebUri("https://catalogue.gbjewelsync.com/login/KNG")),
// // // //                   );
// // // //                 }
// // // //                 if (url != null && url.toString() == "https://catalogue.gbjewelsync.com/signup") {
// // // //                   await controller.loadUrl(
// // // //                     urlRequest: URLRequest(url: WebUri("https://catalogue.gbjewelsync.com/signup/KNG")),
// // // //                   );
// // // //                 }
// // // //                 print("Finished loading: $url");
// // // //               },
// // // //             ),
// // // //             // Splash Screen
// // // //             if (_isSplashVisible)
// // // //               Center(
// // // //                 child: Image.asset(
// // // //                   'assets/splash.gif',
// // // //                   width: MediaQuery.of(context).size.width,
// // // //                   height: MediaQuery.of(context).size.height,
// // // //                   fit: BoxFit.cover,
// // // //                 ),
// // // //               ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // //   void _handleItemDetailsClicked(String dataHref) {
// // // //     if (Platform.isAndroid) {
// // // //       Navigator.push(
// // // //         context,
// // // //         PageRouteBuilder(
// // // //           pageBuilder: (context, animation, secondaryAnimation) =>
// // // //               WebViewScreen(mainUrl: dataHref),
// // // //           transitionsBuilder: (context, animation, secondaryAnimation, child) {
// // // //             const begin = Offset(1.0, 0.0);
// // // //             const end = Offset.zero;
// // // //             const curve = Curves.easeInOut;
// // // //
// // // //             var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
// // // //             var offsetAnimation = animation.drive(tween);
// // // //
// // // //             return SlideTransition(
// // // //               position: offsetAnimation,
// // // //               child: child,
// // // //             );
// // // //           },
// // // //         ),
// // // //       );
// // // //     }
// // // //   }
// // // //
// // // //   Future<void> _openUrlInBrowser(String url) async {
// // // //     final Uri uri = Uri.parse(url);
// // // //
// // // //     if (await canLaunchUrl(uri)) {
// // // //       await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
// // // //     }
// // // //   }
// // // //
// // // //   Future<void> _updateFcmToken(String token) async {
// // // //     print("Hello this is token: "+token);
// // // //
// // // //     String? _fcmToken;
// // // //
// // // //     // final token1 = await NotificationService.instance.getFCMToken();
// // // //     // setState(() {
// // // //     //   _fcmToken = token1;
// // // //     // });
// // // //
// // // //     final Map<String, String> headers = {
// // // //       'Authorization': 'Bearer $token',
// // // //     };
// // // //
// // // //     final response = await http.get(
// // // //         Uri.parse('https://gbjewelsync.com/api/catalogue/banners?device_token=$_fcmToken'), headers: headers);
// // // //
// // // //     if (response.statusCode == 200) {
// // // //       //
// // // //     }
// // // //   }
// // // //
// // // //   @override
// // // //   void dispose() {
// // // //     _disableScreenProtection();
// // // //     super.dispose();
// // // //   }
// // // // }
// // //
// // // import 'package:connectivity_plus/connectivity_plus.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // // import 'package:screen_protector/screen_protector.dart';
// // // import 'dart:async';
// // // import 'dart:io';
// // // import 'package:url_launcher/url_launcher.dart';
// // // import 'package:http/http.dart' as http;
// // //
// // //
// // // void main() {
// // //   runApp(MyApp());
// // // }
// // //
// // // class MyApp extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       debugShowCheckedModeBanner: false,
// // //       title: 'KNG',
// // //       theme: ThemeData(
// // //         brightness: Brightness.light,
// // //         scaffoldBackgroundColor: Colors.white,
// // //         appBarTheme: AppBarTheme(
// // //           backgroundColor: Colors.white,
// // //           iconTheme: IconThemeData(color: Colors.black),
// // //           titleTextStyle: TextStyle(color: Colors.black),
// // //         ),
// // //         textTheme: TextTheme(
// // //           bodyLarge: TextStyle(color: Colors.black),
// // //         ),
// // //         colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
// // //       ),
// // //       home: WebViewScreen(mainUrl: 'https://catalogue.gbjewelsync.com'),
// // //     );
// // //   }
// // // }
// // //
// // // class WebViewScreen extends StatefulWidget {
// // //   final String mainUrl;
// // //   WebViewScreen({required this.mainUrl});
// // //
// // //   @override
// // //   _WebViewScreenState createState() => _WebViewScreenState();
// // // }
// // //
// // // class _WebViewScreenState extends State<WebViewScreen> {
// // //   late InAppWebViewController _webViewController;
// // //   bool _isWebViewLoaded = false;
// // //   bool _isSplashVisible = true;
// // //   bool _isNetworkAvailable = true;
// // //   late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
// // //
// // //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _startSplashTimer();
// // //     _enableScreenProtection();
// // //     _checkNetworkConnectivity();
// // //     _connectivitySubscription = Connectivity().onConnectivityChanged.listen((result) {
// // //       if (result.isNotEmpty) {
// // //         _updateNetworkStatus(result.first); // Handle first result
// // //       }
// // //     });
// // //   }
// // //
// // //   void _startSplashTimer() {
// // //     Future.delayed(Duration(seconds: 3), () {
// // //       setState(() {
// // //         _isSplashVisible = false;
// // //       });
// // //     });
// // //   }
// // //
// // //   Future<void> _enableScreenProtection() async {
// // //     try {
// // //       if (Platform.isAndroid) {
// // //         await ScreenProtector.protectDataLeakageOn();
// // //       } else if (Platform.isIOS) {
// // //         await ScreenProtector.preventScreenshotOn();
// // //       }
// // //     } catch (e) {
// // //       print("Error enabling screen protection: $e");
// // //     }
// // //   }
// // //
// // //   Future<void> _disableScreenProtection() async {
// // //     try {
// // //       if (Platform.isAndroid) {
// // //         await ScreenProtector.preventScreenshotOn();
// // //       } else if (Platform.isIOS) {
// // //         await ScreenProtector.preventScreenshotOn();
// // //       }
// // //     } catch (e) {
// // //       print("Error disabling screen protection: $e");
// // //     }
// // //   }
// // //
// // //   void _updateNetworkStatus(ConnectivityResult result) {
// // //     setState(() {
// // //       _isNetworkAvailable = result != ConnectivityResult.none; // Check for network availability
// // //     });
// // //   }
// // //
// // //   Future<void> _checkNetworkConnectivity() async {
// // //     // Getting the connectivity result, which may be a List of ConnectivityResult
// // //     final List<ConnectivityResult> connectivityResults = await Connectivity().checkConnectivity();
// // //
// // //     // Assuming we are just interested in the first item in the list (if the list is non-empty)
// // //     if (connectivityResults.isNotEmpty) {
// // //       _updateNetworkStatus(connectivityResults.first);  // Update with the first result in the list
// // //     }
// // //   }
// // //
// // //   Future<bool> _onWillPop() async {
// // //     if (await _webViewController.canGoBack()) {
// // //       _webViewController.goBack();
// // //       return Future.value(false); // Prevent app from exiting if WebView can go back
// // //     } else {
// // //       // Show confirmation dialog
// // //       bool shouldExit = await showDialog(
// // //         context: context,
// // //         builder: (BuildContext context) {
// // //           return AlertDialog(
// // //             title: Text("Exit App"),
// // //             content: Text("Are you sure you want to exit the app?"),
// // //             actions: [
// // //               TextButton(
// // //                 onPressed: () {
// // //                   Navigator.of(context).pop(false); // User pressed "No"
// // //                 },
// // //                 child: Text("No"),
// // //               ),
// // //               TextButton(
// // //                 onPressed: () {
// // //                   Navigator.of(context).pop(true); // User pressed "Yes"
// // //                 },
// // //                 child: Text("Yes"),
// // //               ),
// // //             ],
// // //           );
// // //         },
// // //       );
// // //
// // //       return shouldExit ?? false; // Exit the app if the user confirms
// // //     }
// // //   }
// // //
// // //
// // //   // Future<bool> _onWillPop() async {
// // //   //   if (await _webViewController.canGoBack()) {
// // //   //     _webViewController.goBack();
// // //   //     return Future.value(false);
// // //   //   } else {
// // //   //
// // //   //     return Future.value(true);
// // //   //   }
// // //   // }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return WillPopScope(
// // //       onWillPop: _onWillPop,
// // //       child: Scaffold(
// // //         appBar: PreferredSize(
// // //           preferredSize: Size.fromHeight(0),
// // //           child: AppBar(
// // //             title: Text('KNG'),
// // //             centerTitle: true,
// // //           ),
// // //         ),
// // //         body: Stack(
// // //           children: [
// // //             // Main content (WebView or NoNetworkPage)
// // //             AnimatedSwitcher(
// // //               duration: Duration(milliseconds: 300),
// // //               child: _isNetworkAvailable
// // //                   ? Container(
// // //                 key: ValueKey('WebView'),
// // //                 child: InAppWebView(
// // //                   initialUrlRequest: URLRequest(url: WebUri(widget.mainUrl)),
// // //                   initialSettings: InAppWebViewSettings(
// // //                     supportZoom: false,
// // //                     useWideViewPort: true,
// // //                     builtInZoomControls: false,
// // //                     displayZoomControls: true,
// // //                   ),
// // //                   onWebViewCreated: (InAppWebViewController controller) {
// // //                     _webViewController = controller;
// // //                     // Register the JavaScript handler
// // //                 _webViewController.addJavaScriptHandler(
// // //                   handlerName: 'onItemDetailsClicked',
// // //                   callback: (args) {
// // //                     if (args.isNotEmpty) {
// // //                       _handleItemDetailsClicked(args[0]);
// // //                     }
// // //                   },
// // //                 );
// // //
// // //                 _webViewController.addJavaScriptHandler(
// // //                   handlerName: 'openUrlInBrowser',
// // //                   callback: (args) {
// // //                     if (args.isNotEmpty) {
// // //                       _openUrlInBrowser(args[0]); // Call the browser opening function
// // //                     }
// // //                   },
// // //                 );
// // //
// // //                   },
// // //                   onLoadStart: (InAppWebViewController controller, Uri? url) {},
// // //                   onLoadStop: (InAppWebViewController controller, Uri? url) async {
// // //                     if (url != null && url.toString() == "https://catalogue.gbjewelsync.com/login") {
// // //                       await controller.loadUrl(
// // //                         urlRequest: URLRequest(url: WebUri("https://catalogue.gbjewelsync.com/login/KNG")),
// // //                       );
// // //                     }
// // //                     if (url != null && url.toString() == "https://catalogue.gbjewelsync.com/signup") {
// // //                       await controller.loadUrl(
// // //                         urlRequest: URLRequest(url: WebUri("https://catalogue.gbjewelsync.com/signup/KNG")),
// // //                       );
// // //                     }
// // //                   },
// // //                 ),
// // //               )
// // //                   : Container(
// // //                 key: ValueKey('NoNetwork'),
// // //                 child: NoNetworkPage(
// // //                   onRetry: _checkNetworkConnectivity,
// // //                 ),
// // //               ),
// // //             ),
// // //
// // //             // Splash screen overlay
// // //             if (_isSplashVisible)
// // //               Positioned.fill(
// // //                 child: Center(
// // //                   child: Image.asset(
// // //                     'assets/splash.gif',
// // //                     width: MediaQuery.of(context).size.width,
// // //                     height: MediaQuery.of(context).size.height,
// // //                     fit: BoxFit.cover,
// // //                   ),
// // //                 ),
// // //               ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //
// // //   void _handleItemDetailsClicked(String dataHref) {
// // //     if (Platform.isAndroid) {
// // //       Navigator.push(
// // //         context,
// // //         PageRouteBuilder(
// // //           pageBuilder: (context, animation, secondaryAnimation) =>
// // //               WebViewScreen(mainUrl: dataHref),
// // //           transitionsBuilder: (context, animation, secondaryAnimation, child) {
// // //             const begin = Offset(1.0, 0.0);
// // //             const end = Offset.zero;
// // //             const curve = Curves.easeInOut;
// // //
// // //             var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
// // //             var offsetAnimation = animation.drive(tween);
// // //
// // //             return SlideTransition(
// // //               position: offsetAnimation,
// // //               child: child,
// // //             );
// // //           },
// // //         ),
// // //       );
// // //     }
// // //   }
// // //
// // //   Future<void> _openUrlInBrowser(String url) async {
// // //     final Uri uri = Uri.parse(url);
// // //
// // //     if (await canLaunchUrl(uri)) {
// // //       await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
// // //     }
// // //   }
// // //
// // //   @override
// // //   void dispose() {
// // //     _connectivitySubscription.cancel();  // Cancel the subscription when done
// // //     _disableScreenProtection();
// // //     super.dispose();
// // //   }
// // // }
// // //
// // //
// // // class NoNetworkPage extends StatelessWidget {
// // //   final VoidCallback onRetry;
// // //
// // //   NoNetworkPage({required this.onRetry});
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Center(
// // //       child: Column(
// // //         mainAxisAlignment: MainAxisAlignment.center,
// // //         children: [
// // //           Icon(Icons.wifi_off, size: 100, color: Colors.grey),
// // //           SizedBox(height: 20),
// // //           Text(
// // //             "No Internet Connection",
// // //             style: TextStyle(fontSize: 18, color: Colors.grey),
// // //           ),
// // //           SizedBox(height: 20),
// // //           ElevatedButton(
// // //             onPressed: onRetry,
// // //             child: Text("Retry"),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }
// //
// //
// //
// // import 'package:connectivity_plus/connectivity_plus.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // import 'package:screen_protector/screen_protector.dart';
// // import 'dart:async';
// // import 'dart:io';
// // import 'package:url_launcher/url_launcher.dart';
// // import 'package:http/http.dart' as http;
// //
// //
// // void main() {
// //   runApp(MyApp());
// // }
// //
// // bool _isSplashVisible = true;
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       title: 'KNG',
// //       theme: ThemeData(
// //         brightness: Brightness.light,
// //         scaffoldBackgroundColor: Colors.white,
// //         appBarTheme: AppBarTheme(
// //           backgroundColor: Colors.white,
// //           iconTheme: IconThemeData(color: Colors.black),
// //           titleTextStyle: TextStyle(color: Colors.black),
// //         ),
// //         textTheme: TextTheme(
// //           bodyLarge: TextStyle(color: Colors.black),
// //         ),
// //         colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
// //       ),
// //       home: WebViewScreen(mainUrl: 'https://catalogue.gbjewelsync.com'),
// //     );
// //   }
// // }
// //
// // class WebViewScreen extends StatefulWidget {
// //   final String mainUrl;
// //   WebViewScreen({required this.mainUrl});
// //
// //   @override
// //   _WebViewScreenState createState() => _WebViewScreenState();
// // }
// //
// // class _WebViewScreenState extends State<WebViewScreen> {
// //   late InAppWebViewController _webViewController;
// //   bool _isNetworkAvailable = true;
// //   late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
// //
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _startSplashTimer();
// //     _enableScreenProtection();
// //     _checkNetworkConnectivity();
// //     _connectivitySubscription = Connectivity().onConnectivityChanged.listen((result) {
// //       if (result.isNotEmpty) {
// //         _updateNetworkStatus(result.first); // Handle first result
// //       }
// //     });
// //   }
// //
// //   void _startSplashTimer() {
// //     Future.delayed(Duration(seconds: 3), () {
// //       setState(() {
// //         _isSplashVisible = false;
// //       });
// //     });
// //   }
// //
// //   Future<void> _enableScreenProtection() async {
// //     try {
// //       if (Platform.isAndroid) {
// //         await ScreenProtector.protectDataLeakageOn();
// //       } else if (Platform.isIOS) {
// //         await ScreenProtector.preventScreenshotOn();
// //       }
// //     } catch (e) {
// //       print("Error enabling screen protection: $e");
// //     }
// //   }
// //
// //   Future<void> _disableScreenProtection() async {
// //     try {
// //       if (Platform.isAndroid) {
// //         await ScreenProtector.preventScreenshotOn();
// //       } else if (Platform.isIOS) {
// //         await ScreenProtector.preventScreenshotOn();
// //       }
// //     } catch (e) {
// //       print("Error disabling screen protection: $e");
// //     }
// //   }
// //
// //   void _updateNetworkStatus(ConnectivityResult result) {
// //     setState(() {
// //       _isNetworkAvailable = result != ConnectivityResult.none; // Check for network availability
// //     });
// //   }
// //
// //   Future<void> _checkNetworkConnectivity() async {
// //     // Getting the connectivity result, which may be a List of ConnectivityResult
// //     final List<ConnectivityResult> connectivityResults = await Connectivity().checkConnectivity();
// //
// //     // Assuming we are just interested in the first item in the list (if the list is non-empty)
// //     if (connectivityResults.isNotEmpty) {
// //       _updateNetworkStatus(connectivityResults.first);  // Update with the first result in the list
// //     }
// //   }
// //
// //   Future<bool> _onWillPop() async {
// //     // Check the current URL in the InAppWebView
// //     Uri? currentUrl = await _webViewController.getUrl();
// //
// //     if (currentUrl != null && currentUrl.toString() == 'https://catalogue.gbjewelsync.com/') {
// //       // Show confirmation dialog when on the specified URL
// //       bool shouldExit = await showDialog(
// //         context: context,
// //         builder: (BuildContext context) {
// //           return AlertDialog(
// //             title: Text("Exit App"),
// //             content: Text("Are you sure you want to exit the app?"),
// //             actions: [
// //               TextButton(
// //                 onPressed: () {
// //                   Navigator.of(context).pop(false); // User pressed "No"
// //                 },
// //                 child: Text("No"),
// //               ),
// //               TextButton(
// //                 onPressed: () {
// //                   Navigator.of(context).pop(true); // User pressed "Yes"
// //                 },
// //                 child: Text("Yes"),
// //               ),
// //             ],
// //           );
// //         },
// //       );
// //
// //       return shouldExit ?? false; // Return user's decision
// //     }
// //
// //     // Default behavior: Go back if possible
// //     if (await _webViewController.canGoBack()) {
// //       _webViewController.goBack();
// //       return Future.value(false); // Prevent app from exiting
// //     } else {
// //       return Future.value(true); // Exit the app
// //     }
// //   }
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return WillPopScope(
// //
// //       onWillPop: _onWillPop,
// //       child: Scaffold(
// //         appBar: PreferredSize(
// //           preferredSize: Size.fromHeight(0),
// //           child: AppBar(
// //             title: Text('KNG'),
// //             centerTitle: true,
// //           ),
// //         ),
// //         body: Stack(
// //           children: [
// //             // Main content (WebView or NoNetworkPage)
// //             AnimatedSwitcher(
// //               duration: Duration(milliseconds: 300),
// //               child: _isNetworkAvailable
// //                   ? Container(
// //                 key: ValueKey('WebView'),
// //                 child: InAppWebView(
// //                   initialUrlRequest: URLRequest(url: WebUri(widget.mainUrl)),
// //                   initialSettings: InAppWebViewSettings(
// //                     supportZoom: false,
// //                     useWideViewPort: true,
// //                     builtInZoomControls: false,
// //                     displayZoomControls: true,
// //                   ),
// //                   onWebViewCreated: (InAppWebViewController controller) {
// //                     _webViewController = controller;
// //                     // Register the JavaScript handler
// //                     _webViewController.addJavaScriptHandler(
// //                       handlerName: 'onItemDetailsClicked',
// //                       callback: (args) {
// //                         if (args.isNotEmpty) {
// //                           _handleItemDetailsClicked(args[0]);
// //                         }
// //                       },
// //                     );
// //
// //                     _webViewController.addJavaScriptHandler(
// //                       handlerName: 'openUrlInBrowser',
// //                       callback: (args) {
// //                         if (args.isNotEmpty) {
// //                           _openUrlInBrowser(args[0]); // Call the browser opening function
// //                         }
// //                       },
// //                     );
// //
// //                   },
// //                   onLoadStart: (InAppWebViewController controller, Uri? url) {},
// //                   onLoadStop: (InAppWebViewController controller, Uri? url) async {
// //                     if (url != null && url.toString() == "https://catalogue.gbjewelsync.com/login") {
// //                       await controller.loadUrl(
// //                         urlRequest: URLRequest(url: WebUri("https://catalogue.gbjewelsync.com/login/KNG")),
// //                       );
// //                     }
// //                     if (url != null && url.toString() == "https://catalogue.gbjewelsync.com/signup") {
// //                       await controller.loadUrl(
// //                         urlRequest: URLRequest(url: WebUri("https://catalogue.gbjewelsync.com/signup/KNG")),
// //                       );
// //                     }
// //                   },
// //                 ),
// //               )
// //                   : Container(
// //                 key: ValueKey('NoNetwork'),
// //                 child: NoNetworkPage(
// //                   onRetry: _checkNetworkConnectivity,
// //                 ),
// //               ),
// //             ),
// //
// //             // Splash screen overlay
// //             if (_isSplashVisible)
// //               Positioned.fill(
// //                 child: Center(
// //                   child: Image.asset(
// //                     'assets/splash.gif',
// //                     width: MediaQuery.of(context).size.width,
// //                     height: MediaQuery.of(context).size.height,
// //                     fit: BoxFit.cover,
// //                   ),
// //                 ),
// //               ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //
// //   void _handleItemDetailsClicked(String dataHref) {
// //     if (Platform.isAndroid) {
// //       Navigator.push(
// //         context,
// //         PageRouteBuilder(
// //           pageBuilder: (context, animation, secondaryAnimation) =>
// //               WebViewScreen(mainUrl: dataHref),
// //           transitionsBuilder: (context, animation, secondaryAnimation, child) {
// //             const begin = Offset(1.0, 0.0);
// //             const end = Offset.zero;
// //             const curve = Curves.easeInOut;
// //
// //             var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
// //             var offsetAnimation = animation.drive(tween);
// //
// //             return SlideTransition(
// //               position: offsetAnimation,
// //               child: child,
// //             );
// //           },
// //         ),
// //       );
// //     }
// //   }
// //
// //   Future<void> _openUrlInBrowser(String url) async {
// //     setState(() {
// //       _isSplashVisible = false; // Hide splash screen when this method is triggered
// //     });
// //
// //     final Uri uri = Uri.parse(url);
// //
// //     if (await canLaunchUrl(uri)) {
// //       await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
// //     } else {
// //       print("Could not launch $url");
// //     }
// //   }
// //
// //
// //   @override
// //   void dispose() {
// //     _connectivitySubscription.cancel();  // Cancel the subscription when done
// //     _disableScreenProtection();
// //     super.dispose();
// //   }
// // }
// //
// // class NoNetworkPage extends StatelessWidget {
// //   final VoidCallback onRetry;
// //
// //   NoNetworkPage({required this.onRetry});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Icon(Icons.wifi_off, size: 100, color: Colors.grey),
// //           SizedBox(height: 20),
// //           Text(
// //             "No Internet Connection",
// //             style: TextStyle(fontSize: 18, color: Colors.grey),
// //           ),
// //           SizedBox(height: 20),
// //           ElevatedButton(
// //             onPressed: onRetry,
// //             child: Text("Retry"),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//
//
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:screen_protector/screen_protector.dart';
// import 'dart:async';
// import 'dart:io';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:http/http.dart' as http;
// import 'package:firebase_core/firebase_core.dart';
// import 'notification_service.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// void main() async{
//
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//   runApp(MyApp());
// }
//
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async {
//   await Firebase.initializeApp();
//   print(message.notification?.title.toString());
// }
//
//
//
//
// bool _isSplashVisible = true;
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'KNG',
//       theme: ThemeData(
//         brightness: Brightness.light,
//         scaffoldBackgroundColor: Colors.white,
//         appBarTheme: AppBarTheme(
//           backgroundColor: Colors.white,
//           iconTheme: IconThemeData(color: Colors.black),
//           titleTextStyle: TextStyle(color: Colors.black),
//         ),
//         textTheme: TextTheme(
//           bodyLarge: TextStyle(color: Colors.black),
//         ),
//         colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
//       ),
//       home: WebViewScreen(mainUrl: 'https://catalogue.gbjewelsync.com'),
//     );
//   }
// }
//
// class WebViewScreen extends StatefulWidget {
//   final String mainUrl;
//   WebViewScreen({required this.mainUrl});
//
//   @override
//   _WebViewScreenState createState() => _WebViewScreenState();
// }
//
// class _WebViewScreenState extends State<WebViewScreen> {
//   late InAppWebViewController _webViewController;
//   bool _isNetworkAvailable = true;
//   late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
//   String? _fcmToken; // To store the FCM token
//
//
//   @override
//   void initState() {
//     super.initState();
//
//     _fetchFCMToken();
//     _startSplashTimer();
//     _enableScreenProtection();
//     _checkNetworkConnectivity();
//     _connectivitySubscription = Connectivity().onConnectivityChanged.listen((result) {
//       if (result.isNotEmpty) {
//         _updateNetworkStatus(result.first); // Handle first result
//       }
//     });
//   }
//
//   void _startSplashTimer() {
//     Future.delayed(Duration(seconds: 3), () {
//       setState(() {
//         _isSplashVisible = false;
//       });
//     });
//   }
//
//   Future<void> _enableScreenProtection() async {
//     try {
//       if (Platform.isAndroid) {
//         await ScreenProtector.protectDataLeakageOn();
//       } else if (Platform.isIOS) {
//         await ScreenProtector.preventScreenshotOn();
//       }
//     } catch (e) {
//       print("Error enabling screen protection: $e");
//     }
//   }
//
//   Future<void> _disableScreenProtection() async {
//     try {
//       if (Platform.isAndroid) {
//         await ScreenProtector.preventScreenshotOn();
//       } else if (Platform.isIOS) {
//         await ScreenProtector.preventScreenshotOn();
//       }
//     } catch (e) {
//       print("Error disabling screen protection: $e");
//     }
//   }
//
//   void _updateNetworkStatus(ConnectivityResult result) {
//     setState(() {
//       _isNetworkAvailable = result != ConnectivityResult.none; // Check for network availability
//     });
//   }
//
//   Future<void> _checkNetworkConnectivity() async {
//     // Getting the connectivity result, which may be a List of ConnectivityResult
//     final List<ConnectivityResult> connectivityResults = await Connectivity().checkConnectivity();
//
//     // Assuming we are just interested in the first item in the list (if the list is non-empty)
//     if (connectivityResults.isNotEmpty) {
//       _updateNetworkStatus(connectivityResults.first);  // Update with the first result in the list
//     }
//   }
//
//   Future<bool> _onWillPop() async {
//     // Check the current URL in the InAppWebView
//     Uri? currentUrl = await _webViewController.getUrl();
//
//     if (currentUrl != null && currentUrl.toString() == 'https://catalogue.gbjewelsync.com') {
//       // Show confirmation dialog when on the specified URL
//       bool shouldExit = await showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Exit App"),
//             content: Text("Are you sure you want to exit the app?"),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(false); // User pressed "No"
//                 },
//                 child: Text("No"),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(true); // User pressed "Yes"
//                 },
//                 child: Text("Yes"),
//               ),
//             ],
//           );
//         },
//       );
//
//       return shouldExit ?? false; // Return user's decision
//     }
//
//     // Default behavior: Go back if possible
//     if (await _webViewController.canGoBack()) {
//       _webViewController.goBack();
//       return Future.value(false); // Prevent app from exiting
//     } else {
//       return Future.value(true); // Exit the app
//     }
//   }
//
//   Future<void> _fetchFCMToken() async {
//     final token = await NotificationService.instance.getFCMToken();
//
//     setState(() {
//       _fcmToken = token;
//     });
//     print("tokan is" + _fcmToken!);
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//
//       onWillPop: _onWillPop,
//       child: Scaffold(
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(0),
//           child: AppBar(
//             title: Text('KNG'),
//             centerTitle: true,
//           ),
//         ),
//         body: Stack(
//           children: [
//             // Main content (WebView or NoNetworkPage)
//             AnimatedSwitcher(
//               duration: Duration(milliseconds: 300),
//               child: _isNetworkAvailable
//                   ? Container(
//                 key: ValueKey('WebView'),
//                 child: InAppWebView(
//                   initialUrlRequest: URLRequest(url: WebUri(widget.mainUrl)),
//                   initialSettings: InAppWebViewSettings(
//                     supportZoom: false,
//                     useWideViewPort: true,
//                     builtInZoomControls: false,
//                     displayZoomControls: false,
//                   ),
//                   onWebViewCreated: (InAppWebViewController controller) {
//                     _webViewController = controller;
//                     // Register the JavaScript handler
//                     _webViewController.addJavaScriptHandler(
//                       handlerName: 'onItemDetailsClicked',
//                       callback: (args) {
//                         if (args.isNotEmpty) {
//                           _handleItemDetailsClicked(args[0]);
//                         }
//                       },
//                     );
//
//                     _webViewController.addJavaScriptHandler(
//                       handlerName: 'openUrlInBrowser',
//                       callback: (args) {
//                         if (args.isNotEmpty) {
//                           _openUrlInBrowser(args[0]); // Call the browser opening function
//                         }
//                       },
//                     );
//
//                     _webViewController.addJavaScriptHandler(
//                       handlerName: 'updateFcmToken',
//                       callback: (args) {
//                         if (args.isNotEmpty) {
//                           _updateFcmToken(args[0]); // Call the browser opening function
//                         }
//                       },
//                     );
//
//                   },
//                   onLoadStart: (InAppWebViewController controller, Uri? url) {},
//                   onLoadStop: (InAppWebViewController controller, Uri? url) async {
//                     if (url != null && url.toString() == "https://catalogue.gbjewelsync.com/login") {
//                       await controller.loadUrl(
//                         urlRequest: URLRequest(url: WebUri("https://catalogue.gbjewelsync.com/login/KNG")),
//                       );
//                     }
//                     if (url != null && url.toString() == "https://catalogue.gbjewelsync.com/signup") {
//                       await controller.loadUrl(
//                         urlRequest: URLRequest(url: WebUri("https://catalogue.gbjewelsync.com/signup/KNG")),
//                       );
//                     }
//                   },
//                 ),
//               )
//                   : Container(
//                 key: ValueKey('NoNetwork'),
//                 child: NoNetworkPage(
//                   onRetry: _checkNetworkConnectivity,
//                 ),
//               ),
//             ),
//
//             // Splash screen overlay
//             if (_isSplashVisible)
//               Positioned.fill(
//                 child: Center(
//                   child: Image.asset(
//                     'assets/splash.gif',
//                     width: MediaQuery.of(context).size.width,
//                     height: MediaQuery.of(context).size.height,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   void _handleItemDetailsClicked(String dataHref) {
//     if (Platform.isAndroid) {
//       Navigator.push(
//         context,
//         PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation) =>
//               WebViewScreen(mainUrl: dataHref),
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             const begin = Offset(1.0, 0.0);
//             const end = Offset.zero;
//             const curve = Curves.easeInOut;
//
//             var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//             var offsetAnimation = animation.drive(tween);
//
//             return SlideTransition(
//               position: offsetAnimation,
//               child: child,
//             );
//           },
//         ),
//       );
//     }
//   }
//
//   Future<void> _openUrlInBrowser(String url) async {
//     setState(() {
//       _isSplashVisible = false; // Hide splash screen when this method is triggered
//     });
//
//     final Uri uri = Uri.parse(url);
//
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
//     } else {
//       print("Could not launch $url");
//     }
//   }
//
//   Future<void> _updateFcmToken(String token1) async {
//     final token = await NotificationService.instance.getFCMToken();
//
//     setState(() {
//       _fcmToken = token;
//     });
//
//     final Map<String, String> headers = {
//       'Authorization': 'Bearer $token1',
//     };
//
//     print('here');
//     print(_fcmToken);
//     print("here is passed token : $token1");
//     final response = await http.get(
//         Uri.parse('https://gbjewelsync.com/api/catalogue/banners?device_token=$_fcmToken'), headers: headers);
//
//     if (response.statusCode == 200) {
//       print("token passed");
//     }
//   }
//
//   @override
//   void dispose() {
//     _connectivitySubscription.cancel();  // Cancel the subscription when done
//     _disableScreenProtection();
//     super.dispose();
//   }
// }
//
// class NoNetworkPage extends StatelessWidget {
//   final VoidCallback onRetry;
//
//   NoNetworkPage({required this.onRetry});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.wifi_off, size: 100, color: Colors.grey),
//           SizedBox(height: 20),
//           Text(
//             "No Internet Connection",
//             style: TextStyle(fontSize: 18, color: Colors.grey),
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: onRetry,
//             child: Text("Retry"),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
// // class MyApp extends StatelessWidget {
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       title: 'KNG',
// //       theme: ThemeData(
// //         brightness: Brightness.light,
// //         scaffoldBackgroundColor: Colors.white,
// //         appBarTheme: AppBarTheme(
// //           backgroundColor: Colors.white,
// //           iconTheme: IconThemeData(color: Colors.black),
// //           titleTextStyle: TextStyle(color: Colors.black),
// //         ),
// //         textTheme: TextTheme(
// //           bodyLarge: TextStyle(color: Colors.black),
// //         ),
// //         colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
// //       ),
// //       home: WebViewScreen(mainUrl: 'https://catalogue.gbjewelsync.com'),
// //     );
// //   }
// // }

