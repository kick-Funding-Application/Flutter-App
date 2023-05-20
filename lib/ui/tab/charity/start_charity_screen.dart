import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kickfunding/initials/constants.dart';
import 'package:kickfunding/ui/tab/charity/uploadprojectimage.dart';
import 'package:kickfunding/ui/tab/widgets/charity/categroyinput.dart';
import 'package:kickfunding/ui/tab/widgets/charity/charity_input_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:kickfunding/ui/tab/widgets/profile/projectdate.dart';
import '../../../../routes/routes.dart';
import '../../../../theme/app_color.dart';
import '../../../auth/login_form.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../widgets/profile/constants.dart';
import 'dart:convert';
//import 'package:country_picker/country_picker.dart';
import 'package:http/http.dart' as http;

//// NO PHONE , NO ADDRESS, NOSOCIAL, ONE CATEGORY,NO PROFFESSION ,

//TITLE, TAG, TARGET,DEADLINE,PHOTO,DESCRIPTION,
/////
//////
//

class StartCharityScreen extends StatefulWidget {
  const StartCharityScreen();

  @override
  State<StartCharityScreen> createState() => _StartCharityScreenState();
}

TextEditingController title = TextEditingController();
TextEditingController tags = TextEditingController();
TextEditingController target = TextEditingController();
TextEditingController deadline = TextEditingController();
TextEditingController desc = TextEditingController();
String validateField(String value) {
  if (value.isEmpty) {
    return 'This field is required';
  }
  // Add more validation rules if needed

  return 'null';
}

int currentStep = 0;
var photoUrl =
    'https://www.hi-reit.com/wp-content/uploads/landscape-placeholder-2.png';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
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
                    charityform.target = int.parse(value);
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
                projectDate(
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
                SizedBox(
                  height: 20.h,
                ),
                Column(
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
                      child: GestureDetector(
                        onTap: () {
                          _pickImage();
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: double.infinity,
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 180.h,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 8.h,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    32.r,
                                  ),
                                  color: AppColor.kPlaceholder2,
                                ),
                              ),
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        photoUrl,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                      textInputAction: TextInputAction.done,
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
                      maxLines: 3,
                      maxLength: 150,
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
                        hintStyle:
                            Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color: AppColor.kTextColor1,
                                ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 56.h,
                  width: double.infinity,
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
                      onPressed: () {
                        uploadproject(context);
                      },
                      child: Text('Upload Project')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validate() {}
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

  File? _image;
  String? _imageUrl;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 20);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
      _uploadImage();
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().microsecondsSinceEpoch}.jpg');

      firebase_storage.UploadTask uploadTask = ref.putFile(_image!);
      firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      setState(() {
        _imageUrl = imageUrl;

        photoUrl = _imageUrl!;
        print(_imageUrl);
      });
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Text("Uploaded Image"),
        ),
      );

      print('Image uploaded successfully. URL: $_imageUrl');
    } catch (e) {
      print('Failed to upload image: $e');
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Text("Failed to Upload Image"),
        ),
      );
    }
  }

  Future uploadproject(BuildContext cont) async {
    try {
      /**removecomment when online */
      Map<String, dynamic> body = {
        "title": "${charityform.title}",
        "target_amount": charityform.target,
        "details": "${charityform.description}",
        "end_date": "${charityform.deadline}",
        "tags": "${charityform.tags}",
        "category": "${charityform.category}",
        "image": "$photoUrl",
      };
      String jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');

      var url = Uri.parse("${constant.server}api/projects/");
      var response = await http.post(url,
          headers: {
            'content-Type': 'application/json',
            "Authorization": "Token ${token}"
          },
          body: jsonBody,
          encoding: encoding);
      var result = response.body;
      print(result);

      if (response.statusCode == 201) {
        print("Registeration succeeded");
        // showDialog(
        //     context: context,
        //     builder: (_) => const AlertDialog(
        //           content: Text("Project Uploaded Successfully"),
        //         ));
        showSheet();
        title.clear();
        tags.clear();
        target.clear();
        deadline.clear();
        desc.clear();
        print('Registration successful');
      } else {
        print("Registeration Failed");
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
                  content: Text("Fill in the Fields!!! "),
                ));
      }

      /**removecomment when online */
    } catch (e) {
      print(e.toString());
    }
  }
}
