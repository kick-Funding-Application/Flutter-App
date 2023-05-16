import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kickfunding/initials/constants.dart';

import '../../../theme/app_color.dart';
import '../search/search_screen.dart';

class Category extends StatefulWidget {
  const Category({
    Key? key,
    this.onTap,
  }) : super(key: key);
  final void Function()? onTap;
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  int selectedCat = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0.w,
      ),
      child: SizedBox(
        height: 56.h,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
                charityform.categories.length,
                (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          charityform.selectcategory = index;
                          charityform.specificCategory =
                              charityform.categories[index];
                          print(charityform.specificCategory);
                          
                          widget.onTap!();
                        }
                        );
                        
                      },
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 8.h,
                              horizontal: 8.w,
                            ),
                            decoration: BoxDecoration(
                              color: charityform.selectcategory == index
                                  ? AppColor.kPrimaryColor
                                  : AppColor.kPlaceholder2,
                              borderRadius: BorderRadius.circular(
                                8.r,
                              ),
                            ),
                            child: Text(
                              charityform.categories[index],
                              style: TextStyle(
                                color: charityform.selectcategory == index
                                    ? Colors.white
                                    : AppColor.kTextColor1,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                        ],
                      ),
                    )),
          ),
        ),
      ),
    );
  }
}
