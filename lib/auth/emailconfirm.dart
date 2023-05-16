import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kickfunding/ui/tab/widgets/profile/constants.dart';

import '../../../routes/routes.dart';
import '../../../theme/app_color.dart';
import '../ui/custom_input_field.dart';

class emailConfirm extends StatefulWidget {
  const emailConfirm();

  @override
  State<emailConfirm> createState() => _emailConfirmState();
}

final TextEditingController _otpcontroller = TextEditingController();
bool submitValid = false;

class _emailConfirmState extends State<emailConfirm> {
  late EmailAuth emailAuth;
  void sendOTP() async {
    emailAuth = new EmailAuth(
      sessionName: "Sample session",
    );
    var res =
        await emailAuth.sendOtp(recipientMail: constant.email, otpLength: 5);
    if (res) {
      setState(() {
        submitValid = true;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("OTP Sent")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("OTP Failed to be sent ,Verify your mail")));
    }
  }

  void verifyOtp() {
    var res = emailAuth.validateOtp(
        recipientMail: constant.email, userOtp: _otpcontroller.value.text);
    if (res) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("OTP Verified Successfully")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("InValid OTP!")));
    }
  }

  @override
  void initState() {
    //sendOTP();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kForthColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: 1.sh -
                MediaQuery.of(context).viewPadding.bottom -
                MediaQuery.of(context).viewPadding.top,
            child: Column(
              children: [
                Text(
                  'KickFunding',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Colors.white,
                      ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0.w,
                    ),
                    child: Center(
                      child: Container(
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
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Email Confirmation',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                    color: AppColor.kPrimaryColor,
                                  ),
                            ),
                            // Text(
                            //   'Password?',
                            //   style: Theme.of(context)
                            //       .textTheme
                            //       .headline3!
                            //       .copyWith(
                            //         color: AppColor.kPrimaryColor,
                            //       ),
                            // ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Text(
                              'We Have sent you an email with all instructions to complete your registeration '
                              'Enter the Received Code',
                              style: TextStyle(
                                color: AppColor.kTextColor1,
                              ),
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            CustomInputField(
                              controller: _otpcontroller,
                              hintText: 'Code',
                              textInputAction: TextInputAction.done,
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            // (submitValid)
                            //     ? TextField(
                            //         controller: _otpcontroller,
                            //       )
                            //     : Container(height: 1),
                            // (submitValid)
                            //     ? Container(
                            //         margin: EdgeInsets.only(top: 20),
                            //         height: 50,
                            //         width: 200,
                            //         color: Colors.green[400],
                            //         child: GestureDetector(
                            //           onTap: verifyOtp,
                            //           child: Center(
                            //             child: Text(
                            //               "Verify",
                            //               style: TextStyle(
                            //                 fontWeight: FontWeight.bold,
                            //                 color: Colors.white,
                            //                 fontSize: 20,
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       )
                            //     : SizedBox(height: 1),

                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  AppColor.kPrimaryColor,
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      8.r,
                                    ),
                                  ),
                                ),
                                minimumSize: MaterialStateProperty.all(
                                  Size(
                                    double.infinity,
                                    56.h,
                                  ),
                                ),
                              ),
                              onPressed: () =>
                                  Navigator.of(context).pushReplacementNamed(
                                RouteGenerator.splash,
                              ),
                              //verifyOtp(),
                              child: Text(
                                'Submit',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
