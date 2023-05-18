import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kickfunding/ui/tab/widgets/profile/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../routes/routes.dart';
import '../../../theme/app_color.dart';
import '../ui/custom_input_field.dart';
import '../ui/signup_form.dart';

class emailConfirm extends StatefulWidget {
  const emailConfirm();

  @override
  State<emailConfirm> createState() => _emailConfirmState();
}

final TextEditingController _otpcontroller = TextEditingController();
bool submitValid = false;

class _emailConfirmState extends State<emailConfirm> {
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
                              onPressed: () => Confirm(context),
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

  Future Confirm(BuildContext context) async {
    try {
      Map<String, dynamic> body = {
        "country": selectedCountry,
      };
      String jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');

      var url = Uri.parse(
          "https://6bcc-156-210-179-53.ngrok-free.app/api/dj-rest-auth/registration/");
      var response = await http.post(url,
          headers: {
            'content-Type': 'application/json',
            "Authorization": " Token ${token}"
          },
          body: jsonBody,
          encoding: encoding);
      var result = response.body;
      print(result);

      print('Registration successful');
      print(response.statusCode);

      print("Registeration Successful");
      Navigator.of(context).pushReplacementNamed(
        RouteGenerator.login,
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
