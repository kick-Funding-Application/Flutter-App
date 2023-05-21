import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../routes/routes.dart';
import '../../../theme/app_color.dart';
import '../ui/custom_input_field.dart';
import '../ui/signup_form.dart';
import '/ui/tab/widgets/profile/constants.dart';

class ForgetPwScreen extends StatefulWidget {
  const ForgetPwScreen();

  @override
  State<ForgetPwScreen> createState() => _ForgetPwScreenState();
}

var email;

class _ForgetPwScreenState extends State<ForgetPwScreen> {
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
                              'Forget',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                    color: AppColor.kPrimaryColor,
                                  ),
                            ),
                            Text(
                              'Password?',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                    color: AppColor.kPrimaryColor,
                                  ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Text(
                              'Enter your email associated with your account and we\'ll '
                              'send an email with instruction to reset your password.',
                              style: TextStyle(
                                color: AppColor.kTextColor1,
                              ),
                            ),
                            SizedBox(
                              height: 64.h,
                            ),
                            CustomInputField(
                              hintText: 'email address',
                              textInputAction: TextInputAction.done,
                              onChanged: (String value) {
                                setState(() {
                                  email = value;
                                  print(email);
                                });
                              },
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
                            SizedBox(
                              height: 8.h,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacementNamed(
                                    RouteGenerator.login,
                                  );
                                },
                                child: Text('Back'))
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
    print(email);
    try {
      Map<String, dynamic> body = {
        "email": email,
      };
      String jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');

      var url = Uri.parse("${constant.server}api/dj-rest-auth/password/reset/");
      var response = await http.post(url,
          headers: {
            'content-Type': 'application/json',
          },
          body: jsonBody,
          encoding: encoding);
      var result = response.body;
      print(response.statusCode);
      if (response.statusCode == 400) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Reset Failed')));
        Navigator.of(context).pushReplacementNamed(
          RouteGenerator.login,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'Follow the instructions sent in your mail to reset your password')));
        Navigator.of(context).pushReplacementNamed(
          RouteGenerator.login,
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
