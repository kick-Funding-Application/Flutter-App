import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../theme/app_color.dart';

import 'circle_progess.dart';

class PercentageIndicatior extends StatefulWidget {
  final String percentage;
  PercentageIndicatior({required this.percentage});

  @override
  State<PercentageIndicatior> createState() => _PercentageIndicatiorState();
}

class _PercentageIndicatiorState extends State<PercentageIndicatior> {
  @override
  Widget build(BuildContext context) {
    var percent = double.parse(widget.percentage);
    return Container(
      width: 64.w,
      height: 64.w,
      child: Stack(
        children: [
          Positioned(
            top: -8.w,
            left: -8.w,
            child: SizedBox(
                width: 80.w,
                height: 80.w,
                child: CustomPaint(
                  foregroundPainter: CircleProgress(percent as double),
                  child: Container(
                    width: 80.w,
                    height: 80.w,
                  ),
                )),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.kPlaceholder2,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: Center(
                child: Row(
                  children: [
                    Text(
                      ' ${widget.percentage} %',
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
