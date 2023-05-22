import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../ui/constants.dart';
import '../../../theme/app_color.dart';
import '../routes/routes.dart';
import 'signup_form.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen();

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                          // SignupForm(),
                          SizedBox(
                            height: 40.h,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          height: 750.h,
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
                          child: SingleChildScrollView(
                            physics: ScrollPhysics(),
                            child: Column(
                              children: [
                                SignupForm(),
                                SizedBox(
                                  height: 15.h,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      constant.photofile = 'Upload Picture';
                                    });

                                    Navigator.of(context).pushReplacementNamed(
                                      RouteGenerator.login,
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Already have account? ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              color: AppColor.kTextColor1,
                                            ),
                                      ),
                                      Text(
                                        'Sign in',
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
