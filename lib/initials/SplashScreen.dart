import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../theme/app_color.dart';
import '../auth/login_form.dart';
import '../routes/routes.dart';
import 'dart:convert';
import '../ui/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var Token;
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

  @override
  void initState() {
    super.initState();

    gettoken();

    Future.delayed(Duration(seconds: 2), () {
      if (Token == null) {
        if (mounted) {
          // Check if the widget is still mounted before navigating
          Navigator.of(context).pushReplacementNamed(
            RouteGenerator.login,
          );
        }
      } else {
        if (mounted) {
          // Check if the widget is still mounted before updating the state
          setState(() {
            token = Token;
          });
        }

        getinfo();

        if (mounted) {
          // Check if the widget is still mounted before navigating
          Navigator.of(context).pushReplacementNamed(
            RouteGenerator.main,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    // Dispose any resources here if needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.kForthColor,
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: 0.7.sw,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logoicon.png',
                    alignment: Alignment.topCenter,
                    height: 90,
                    width: 150,
                  ),
                  Text(
                    'KickFunding',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: AppColor.kAccentColor,
                        ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Easiest way to ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColor.kAccentColor,
                        ),
                      ),
                      Text(
                        'help others',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColor.korange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
