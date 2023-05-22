import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kickfunding/ui/constants.dart';

import '../../../../theme/app_color.dart';

class pushdonation extends StatefulWidget {
  const pushdonation(this.callback);
  final void Function(String) callback;
  @override
  State<pushdonation> createState() => _pushdonationState();
}

int selectedIndex = -1;

class _pushdonationState extends State<pushdonation> {
  List<String> moneyChar = ['', '', '', '', '', ''];

  String constructMoney() {
    if (moneyChar.isEmpty) {
      return '';
    }

    String answer = '';
    int totalChar = moneyChar.length;

    for (int i = 0; i < totalChar; i++) {
      answer += moneyChar[i];
    }
    setState(() {
      constant.totalpayment = answer;
    });

    return constant.totalpayment;
  }

  void buttonHandler(int index) {
    setState(() {
      if (moneyChar.length < 6) {
        moneyChar.add(index.toString());
      } else {
        moneyChar[0] = moneyChar[1];
        moneyChar[1] = moneyChar[2];
        moneyChar[2] = moneyChar[3];
        moneyChar[3] = moneyChar[4];
        moneyChar[4] = moneyChar[5];
        moneyChar[5] = index.toString();
      }
    });

    widget.callback(constructMoney());
  }

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
                '\$',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: AppColor.kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
              ),
              Text(
                constructMoney(),
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
                Expanded(child: _buildButton(2)),
                SizedBox(
                  width: 8,
                ),
                Expanded(child: _buildButton(3))
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
                Expanded(child: _buildButton(4)),
                SizedBox(
                  width: 8,
                ),
                Expanded(child: _buildButton(5)),
                SizedBox(
                  width: 8,
                ),
                Expanded(child: _buildButton(6))
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
                Expanded(child: _buildButton(7)),
                SizedBox(
                  width: 8,
                ),
                Expanded(child: _buildButton(8)),
                SizedBox(
                  width: 8,
                ),
                Expanded(child: _buildButton(9))
              ],
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Row(
              children: [
                // Expanded(
                //   child: _buildButton(0),
                // ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: _buildButton(0),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: _buildBackspace(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackspace() {
    return GestureDetector(
      onTap: () {
        if (moneyChar.isEmpty) {
          return;
        }

        setState(() {
          moneyChar.removeLast();
        });

        widget.callback(constructMoney());
      },
      child: Container(
        height: 48.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.kPlaceholder2,
          borderRadius: BorderRadius.circular(16.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        child: SvgPicture.asset(
          'assets/images/backspace.svg',
          width: 32.w,
        ),
      ),
    );
  }

  Widget _buildThreeZero(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (moneyChar.length == 3 &&
            moneyChar.every((element) => element == '0')) {
          return;
        }
        if (moneyChar.length == 3 &&
            moneyChar[0] == '0' &&
            moneyChar[1] == '0') {
          setState(() {
            moneyChar[0] = moneyChar[2];
            moneyChar[1] = '0';
            moneyChar[2] = '0';
            moneyChar.add('0');
          });
          return;
        }
        if (moneyChar.length == 3 && moneyChar[0] == '0') {
          setState(() {
            moneyChar[0] = moneyChar[1];
            moneyChar[1] = moneyChar[2];
            moneyChar[2] = '0';
            moneyChar.add('0');
            moneyChar.add('0');
          });
          return;
        }
        for (int i = 0; i < 3; i++) {
          moneyChar.add('0');
        }
        setState(() {});
        widget.callback(constructMoney());
      },
      child: Container(
        height: 48.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.kPlaceholder2,
          borderRadius: BorderRadius.circular(16.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        child: Text(
          '000',
          style: Theme.of(context).textTheme.headline3!.copyWith(
                color: AppColor.kAccentColor,
              ),
        ),
      ),
    );
  }

  Widget _buildButton(int index) {
    return GestureDetector(
      onTap: () => {
        buttonHandler(index),
      },
      child: Container(
        height: 48.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.kPlaceholder2,
          // selectedIndex == index
          //     ? AppColor.kPrimaryColor
          //     : AppColor.kPlaceholder2,
          borderRadius: BorderRadius.circular(16.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$index ',
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: AppColor.kPrimaryColor,
                    // selectedIndex == index
                    //     ? Colors.white
                    //     : AppColor.kPrimaryColor,
                    fontSize: 20,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
