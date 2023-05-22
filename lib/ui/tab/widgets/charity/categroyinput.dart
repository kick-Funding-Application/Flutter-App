import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants.dart';
import '../../../../theme/app_color.dart';
import '/../initials/constants.dart';

class categoryinputfield extends StatefulWidget {
  const categoryinputfield(
    this.title, {
    this.assetName,
    this.onTap,
    this.hintText,
    required this.onchanged,
    this.controller,
    required this.validateStatus,
    this.keyboardtype,
  });

  final String title;
  final String? assetName;
  final TextInputType? keyboardtype;
  final void Function()? onTap;
  final String? hintText;
  final ValueChanged<String> onchanged;
  final controller;
  final FormFieldValidator validateStatus;

  @override
  State<categoryinputfield> createState() => _categoryinputfieldState();
}

class _categoryinputfieldState extends State<categoryinputfield> {
  String dropdownValue = charityform.category;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(),
        ),
        SizedBox(
          height: 2.h,
        ),
        Stack(
          children: [
            DropdownButtonFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                  //<-- SEE HERE
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      BorderSide(color: AppColor.kAccentColor, width: 1),
                  //<-- SEE HERE
                ),
                hintText: widget.hintText,
                filled: true,
                fillColor: AppColor.kPlaceholder2,
              ),
              dropdownColor: AppColor.kPlaceholder2,
              value: dropdownValue,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                  constant.category = newValue;
                  charityform.category = newValue;
                });
              },
              items: <String>['Education', 'Environment', 'Health', 'Animals']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                  ),
                );
              }).toList(),
            ),
            if (widget.assetName != null)
              Positioned(
                top: 0,
                bottom: 0,
                right: 8.w,
                child: Center(
                  child: GestureDetector(
                    onTap: widget.onTap,
                    child: Container(
                      width: 32.w,
                      height: 32.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          8.r,
                        ),
                        color: AppColor.kPrimaryColor,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          widget.assetName!,
                          width: 16.w,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        )
      ],
    );
  }
}
