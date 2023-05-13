import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../theme/app_color.dart';
import '../routes/routes.dart';
import '../ui/custom_input_field.dart';
import 'login_form.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kForthColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'KickFunding',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: AppColor.kAccentColor,
                    ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(
                        16.w,
                        24.h,
                        16.w,
                        16.h,
                      ),
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.symmetric(
                        horizontal: 16.0.w,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          16.r,
                        ),
                      ),
                      child: Column(
                        children: [
                          //   LoginForm(),
                          SizedBox(
                            height: 32.h,
                          ),
                          GestureDetector(
                            onTap: () =>
                                Navigator.of(context).pushReplacementNamed(
                              RouteGenerator.signup,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t have account? ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: AppColor.kTextColor1,
                                      ),
                                ),
                                Text(
                                  'Create new account',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: AppColor.kAccentColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 24.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          16.r,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.kBlue.withOpacity(
                              0.5,
                            ),
                            offset: Offset(
                              0,
                              2.h,
                            ),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          LoginForm(),
                          SizedBox(
                            height: 32.h,
                          ),
                          GestureDetector(
                            onTap: () =>
                                Navigator.of(context).pushReplacementNamed(
                              RouteGenerator.signup,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t have account? ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: AppColor.kTextColor1,
                                      ),
                                ),
                                Text(
                                  'Create new account',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: AppColor.kAccentColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              Text(
                'Or Login With',
                style: TextStyle(
                  color: AppColor.kTextColor1,
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        8.r,
                      ),
                    ),
                    child: SvgPicture.asset(
                      'assets/images/image_placeholder.svg',
                      width: 24.w,
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        8.r,
                      ),
                    ),
                    child: SvgPicture.asset(
                      'assets/images/image_placeholder.svg',
                      width: 24.w,
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        8.r,
                      ),
                    ),
                    child: SvgPicture.asset(
                      'assets/images/image_placeholder.svg',
                      width: 24.w,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
