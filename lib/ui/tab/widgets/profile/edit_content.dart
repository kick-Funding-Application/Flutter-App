import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kickfunding/auth/login_form.dart';
import 'package:kickfunding/ui/tab/widgets/profile/uploadfirebase.dart';
import '/ui/custom_input_field.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../../routes/routes.dart';
import 'constants.dart';
import '../../../../theme/app_color.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../charity/charity_input_field.dart';
import 'birthdate.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'country.dart';
import 'uploadphoto.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditContent extends StatefulWidget {
  const EditContent({super.key});

  @override
  State<EditContent> createState() => _EditContentState();
}

class _EditContentState extends State<EditContent> {
  File? _profilePicture;

  Future<void> pickercamera() async {
    final XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 20);
    if (file != null) {
      setState(() {
        _profilePicture = File(file.path);
        constant.image = _profilePicture;
        constant.photofile = _profilePicture!.path;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  late TextEditingController firstname;
  late TextEditingController lastname;
  late TextEditingController phone;

  String _selectedCountry = '';
  var obsecurepassword = true;
  var obsecurepassword2 = true;
  Color iconcolor = Colors.grey;
  Color iconcolor2 = Colors.grey;
  var password1;
  var password2;
  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with existing data
    firstname = TextEditingController(text: constant.first_name);
    lastname = TextEditingController(text: constant.last_name);
    phone = TextEditingController(text: constant.phoneuser);
  }

  // @override
  // void dispose() {
  //   firstname.dispose();
  //   lastname.dispose();
  //   phone.dispose();
  //   super.dispose();
  // }

  void _updateSelectedCountry(String value) {
    setState(() {
      _selectedCountry = value;
      constant.country = value;
      constant.countryuser = value;
    });
  }

  void _submitForm() async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        Map<String, dynamic> body = {
          "country": "${constant.countryuser}",
          "birth_date": "${constant.bdateuser}",
          "first_name": "${constant.first_name}",
          "last_name": " ${constant.last_name}",
          "email": "${constant.email}",
          "username": "${constant.Username}",
          "phone_number": "${constant.phoneuser}",
          "user_image": "${constant.urlprofile}",
        };
        String jsonBody = json.encode(body);
        final encoding = Encoding.getByName('utf-8');

        var url = Uri.parse("${constant.server}api/dj-rest-auth/user/");
        var response = await http.put(url,
            headers: {
              'content-Type': 'application/json',
              "Authorization": " Token ${token}"
            },
            body: jsonBody,
            encoding: encoding);
        var result = response.body;
        print(result);

        print('Profile Edited successfully');

        saveprofile();

        /**removecomment when online */
      } else {
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
                  content: Text("Profile NOT updated"),
                ));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  /*Controllers*/

