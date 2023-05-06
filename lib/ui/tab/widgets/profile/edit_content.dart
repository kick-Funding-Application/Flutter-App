import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'constants.dart';
import '../../../../theme/app_color.dart';
import '../charity/charity_input_field.dart';
import 'birthdate.dart';
import 'country.dart';

class EditContent extends StatefulWidget {
  const EditContent({super.key});

  @override
  State<EditContent> createState() => _EditContentState();
}

class _EditContentState extends State<EditContent> {
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
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: 16.h,
          ),
          SizedBox(
            width: 120.w,
            height: 120.w,
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
                    onTap: () {},
                    child: SvgPicture.asset(
                      'assets/images/edit.svg',
                      width: 32.w,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Spacer(),
          Row(
            children: [
              Expanded(
                child: CharityInputField(
                  'First Name',
                  onchanged: (String value) {},
                  validateStatus: (value) {},
                  controller: firstname,
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
                ),
              ),
            ],
          ),
          Spacer(),
          CharityInputField(
            'Email',
            onchanged: (String value) {},
            validateStatus: (value) {},
            controller: email,
          ),
          Spacer(),
          CharityInputField(
            'Phone Number',
            onchanged: (String value) {},
            validateStatus: (value) {},
            controller: phone,
          ),
          Spacer(),
          CountryInputField(
            validateStatus: (value) {},
            onChanged: _updateSelectedCountry,
            onSaved: _updateSelectedCountry,
          ),
          Spacer(),
          BirthdateInputField(
            validateStatus: (value) {},
            onChanged: (String value) {
              setState(() {
                birthdate = value;
              });
            },
            title: 'birth',
            onSaved: (String value) {
              setState(() {
                birthdate = value;
              });
            },
          ),
          Spacer(),
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
              onPressed:
              _submitForm;
              print(birthdate);
              print(constant.country);
            },
            child: Text(
              'Save Change',
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
        ],
      ),
    );
  }
}
