
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
//import 'package:kickfunding/initials/SplashScreen.dart';
import 'package:kickfunding/routes/routes.dart';
import 'package:kickfunding/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:google_fonts/google_fonts.dart';

// import 'auth/login_screen.dart';
// import 'auth/signup_screen.dart';
// import 'initials/onboarding_screen.dart';

Future main() async {
  Stripe.publishableKey =
      "pk_test_51N0o6jCUAXypJ6z6gycLGWxDVCj9SOqAkwuANiooRX9A7Ve1W0qVnpl71cHwzcVKDnLHu1OxrOObLR1V2BmxUYOz001bHflmdD";

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Retrieve login status
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  // Redirect to appropriate screen
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  bool isLoggedIn;

  MyApp({required this.isLoggedIn});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 896),
      builder: (context, child) => MaterialApp(
        title: 'KickFunding',
        theme: AppTheme(context).initTheme(),
        debugShowCheckedModeBanner: false,
        initialRoute: isLoggedIn ? RouteGenerator.main : RouteGenerator.splash,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