  var birthdate;
  var country;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 16.h,
            ),
            SizedBox(
              width: 120.w,
              height: 120.w,
              child: Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 120.w,
                      width: 120.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          8.r,
                        ),
                        color: AppColor.kForthColor,
                      ),
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              8.r,
                            ),
                            image: DecorationImage(
                                image: NetworkImage(constant.urlprofile),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: -12.w,
                      bottom: -12.w,
                      child: GestureDetector(
                        onTap: () {
                          _pickImage();
                        },
                        child: SvgPicture.asset(
                          'assets/images/edit.svg',
                          width: 32.w,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: CharityInputField(
                    'First Name',
                    onchanged: (String value) {
                      setState(() {
                        constant.first_name = value;
                      });
                    },
                    validateStatus: (value) {},
                    controller: firstname,
                    hintText: 'first name',
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                Expanded(
                  child: CharityInputField(
                    'Last Name',
                    onchanged: (String value) {
                      setState(() {
                        constant.last_name = value;
                      });
                    },
                    validateStatus: (value) {},
                    controller: lastname,
                    hintText: 'last name',
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            // CharityInputField(
            //   'Email',
            //   onchanged: (String value) {},
            //   validateStatus: (value) {},
            //   controller: email,
            // ),
            // SizedBox(height: 16.h),
            CharityInputField(
              'Phone Number',
              onchanged: (String value) {
                setState(() {
                  constant.phoneuser = value;
                });
              },
              validateStatus: (value) {},
              controller: phone,
              hintText: 'phone',
            ),
            SizedBox(height: 26.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Country',
                  style: TextStyle(),
                ),
                SizedBox(
                  height: 2.h,
                ),
                CountryInputField(
                  validateStatus: (value) {},
                  onChanged: _updateSelectedCountry,
                  onSaved: _updateSelectedCountry,
                  color: AppColor.kPlaceholder2,
                  height: 20,
                ),
              ],
            ),

            SizedBox(height: 26.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Birthdate',
                  style: TextStyle(),
                ),
                SizedBox(
                  height: 2.h,
                ),
                BirthdateInputField(
                  validateStatus: (value) {},
                  onChanged: (String value) {
                    setState(() {
                      birthdate = value;
                      constant.bdateuser = value;
                    });
                  },
                  title: 'birth',
                  hintText: '${constant.bdateuser}',
                  onSaved: (String value) {
                    setState(() {
                      birthdate = value;
                      constant.bdateuser = value;
                    });
                  },
                  height: 20,
                  color: AppColor.kPlaceholder2,
                ),
              ],
            ),
            SizedBox(height: 26.h),
            Column(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      AppColor.kPlaceholder2,
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
                        55.h,
                      ),
                    ),
                  ),
                  onPressed: () {
                    updatePassword(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Update Password',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: AppColor.kTextColor1,
                            fontSize: 13),
                      ),
                      Icon(
                        Icons.lock,
                        color: AppColor.kTextColor1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),

            SizedBox(height: 26.h),
            Container(
              height: 50,
              child: ElevatedButton(
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
                onPressed: () {
                  _submitForm();
                  //   saveprofile();
                },
                child: Text(
                  'Save Change',
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
          ],
        ),
      ),
    );
  }

  void saveprofile() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.r),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewPadding.bottom,
          top: 32.h,
          left: 16.w,
          right: 16.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/images/check.svg',
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              'Profile Updated Successfully',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              'Go Back to Home Page',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 64.h,
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
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteGenerator.main, (route) => false);
              },
              child: Text(
                'Home',
              ),
            )
          ],
        ),
      ),
    );
  }

  File? _image;
  String? _imageUrl;

  void compressWithImageCompress(
      {required String path, required double quality}) async {
    final response = await FlutterImageCompress.compressWithFile(
      path,
      minWidth: 320,
      minHeight: 240,
      quality: quality.truncate(),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 25);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
      _uploadImage();
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().microsecondsSinceEpoch}.jpg');

      firebase_storage.UploadTask uploadTask = ref.putFile(_image!);
      firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      setState(() {
        _imageUrl = imageUrl;
        constant.urlprofile = _imageUrl!;
        print(_imageUrl);
      });
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Text("Uploaded Image"),
        ),
      );

      print('Image uploaded successfully. URL: $_imageUrl');
    } catch (e) {
      print('Failed to upload image: $e');
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Text("Failed to Upload Image"),
        ),
      );
    }
  }

  void savepassword() async {
    try {
      Map<String, dynamic> body = {
        "new_password1": password1,
        "new_password2": password2,
      };
      String jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');

      var url =
          Uri.parse("${constant.server}api/dj-rest-auth/password/change/");
      var response = await http.post(url,
          headers: {
            'content-Type': 'application/json',
            "Authorization": " Token ${token}",
          },
          body: jsonBody,
          encoding: encoding);
      var result = response.body;
      print(result);
    } catch (e) {
      print(e.toString());
    }
  }

  void updatePassword(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.r),
      ),
      builder: (BuildContext context) => SingleChildScrollView(
        child: Container(
          height: 500,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 32.h,
              left: 16.w,
              right: 16.w,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  'Update Password',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColor.kPrimaryColor,
                      ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                CustomInputField(
                  hintText: 'New Password',
                  backgroundcolor: AppColor.kPlaceholder1,
                  isPassword: obsecurepassword,
                  textInputAction: TextInputAction.next,
                  sufficon: IconButton(
                    icon: Icon(
                      obsecurepassword
                          ? Icons.visibility
                          : Icons.visibility_off,
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
                    return null;
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomInputField(
                  hintText: 'Repeat the Password',
                  backgroundcolor: AppColor.kPlaceholder1,
                  isPassword: obsecurepassword2,
                  textInputAction: TextInputAction.done,
                  sufficon: IconButton(
                    icon: Icon(
                      obsecurepassword2
                          ? Icons.visibility
                          : Icons.visibility_off,
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
                    return null;
                  },
                ),
                SizedBox(
                  height: 50.h,
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
                  onPressed: () {
                    if (password1 == password2) {
                      savepassword();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Updated the password Successfully')));
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text('ERROR : The Two passwords don\'t Match')));
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Save Changes',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
