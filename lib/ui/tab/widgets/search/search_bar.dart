import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../theme/app_color.dart';

class searchBarWidget extends StatefulWidget {
  const searchBarWidget({
    this.textInputAction,
    this.onSubmitted,
    this.onTap,
    this.controller,
    this.hintText,
  });

  final TextInputAction? textInputAction;
  final Function(String)? onSubmitted;
  final Function()? onTap;
  final TextEditingController? controller;
  final String? hintText;

  @override
  State<searchBarWidget> createState() => _searchBarWidgetState();
}

class _searchBarWidgetState extends State<searchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          controller: widget.controller,
          textInputAction: widget.textInputAction,
          onSubmitted: widget.onSubmitted,
          cursorColor: AppColor.kPrimaryColor,
          style: Theme.of(context).textTheme.bodyText2,
          decoration: InputDecoration(
              filled: true,
              fillColor: AppColor.kPlaceholder2,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  8.r,
                ),
                borderSide: BorderSide.none,
              ),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: AppColor.kTextColor1,
                fontSize: 14.sp,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 16.h,
              )),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          right: 8.w,
          child: Center(
            child: GestureDetector(
              onTap: widget.onTap,
              child: Container(
                width: 40.h,
                height: 40.h,
                decoration: BoxDecoration(
                  color: AppColor.kPlaceholder2,
                  borderRadius: BorderRadius.circular(
                    8.r,
                  ),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/search.svg',
                    width: 20.w,
                    color: AppColor.kTextColor1,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
