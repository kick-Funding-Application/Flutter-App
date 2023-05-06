import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_color.dart';
import '../routes/routes.dart';
import 'custom_input_field.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignupForm extends StatefulWidget {
  const SignupForm({
    super.key,
  });

  @override
  State<SignupForm> createState() => _SignupFormState();
}

GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();

/* Variables*/

var token = "";
var email = "";
var password = "";
var first_name = "";
var username = "";
var id = "";
var phone = "";
var last_name = "";
var age = "";
var gender = "";
var obsecurepassword = true;
Color iconcolor = Colors.grey;
/* Variables */
Future SignUp(BuildContext cont) async {
  /**removecomment when online */
  Map<String, dynamic> body = {
    "id": id,
    "email": email,
    "password": password,
    "first_name": first_name,
    "last_name": last_name,
    "username": username,
    "phone_number": phone,
    "age": age,
  };
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');
  if (email == "" ||
      password == "" ||
      first_name == "" ||
      username == "" ||
      phone == "" ||
      last_name == "" ||
      age == "") {
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

class _SignupFormState extends State<SignupForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey1,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create New',
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: AppColor.kForthColor,
                  ),
            ),
            Text(
              'Account',
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: AppColor.kForthColor,
                  ),
            ),
            SizedBox(
              height: 40.h,
            ),
            CustomInputField(
              hintText: 'Email',
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
              validateStatus: (value) {
                if (value!.isEmpty) {
                  return 'Field must not be empty';
                }
                return null;
              },
            ),
            SizedBox(
              height: 8.h,
            ),
            CustomInputField(
              hintText: 'First Name',
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                setState(() {
                  first_name = value;
                });
              },
              validateStatus: (value) {
                if (value!.isEmpty) {
                  return 'Field must not be empty';
                }
                return null;
              },
            ),
            SizedBox(
              height: 8.h,
            ),
            CustomInputField(
              hintText: 'Last Name',
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                setState(() {
                  last_name = value;
                });
              },
              validateStatus: (value) {
                if (value!.isEmpty) {
                  return 'Field must not be empty';
                }
                return null;
              },
            ),
            SizedBox(
              height: 8.h,
            ),
            CustomInputField(
              hintText: 'Username',
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                setState(() {
                  username = value;
                });
              },
              validateStatus: (value) {
                if (value!.isEmpty) {
                  return 'Field must not be empty';
                }
                return null;
              },
            ),
            SizedBox(
              height: 8.h,
            ),
            CustomInputField(
              hintText: 'Password',
              isPassword: obsecurepassword,
              textInputAction: TextInputAction.done,
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
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              validateStatus: (value) {
                if (value!.isEmpty) {
                  return 'Field must not be empty';
                }
                return null;
              },
            ),
            SizedBox(
              height: 40.h,
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
                if (_formKey1.currentState!.validate()) {
                  print('successful');
                  Navigator.of(context).pushReplacementNamed(
                    RouteGenerator.login,
                  );
                  //   SignUp(context);
                }
                ;
              },
              child: Text(
                'Create Account',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
