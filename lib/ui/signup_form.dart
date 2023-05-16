//import 'dart:io';
//import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:math';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../theme/app_color.dart';
import '../routes/routes.dart';
import 'custom_input_field.dart';
import 'dart:convert';
//import 'package:country_picker/country_picker.dart';
import 'package:http/http.dart' as http;
import 'tab/widgets/profile/constants.dart';
import 'tab/widgets/profile/birthdate.dart';
import 'tab/widgets/profile/country.dart';
import 'tab/widgets/profile/phone.dart';
import 'tab/widgets/profile/uploadphoto.dart';

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
var password1 = "";
var password2 = "";
var first_name = "";
var username = "";
//var id = "";

var phoneno = constant.phone;
var last_name = "";
//var age = "";
//var gender = "";
//dynamic photo = constant.image;
String selectedCountry = constant.country;
String birthdate = constant.birthdate.toString();
var obsecurepassword = true;
var obsecurepassword2 = true;
Color iconcolor = Colors.grey;
Color iconcolor2 = Colors.grey;
/* Variables */
Future SignUp(BuildContext cont) async {
  /**removecomment when online */
  Map<String, dynamic> body = {
    "country": selectedCountry,
    "birth_date": constant.bdateuser,
    "email": email,
    "password1": password1,
    "password2": password2,
    "first_name": first_name,
    "last_name": last_name,
    "username": username,
    "phone_number": phoneno,
  };
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  var url = Uri.parse(
      "https://d46b-197-54-154-137.ngrok-free.app/api/dj-rest-auth/registration/");
  var response = await http.post(url,
      headers: {'content-Type': 'application/json'},
      body: jsonBody,
      encoding: encoding);
  var result = response.body;
  print(result);

  print('Registration successful');

  if (response.statusCode == 200) {
    print("Registeration succeeded");
    Navigator.of(cont).pushReplacementNamed(
      RouteGenerator.splash,
    );
  } else {
    print("Registeration Failed");
  }

  /**removecomment when online */
}

bool isPasswordValid(String password) {
  if (password.length < 8) {
    return false;
  }
  if (!password.contains(RegExp(r'[A-Za-z]'))) {
    return false;
  }
  if (!password.contains(RegExp(r'[0-9]'))) {
    return false;
  }
  return true;
}

bool isEmailValid(String email) {
  // Add your email validation logic here
  // This is a simple example that checks for the presence of '@' and '.'
  return email.contains('@') && email.contains('.');
}

// List<String> existingUsernames = ['john', 'mary', 'jane'];

// bool isUsernameUnique(String username) {
//   // Check if the username already exists in the list
//   return !existingUsernames.contains(username);
// }

void _submitForm() {
  if (_formKey1.currentState!.validate()) {
    _formKey1.currentState!.save();

    print('Selected Country: ${constant.country}');
  }
}

class _SignupFormState extends State<SignupForm> {
  @override
  void initState() {
    super.initState();

    // Reset or reinitialize your constants here
    constant.photofile = 'Upload Picture';
    constant.country = 'Egypt';
  }

  late String countryValue;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey1,
      child: Container(
        child: SingleChildScrollView(
          //   physics: AlwaysScrollableScrollPhysics(),
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
                height: 30.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomInputField(
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
                      backgroundcolor: AppColor.kPlaceholder1,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: CustomInputField(
                      hintText: 'Last Name',
                      backgroundcolor: AppColor.kPlaceholder1,
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
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomInputField(
                hintText: 'Email',
                backgroundcolor: AppColor.kPlaceholder1,
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
                  if (!isEmailValid(value)) {
                    return 'Invalid email format';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 17.h,
              ),
              CustomInputField(
                hintText: 'Username',
                backgroundcolor: AppColor.kPlaceholder1,
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
                height: 20.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   'Country',
                  //   style: TextStyle(),
                  // ),
                  // SizedBox(
                  //   height: 2.h,
                  // ),
                  CountryInputField(
                    validateStatus: (value) {
                      if (value!.isEmpty) {
                        return 'Field must not be empty';
                      }
                      return null;
                    },
                    onChanged: _updateSelectedCountry,
                    onSaved: _updateSelectedCountry,
                    color: AppColor.kPlaceholder1,
                    height: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              IntlPhoneField(),
              SizedBox(
                height: 20.h,
              ),
              BirthdateInputField(
                validateStatus: (value) {
                  if (value!.isEmpty) {
                    return 'Field must not be empty';
                  }
                  return null;
                },
                onChanged: (value) {},
                title: 'birth',
                onSaved: (String value) {
                  setState(() {
                    constant.bdateuser = value;
                  });
                },
                color: AppColor.kPlaceholder1,
                height: 10,
                hintText: 'Birthdate',
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomInputField(
                hintText: 'Password',
                backgroundcolor: AppColor.kPlaceholder1,
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
                    password1 = value;
                  });
                },
                validateStatus: (value) {
                  if (value!.isEmpty) {
                    return 'Field must not be empty';
                  }
                  if (!isPasswordValid(value)) {
                    return 'Password must have at least 8 characters, numbers, and letters';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomInputField(
                hintText: 'Repeat the Password',
                backgroundcolor: AppColor.kPlaceholder1,
                isPassword: obsecurepassword2,
                textInputAction: TextInputAction.done,
                sufficon: IconButton(
                  icon: Icon(
                    obsecurepassword2 ? Icons.visibility : Icons.visibility_off,
                    color: iconcolor2,
                  ),
                  onPressed: () {
                    setState(() {
                      if (iconcolor2 == Colors.grey) {
                        iconcolor2 = AppColor.kPrimaryColor;
                      } else {
                        iconcolor2 = Colors.grey;
                      }
                      obsecurepassword2 = !obsecurepassword2;
                    });
                  },
                ),
                onChanged: (value) {
                  setState(() {
                    password2 = value;
                  });
                },
                validateStatus: (value) {
                  if (value!.isEmpty) {
                    return 'Field must not be empty';
                  }
                  if (password1 != password2) {
                    return 'Two Passwords don\'t match';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              uploadpicture(
                buttoncolor: AppColor.kPlaceholder1,
                height: 50,
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
                    print(
                        '${email},${password1},${selectedCountry},${phoneno},${birthdate},${first_name},${last_name},${username},${password2}');
                    print(constant.image);
                    confirmEmail(context);
                    // SignUp(context);
                  }
                },
                child: Text(
                  'Create Account',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void confirmEmail(context) {
    Navigator.of(context).pushReplacementNamed(
      RouteGenerator.emailconfirm,
    );
  }

  void _updateSelectedCountry(String value) {
    setState(() {
      selectedCountry = value;
    });
  }
}
