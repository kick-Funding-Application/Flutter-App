import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:kickfunding/routes/routes.dart';
import 'package:kickfunding/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  Stripe.publishableKey =
      "pk_test_51N0o6jCUAXypJ6z6gycLGWxDVCj9SOqAkwuANiooRX9A7Ve1W0qVnpl71cHwzcVKDnLHu1OxrOObLR1V2BmxUYOz001bHflmdD";

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class SessionManager {
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> setLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', value);
  }
}

class MyApp extends StatefulWidget {
  final bool isLoggedIn;

  MyApp({required this.isLoggedIn});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SessionManager sessionManager = SessionManager();
  bool isLoggedIn = false;
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    bool loggedIn = await sessionManager.isLoggedIn();
    setState(() {
      isLoggedIn = loggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 896),
      builder: (context, child) => MaterialApp(
        title: 'KickFunding',
        theme: AppTheme(context).initTheme(),
        debugShowCheckedModeBanner: false,
        initialRoute:
            widget.isLoggedIn ? RouteGenerator.main : RouteGenerator.splash,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
