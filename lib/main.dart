import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:kickfunding/auth/login_form.dart';
import 'package:kickfunding/routes/routes.dart';
import 'package:kickfunding/theme/app_theme.dart';
import 'package:http/http.dart' as http;
import 'ui/constants.dart';
import 'dart:convert';

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
  void getinfo() async {
    try {
      var url2 = Uri.parse("${constant.server}api/dj-rest-auth/user/");
      var response2 = await http.get(
        url2,
        headers: {
          'content-Type': 'application/json',
          "Authorization": " Token ${Token}"
        },
      );

      var data2 = json.decode(response2.body);
      print(response2.statusCode);
      if (1 == 1) {
        String userImage = data2["user_image"].toString();
        String defaultImage =
            "https://th.bing.com/th/id/OIP.OF59vsDmwxPP1tw7b_8clQHaE8?pid=ImgDet&rs=1";

        if (userImage == "null") {
          setState(() {
            constant.urlprofile = defaultImage;
          });
        } else {
          constant.urlprofile = userImage;
        }

        setState(() {
          constant.Username = data2["username"].toString();
          constant.bdateuser = data2["birth_date"].toString();
          constant.countryuser = data2["country"].toString();
          constant.first_name = data2["first_name"].toString();
          constant.last_name = data2["last_name"].toString();
          constant.phoneuser = data2["phone_number"].toString();
          constant.email = data2["email"].toString();
        });
      } else {
        print('failed to load data');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  gettoken() async {
    final prefs = await SharedPreferences.getInstance();
    Token = prefs.get('token');
  }

  SessionManager sessionManager = SessionManager();
  bool isLoggedIn = false;
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  var Token;
  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    Token = prefs.get('token');
    if (Token != null) {
      setState(() {
         token = Token;
      });
      
      getinfo();
    }
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
            Token == null ? RouteGenerator.splash : RouteGenerator.main,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
