import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/ui/tab/widgets/profile/constants.dart';
import '../../../../routes/routes.dart';
import '../../../../theme/app_color.dart';

import 'calculator.dart';
import 'pushdonation.dart';

class CalculatorBuilder extends StatelessWidget {
  const CalculatorBuilder(this.projectID,
      {required this.projectTitle,
      required this.projectOwner,
      required this.projectImage});
  final String projectID;
  final String projectTitle;
  final String projectOwner;
  final String projectImage;
  @override
  Widget build(BuildContext context) {
    String finalValue = '';

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewPadding.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          pushdonation((value) => finalValue = value),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0.w,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 56.w,
                    height: 56.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        8.r,
                      ),
                      color: AppColor.kPrimaryColor.withOpacity(0.3),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/images/close.svg',
                        width: 32.w,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        AppColor.kPrimaryColor,
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            8.r,
                          ),
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all(
                        Size(
                          0,
                          56.h,
                        ),
                      ),
                    ),
                    onPressed: () {
                      constant.pid = projectID;
                      constant.projectowner = projectOwner;
                      constant.projecttitle = projectTitle;
                      constant.projectphoto = projectImage;
                      Navigator.of(context).pushNamed(RouteGenerator.donation,
                          arguments: finalValue);
                    },
                    child: Text(
                      'Donate',
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
