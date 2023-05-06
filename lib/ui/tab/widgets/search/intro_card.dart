import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../theme/app_color.dart';

class IntroCard extends StatefulWidget {
  IntroCard( {required this.title, required this.Owner, required this.category, required this.Date});
  final String title;
  final String category;
  final String Owner;
  final DateTime Date;

  @override
  State<IntroCard> createState() => _IntroCardState();
}

class _IntroCardState extends State<IntroCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 340.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            12.r,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 210.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      12.r,
                    ),
                    color: AppColor.kPlaceholder1,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/image_placeholder.svg',
                      width: 80.w,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8.h,
                  right: 8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.kTextColor2,
                      borderRadius: BorderRadius.circular(
                        8.r,
                      ),
                    ),
                    child: Text(
                      '${widget.category}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    '${widget.title}',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.kPlaceholder1,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/images/image_placeholder.svg',
                            width: 24.w,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.Owner}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${widget.Date}',
                            style: TextStyle(
                              color: AppColor.kTextColor1,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 13.h,
            ),
          ],
        ),
      ),
    );
  }
}
