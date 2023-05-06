import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../theme/app_color.dart';
import '../routes/routes.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../ui/custom_input_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

Future Login(BuildContext cont) async {
  /**removecomment when online */
  Map<String, dynamic> body = {
    "email": email,
    "password": password,
  };
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');
  if (email == "" || password == "") {
    print('Fields have not to be empty');
  } else {
    var url =
        Uri.parse("https://1a62-102-186-239-195.eu.ngrok.io/caregiver/signup");
    var response = await http.post(url,
        headers: {'content-Type': 'application/json'},
        body: jsonBody,
        encoding: encoding);
    var result = response.body;
    print(result);

    print('Registration successful');
    print(result);

    var data = json.decode(response.body);
    if (data["message"] == "Success") {
      token = data["access_token"];
      print("Registeration succeeded");
      Navigator.of(cont).pushReplacementNamed(
        RouteGenerator.main,
      );
    } else {
      print("Registeration Failed");
    }
  }
  /**removecomment when online */
}

var token = "";
var email = "";
var password = "";
var obsecurepassword = true;
Color iconcolor = Colors.grey;

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey2,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sign in',
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: AppColor.kForthColor,
                  ),
            ),
            Text(
              'to continue',
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: AppColor.kForthColor,
                  ),
            ),
            SizedBox(
              height: 40.h,
            ),
            CustomInputField(
              hintText: 'Email',
              onChanged: (value) {
                email = value;
              },
              validateStatus: (value) {
                if (value!.isEmpty) {
                  return 'Field must not be empty';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
            ),
            SizedBox(
              height: 8.h,
            ),
            CustomInputField(
              hintText: 'Password',
              isPassword: obsecurepassword,
              textInputAction: TextInputAction.done,
              onChanged: (value) {
                password = value;
              },
              sufficon: IconButton(
                icon: Icon(
                  obsecurepassword ? Icons.visibility : Icons.visibility_off,
                  color: iconcolor,
                ),
                onPressed: () {
                  setState(() {
                    if (iconcolor == Colors.grey) {
                      iconcolor = AppColor.kPrimaryColor;
                    } else {
                      iconcolor = Colors.grey;
                    }
                    obsecurepassword = !obsecurepassword;
                  });
                },
              ),
              validateStatus: (value) {
                if (value!.isEmpty) {
                  return 'Field must not be empty';
                }
                return null;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pushReplacementNamed(
                    RouteGenerator.forgetPw,
                  ),
                  child: Text(
                    'Forgot password?',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: AppColor.kAccentColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 120.h,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  AppColor.kAccentColor,
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
              onPressed: () {
                if (_formKey2.currentState!.validate()) {
                  print('successful');
                  Navigator.of(context).pushReplacementNamed(
                    RouteGenerator.main,
                  );
                  //   Login(context);
                }
                ;
              },
              child: Text(
                'Login',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
