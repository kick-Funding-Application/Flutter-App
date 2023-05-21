import 'package:flutter/material.dart';
import '../../../../theme/app_color.dart';
import 'constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:country_picker/country_picker.dart';

class countrycodepicker extends StatefulWidget {
  const countrycodepicker(
      {required this.onChanged,
      required this.onSaved,
      this.validateStatus,
      required this.height,
      required this.color});

  final ValueChanged<String> onChanged;
  final FormFieldValidator<String>? validateStatus;
  final ValueChanged<String> onSaved;
  final int height;
  final Color color;
  @override
  _countrycodepickerState createState() => _countrycodepickerState();
}

class _countrycodepickerState extends State<countrycodepicker> {
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
                fillColor: widget.color,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide.none,
                ),
                hintText: '',
                hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: AppColor.kTextColor1,
                      fontSize: 10,
                    ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                  vertical: widget.height.h,
                ),
              ),
              readOnly: true,
              onTap: () {
                showCountryPicker(
                  context: context,
                  showPhoneCode:
                      true, // optional. Shows phone code before the country name.
                  onSelect: (Country country) {
                    setState(() {
                      constant.country = country.phoneCode;
                    });
                  },
                );
              },
              controller: TextEditingController(text: constant.country),
            ),
          ),
        ],
      ),
    );
  }
}
