import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kickfunding/initials/constants.dart';
import 'package:kickfunding/ui/tab/charity/uploadprojectimage.dart';
import 'package:kickfunding/ui/tab/widgets/charity/categroyinput.dart';
import 'package:kickfunding/ui/tab/widgets/charity/charity_input_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../../../routes/routes.dart';
import '../../../../theme/app_color.dart';
import '../widgets/profile/birthdate.dart';

//// NO PHONE , NO ADDRESS, NOSOCIAL, ONE CATEGORY,NO PROFFESSION ,

//TITLE, TAG, TARGET,DEADLINE,PHOTO,DESCRIPTION,
/////
//////
//
List<GlobalKey<FormState>> formKeys = [
  GlobalKey<FormState>(),
  GlobalKey<FormState>()
];

class StartCharityScreen extends StatefulWidget {
  const StartCharityScreen();

  @override
  State<StartCharityScreen> createState() => _StartCharityScreenState();
}

var title = TextEditingController();
var tags = TextEditingController();
var target = TextEditingController();
var deadline = TextEditingController();
var desc = TextEditingController();

int currentStep = 0;

class _StartCharityScreenState extends State<StartCharityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kPlaceholder1,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(RouteGenerator.main);
          },
          icon: Icon(Icons.arrow_back_ios_new),
          color: Colors.white,
        ),
        backgroundColor: AppColor.kForthColor,
        title: Text('Start a new Charity'),
      ),
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(primary: AppColor.kAccentColor),
            ),
            child: Stepper(
                controlsBuilder:
                    (BuildContext context, ControlsDetails details) {
                  final isLastStep = currentStep == 2;
                  return Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Row(
                      children: [
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
                                    double.infinity,
                                    56.h,
                                  ),
                                ),
                              ),
                              onPressed: details.onStepContinue,
                              child: Text(isLastStep ? 'Publish' : 'Next')),
                        ),
                        const SizedBox(width: 12),
                        if (currentStep != 0)
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
                                      double.infinity,
                                      56.h,
                                    ),
                                  ),
                                ),
                                onPressed: details.onStepCancel,
                                child: Text('Back')),
                          ),
                      ],
                    ),
                  );
                },
                type: StepperType.horizontal,
                steps: [
                  Step(
                    state: currentStep > 0
                        ? StepState.complete
                        : StepState.indexed,
                    isActive: currentStep >= 0,
                    title: Text('One'),
                    content: SingleChildScrollView(
                      child: Form(
                        // key: formKeys[0],
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CharityInputField(
                                'Title of the project',
                                onchanged: (String value) {
                                  setState(() {
                                    charityform.title = value;
                                  });
                                },
                                validateStatus: (value) {
                                  if (value!.isEmpty) {
                                    return 'Field must not be empty';
                                  }
                                  return null;
                                },
                                controller: title,
                              ),
                              SizedBox(height: 8.h),
                              categoryinputfield(
                                'Category',
                                onchanged: (String value) {
                                  setState(() {
                                    charityform.category = value;
                                  });
                                },
                                validateStatus: (value) {
                                  if (value!.isEmpty) {
                                    return 'Field must not be empty';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 8.h),
                              CharityInputField(
                                'Tags',
                                onchanged: (String value) {
                                  setState(() {
                                    charityform.tags = value;
                                  });
                                },
                                controller: tags,
                                validateStatus: (value) {
                                  if (value!.isEmpty) {
                                    return 'Field must not be empty';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 8.h),
                              CharityInputField(
                                'Target',
                                assetName: 'assets/images/dollar.svg',
                                onchanged: (String value) {
                                  charityform.target = value;
                                },
                                validateStatus: (value) {
                                  if (value!.isEmpty) {
                                    return 'Field must not be empty';
                                  }
                                  return null;
                                },
                                keyboardtype: TextInputType.number,
                                controller: target,
                              ),
                              SizedBox(height: 8.h),
                              Text('Deadline'),
                              SizedBox(height: 8.h),
                              BirthdateInputField(
                                  title: 'Deadline',
                                  controller: deadline,
                                  onChanged: (String value) {
                                    setState(() {
                                      charityform.deadline = value;
                                    });
                                  },
                                  validateStatus: (value) {
                                    if (value!.isEmpty) {
                                      return 'Field must not be empty';
                                    }
                                    return null;
                                  },
                                  onSaved: (String value) {
                                    setState(() {
                                      charityform.deadline = value;
                                    });
                                  },
                                  height: 15,
                                  color: AppColor.kPlaceholder2),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Step(
                    state: currentStep > 1
                        ? StepState.complete
                        : StepState.indexed,
                    isActive: currentStep >= 1,
                    title: Text('Two'),
                    content: Form(
                      //    key: formKeys[1],
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Upload a photo as a thumbnail',
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            DottedBorder(
                              color: AppColor.kTextColor2,
                              strokeWidth: 1.sp,
                              borderType: BorderType.RRect,
                              radius: Radius.circular(8.r),
                              dashPattern: [15, 10],
                              child: uploadProjectImage(),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Text(
                              'Description',
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Field must not be empty';
                                }
                                return null;
                              },
                              onChanged: (String value) {
                                setState(() {
                                  charityform.description = value;
                                });
                              },
                              controller: desc,
                              minLines: null,
                              maxLines: null,
                              textAlignVertical: TextAlignVertical.top,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColor.kPlaceholder2,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    8.r,
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: AppColor.kTextColor1,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Step(
                    isActive: currentStep >= 2,
                    title: Text('Three'),
                    content: Container(
                        padding: EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Title: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  '${charityform.title}',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Catgeory: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  '${charityform.category}',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Tags: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  '${charityform.tags}',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Target: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  '${charityform.target}',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Deadline: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  '${charityform.deadline}',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        )),
                  ),
                ],
                currentStep: currentStep,
                onStepContinue: () {
                  final isLastStep = currentStep == 2;

                  if (isLastStep) {
                    print('complete');
                    resetFormState(formKeys[0]);
                    resetFormState(formKeys[1]);
                    showSheet();
                  } else if (currentStep < 3 - 1) {
                    setState(() {
                      currentStep += 1;
                    });
                  }

                  ;
                },
                onStepCancel: () {
                  if (currentStep == 0) {
                    return null;
                  } else if (currentStep > 0) {
                    setState(() {
                      currentStep -= 1;
                    });
                  }

                  ;
                }),
          ),
        ),
      ),
    );
  }

  void resetFormState(GlobalKey<FormState> formKey) {
    final FormState? formState = formKey.currentState;
    if (formState != null) {
      formState.reset();
    }
    // Reset other fields and variables as needed
  }

  void showSheet() {
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
            SizedBox(
              height: 64.h,
            ),
            SvgPicture.asset(
              'assets/images/check.svg',
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              'Successful',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColor.kPrimaryColor,
                  ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              'Your charity has been successsfully created. '
              'Now you can check it in your \'activity\' menu.',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 80.h,
            ),
            ElevatedButton(
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
                    double.infinity,
                    56.h,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(RouteGenerator.main);
              },
              child: Text(
                'Home',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
