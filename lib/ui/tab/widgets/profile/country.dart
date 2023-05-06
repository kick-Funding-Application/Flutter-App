import 'package:flutter/material.dart';
import '../../../../theme/app_color.dart';
import 'constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountryInputField extends StatefulWidget {
  const CountryInputField(
      {required this.onChanged, required this.onSaved, this.validateStatus});

  final ValueChanged<String> onChanged;
  final FormFieldValidator<String>? validateStatus;
  final ValueChanged<String> onSaved;
  @override
  _CountryInputFieldState createState() => _CountryInputFieldState();
}

class _CountryInputFieldState extends State<CountryInputField> {
  List<String> _countries = [
    'Egypt',
    'Saudi Arabia',
    'Syria',
    'Iraq',
    'Yemen',
    // Add more countries as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //  padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              onChanged: (value) {
                widget.onChanged(value);
              },
              onSaved: (value) {
                widget.onSaved(value!);
              },
              style: TextStyle(
                color: AppColor.kTextColor1,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColor.kPlaceholder2,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Country',
                hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: AppColor.kTextColor1,
                    ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 8.h,
                ),
              ),
              readOnly: true,
              onTap: _openCountryPicker,
              controller: TextEditingController(text: constant.country),
            ),
          ),
        ],
      ),
    );
  }

  void _openCountryPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select a Country'),
          content: DropdownButton<String>(
            value: constant.country,
            onChanged: (String? value) {
              setState(() {
                constant.country = value!;
              });
              Navigator.of(context).pop();
            },
            items: _countries.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(color: AppColor.kTextColor1),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
