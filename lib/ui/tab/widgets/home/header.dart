import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../routes/routes.dart';
import '../../../../theme/app_color.dart';
import '../profile/constants.dart';

class Header extends StatefulWidget {
  const Header();

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0.w,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello!',
                ),
                Text(
                  '${constant.Username}',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: AppColor.kTitle,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 45.w,
                height: 45.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    8.r,
                  ),
                  //color: AppColor.kPlaceholder2,
                ),
                child: GestureDetector(
                  onTap: () {
                    print('object');
                    saveprofile();
                  },
                  child: Center(
                    child: Image.asset(
                      'assets/images/logoicon.png',
                    ),
                  ),
                ),
              ),

              // Positioned(
              //   right: -2.w,
              //   top: -2.w,
              //   child: Container(
              //     width: 8.w,
              //     height: 8.w,
              //     decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //       color: Colors.red,
              //     ),
              //   ),
              // )
            ],
          ),
        ],
      ),
    );
  }

  void saveprofile() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.r),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewPadding.bottom,
          top: 32.h,
          left: 16.w,
          right: 16.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Image.asset(
                'assets/images/logoicon.png',
                width: 100,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              'KickFunding',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColor.kAccentColor,
                  ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              'Verison 2.0.1',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: AppColor.kTextColor1, fontSize: 15),
            ),
            SizedBox(
              height: 64.h,
            ),
            // ElevatedButton(
            //   style: ButtonStyle(
            //     backgroundColor: MaterialStateProperty.all(
            //       AppColor.kPrimaryColor,
            //     ),
            //     shape: MaterialStateProperty.all(
            //       RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(
            //           8.r,
            //         ),
            //       ),
            //     ),
            //     minimumSize: MaterialStateProperty.all(
            //       Size(
            //         double.infinity,
            //         56.h,
            //       ),
            //     ),
            //   ),
            //   onPressed: () {
            //     Navigator.pushNamedAndRemoveUntil(
            //         context, RouteGenerator.main, (route) => false);
            //   },
            //   child: Text(
            //     'Home',
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
