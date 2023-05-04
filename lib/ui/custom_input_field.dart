import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_color.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    this.textInputAction,
    this.onChanged,
    this.controller,
    this.isPassword = false,
    this.hintText,
    this.validateStatus,
    this.sufficon,
  });

  final bool isPassword;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final String? hintText;
  final FormFieldValidator? validateStatus;
  final IconButton? sufficon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      controller: controller,
      textInputAction: textInputAction,
      validator: validateStatus,
      onChanged: onChanged,
      cursorColor: AppColor.kPrimaryColor,
      style: Theme.of(context).textTheme.bodyText2,
      decoration: InputDecoration(
        suffixIcon: sufficon,
        filled: true,
        fillColor: AppColor.kPlaceholder1,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            8.r,
          ),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColor.kTextColor1,
          fontSize: 14.sp,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 8.h,
        ),
      ),
    );
  }
}
