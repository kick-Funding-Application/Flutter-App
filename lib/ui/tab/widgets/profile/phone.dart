import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants.dart';
import '../../../../theme/app_color.dart';

class IntlPhoneField extends StatefulWidget {
  const IntlPhoneField({super.key, this.controller, this.validateStatus});
  final controller;
  final FormFieldValidator? validateStatus;
  @override
  State<IntlPhoneField> createState() => _IntlPhoneFieldState();
}

String initialCountry = 'EG';
PhoneNumber number = PhoneNumber(isoCode: 'EG');

class _IntlPhoneFieldState extends State<IntlPhoneField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 1.h,
      ),
      decoration: BoxDecoration(
        color: AppColor.kPlaceholder1,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {
              constant.phone = number.phoneNumber.toString();
              print(number.phoneNumber);
            },
            onInputValidated: (bool value) {
              print(value);
            },
            selectorConfig: SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            ),
            ignoreBlank: false,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            selectorTextStyle: TextStyle(color: AppColor.kTextColor1),
            initialValue: number,
            textFieldController: widget.controller,
            formatInput: true,
            textStyle: TextStyle(color: AppColor.kTextColor1, fontSize: 15),
            textAlignVertical: TextAlignVertical.top,
            inputDecoration: InputDecoration(border: InputBorder.none),
            keyboardType: TextInputType.numberWithOptions(
              signed: true,
              decimal: true,
            ),
            //   inputBorder: OutlineInputBorder(),
            onSaved: (PhoneNumber number) {
              print('On Saved: $number');
            },
          ),
        ],
      ),
    );
  }
}
