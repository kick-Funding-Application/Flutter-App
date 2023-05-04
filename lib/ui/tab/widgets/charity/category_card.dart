import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kickfunding/initials/constants.dart';

import '../../../../models/charity.dart';
import '../../../../theme/app_color.dart';

class CatrgoryCard extends StatefulWidget {
  const CatrgoryCard(this.charity);

  final Charity charity;

  @override
  State<CatrgoryCard> createState() => _CatrgoryCardState();
}

class _CatrgoryCardState extends State<CatrgoryCard> {
  Color selectedcolor = AppColor.kPlaceholder1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          child: Container(
            width: 96.w,
            height: 96.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selectedcolor,
            ),
            child: Center(
              child: SizedBox(
                width: 48.w,
                height: 48.w,
                child: Image.asset(
                  widget.charity.assetName,
                ),
              ),
            ),
          ),
          onTap: () {
            setState(() {
              
              charityform.category = widget.charity.name;
            });
            print(charityform.category);
          },
        ),
        Text(
          widget.charity.name,
          style: TextStyle(
            color: AppColor.kTextColor1,
          ),
        ),
      ],
    );
  }
}
