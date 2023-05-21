import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../models/urgent.dart';
import '../../../../routes/routes.dart';
import '../../../../theme/app_color.dart';

class UrgentCard extends StatefulWidget {
  const UrgentCard(
    this.urgent,
  );

  final Urgent urgent;

  @override
  State<UrgentCard> createState() => _UrgentCardState();
}

class _UrgentCardState extends State<UrgentCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(RouteGenerator.details, arguments: widget.urgent);
      },
      child: Container(
        height: 310.h,
        width: 240.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            12.r,
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              color: AppColor.kPlaceholder1,
              blurRadius: 5,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 8.w,
          vertical: 8.h,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 180.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      8.r,
                    ),
                    color: AppColor.kPlaceholder1,
                  ),
                  child: Center(
                    child: Container(
                      // width: 180.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          8.r,
                        ),
                        image: DecorationImage(
                            image: NetworkImage(widget.urgent.assetName),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
                // Positioned(
                //   bottom: 8.h,
                //   right: 8.w,
                //   child: SvgPicture.asset(
                //     'assets/images/bookmark.svg',
                //   ),
                // )
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              widget.urgent.title,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Spacer(),
            Row(
              children: [
                Container(
                  width: (240.w - 20.w) *
                      double.parse(widget.urgent.percent) /
                      100,
                  height: 4.h,
                  decoration: ShapeDecoration(
                    shape: const StadiumBorder(),
                    color: AppColor.kBlue,
                  ),
                ),
                Spacer(),
                Container(
                  width: (240.w - 20.w) *
                      (100 - double.parse(widget.urgent.percent)) /
                      100,
                  height: 4.h,
                  decoration: ShapeDecoration(
                    shape: const StadiumBorder(),
                    color: AppColor.kPlaceholder1,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              children: [
                Text(
                  'Target:',
                  style: TextStyle(
                    color: AppColor.kTextColor1,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '\$${widget.urgent.target} ',
                      style: TextStyle(
                        color: AppColor.kTitle,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '(${widget.urgent.percent}%)',
                      style: TextStyle(
                        color: AppColor.kTextColor1,
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
