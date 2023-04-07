import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_color.dart';
import '../routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 2),
      () => Navigator.of(context).pushReplacementNamed(
        RouteGenerator.onboarding,
      ),
    );
    super.initState();
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
