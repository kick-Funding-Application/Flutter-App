import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kickfunding/initials/constants.dart';

import '../../../../models/charity.dart';
import '../../../../routes/routes.dart';
import '../../../../theme/app_color.dart';

class startproject extends StatefulWidget {
  const startproject();

  @override
  State<startproject> createState() => _startprojectState();
}

class _startprojectState extends State<startproject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kForthColor,
      appBar: AppBar(),
      body: Stepper(
        type: StepperType.horizontal,
        steps: getsteps(),
      ),
    );
  }

  List<Step> getsteps() => [
        Step(title: Text('One'), content: Container()),
        Step(title: Text('Two'), content: Container()),
        Step(title: Text('Three'), content: Container()),
      ];
}
