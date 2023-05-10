import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'constants.dart';
import '../../../../theme/app_color.dart';
import '../charity/charity_input_field.dart';
import 'birthdate.dart';

import 'country.dart';
import 'uploadphoto.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


class EditContent extends StatefulWidget {
  const EditContent({super.key});

  @override
  State<EditContent> createState() => _EditContentState();
}
File? _profilePicture;

class _EditContentState extends State<EditContent> {
    Future pickercamera() async {
    final file = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _profilePicture = File(file!.path);
    });
  }
  final _formKey = GlobalKey<FormState>();
  String _selectedCountry = '';

  void _updateSelectedCountry(String value) {
    setState(() {
      _selectedCountry = value;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      print('Selected Country: ${constant.country}');
    }
  }

  /*Controllers*/
  var firstname = TextEditingController();
  var lastname = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  var birthdate;
  var country;
  var phoneno;
  var fname;
  var lname;
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
                        child: SvgPicture.asset(
                          'assets/images/image_placeholder.svg',
                          width: 32.w,
                        ),
                      ),
                    ),
                    Positioned(
                      right: -12.w,
                      bottom: -12.w,
                      child: GestureDetector(
                        onTap: () {
                          pickercamera();
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
                    onchanged: (String value) {},
                    validateStatus: (value) {},
                    controller: firstname,
                    hintText: '${fname}',
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                Expanded(
                  child: CharityInputField(
                    'Last Name',
                    onchanged: (String value) {},
                    validateStatus: (value) {},
                    controller: lastname,
                    hintText: '${lname}',
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
              onchanged: (String value) {},
              validateStatus: (value) {},
              controller: phone,
              hintText: '${phoneno}',
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
                    });
                  },
                  title: 'birth',
                  hintText: '${birthdate}',
                  onSaved: (String value) {
                    setState(() {
                      birthdate = value;
                    });
                  },
                  height: 20,
                  color: AppColor.kPlaceholder2,
                ),
              ],
            ),
            SizedBox(height: 26.h),
            uploadpicture(
              buttoncolor: AppColor.kPlaceholder2, height: 60,
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
                  onPressed:
                  _submitForm;
                  print(birthdate);
                  print(constant.country);
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
}
