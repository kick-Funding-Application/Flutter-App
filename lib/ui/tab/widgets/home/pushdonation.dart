import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kickfunding/ui/tab/widgets/profile/constants.dart';

import '../../../../theme/app_color.dart';

class pushdonation extends StatefulWidget {
  const pushdonation(this.callback);
  final void Function(String) callback;
  @override
  State<pushdonation> createState() => _pushdonationState();
}

int selectedIndex = -1;

class _pushdonationState extends State<pushdonation> {
  String constructMoney() {
    String answer = '';

    setState(() {
      answer = '${constant.donation}';
    });

    return answer;
  }

  void buttonHandler(int index) {}
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 32.w,
        vertical: 24.h,
      ),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(32.r)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How Much of donation?',
                style: TextStyle(
                  fontSize: 25.sp,
                  color: AppColor.kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0.w),
            child: Divider(
              thickness: 2.sp,
              color: AppColor.kPlaceholder2,
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w),
            child: Row(
              children: [
                Expanded(
                  child: _buildButton(1),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(child: _buildButton(5)),
                SizedBox(
                  width: 8,
                ),
                Expanded(child: _buildButton(10))
              ],
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w),
            child: Row(
              children: [
                Expanded(child: _buildButton(20)),
                SizedBox(
                  width: 8,
                ),
                Expanded(child: _buildButton(50)),
                SizedBox(
                  width: 8,
                ),
                Expanded(child: _buildButton(100))
              ],
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w),
            child: Row(
              children: [
                Expanded(child: _buildButton(200)),
                SizedBox(
                  width: 8,
                ),
                Expanded(child: _buildButton(500)),
                SizedBox(
                  width: 8,
                ),
                Expanded(child: _buildButton(1000))
              ],
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 24.0.w),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: _buildThreeZero(context),
          //       ),
          //       SizedBox(
          //         width: 8,
          //       ),
          //       Expanded(
          //         child: _buildButton(0),
          //       ),
          //       SizedBox(
          //         width: 8,
          //       ),
          //       Expanded(
          //         child: _buildBackspace(),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildButton(int index) {
    return GestureDetector(
      onTap: () => {
        setState(() {
          selectedIndex = index; // Update the selected index
          constant.donation = index;
        }),
      },
      child: Container(
        height: 48.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selectedIndex == index
              ? AppColor.kPrimaryColor
              : AppColor.kPlaceholder2,
          borderRadius: BorderRadius.circular(16.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '\$',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: selectedIndex == index
                        ? Colors.white
                        : AppColor.kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
            ),
            Text(
              '$index ',
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: selectedIndex == index
                        ? Colors.white
                        : AppColor.kPrimaryColor,
                    fontSize: 17,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
