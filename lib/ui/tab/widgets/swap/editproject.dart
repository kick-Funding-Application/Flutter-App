import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kickfunding/auth/login_form.dart';
import 'package:kickfunding/ui/tab/widgets/profile/uploadfirebase.dart';
import '../../../../models/urgent.dart';
import '../charity/categroyinput.dart';
import '../profile/projectdate.dart';
import '/ui/custom_input_field.dart';
import '../../../../routes/routes.dart';
import '../../../../theme/app_color.dart';
import '../charity/charity_input_field.dart';
import '../../../constants.dart';
import '/initials/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:convert';

import 'deleteproject.dart';

class EditProject extends StatefulWidget {
  const EditProject(
    this.projectID, {
    required this.Title,
    required this.category,
    required this.desc,
    required this.tags,
    required this.Target,
    required this.deadline,
    required this.image,
    required this.createdAt,
  });
  final String category;
  final String Title;
  final String desc;
  final String tags;
  final String Target;
  final String deadline;
  final String image;
  final String createdAt;
  final String projectID;
  @override
  State<EditProject> createState() => _EditProjectState();
}

class _EditProjectState extends State<EditProject> {
  final _formKey2 = GlobalKey<FormState>();
  late TextEditingController title;
  late TextEditingController desc;
  late TextEditingController tags;
  late TextEditingController target;
  late TextEditingController deadline;
  late var photoUrl;

  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with existing data
    title = TextEditingController(text: '${widget.Title}');
    desc = TextEditingController(text: " ${widget.desc}");
    tags = TextEditingController(text: "${widget.tags}");
    target = TextEditingController(text: "${widget.Target}");
    deadline = TextEditingController(text: "${widget.deadline}");
    photoUrl = widget.image;
    charityform.category = widget.category;
  }

  void _submitForm() async {
    if (_formKey2.currentState!.validate()) {
      _formKey2.currentState!.save();

      try {
        /**removecomment when online */
        Map<String, dynamic> body = {
          "title": title.text,
          "target_amount": target.text,
          "details": desc.text,
          "end_date": deadline.text,
          "tags": tags.text,
          "category": "${charityform.category}",
          "image": "$photoUrl",
        };
        String jsonBody = json.encode(body);
        final encoding = Encoding.getByName('utf-8');

        var url =
            Uri.parse("${constant.server}api/projects/${widget.projectID}/");
        var response = await http.put(url,
            headers: {
              'content-Type': 'application/json',
              "Authorization": "Token ${token}"
            },
            body: jsonBody,
            encoding: encoding);
        var result = response.body;
        print(result);
        print(response.statusCode);

        if (response.statusCode == 200) {
          print("Updated success");
          showDialog(
              context: context,
              builder: (_) => const AlertDialog(
                    content: Text("Updated Successfully"),
                  ));
        } else {
          print("Failed");
          showDialog(
              context: context,
              builder: (_) => const AlertDialog(
                    content: Text("Failed to Update "),
                  ));
        }

        /**removecomment when online */
      } catch (e) {
        print(e.toString());
      }
    }
  }

  /*Controllers*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new),
          color: Colors.white,
        ),
        backgroundColor: AppColor.kForthColor,
        title: Text('Edit Your project'),
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey2,
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 16.h,
                ),
                SizedBox(
                  height: 120.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 180.w,
                            height: 180.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                8.r,
                              ),
                              color: AppColor.kPlaceholder1,
                              image: DecorationImage(
                                  image: NetworkImage("${photoUrl}"),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Positioned(
                            right: -3.w,
                            bottom: -3.w,
                            child: GestureDetector(
                              onTap: () {
                                _pickImage();
                              },
                              child: SvgPicture.asset(
                                'assets/images/edit.svg',
                                width: 32.w,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Project title: ${widget.Title}',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              'Created at: ${widget.createdAt}',
                              style: TextStyle(
                                color: AppColor.kTextColor1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
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
                    try {
                      charityform.target = int.parse(target.text);
                    } catch (e) {
                      print(e.toString());
                    }
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
                  style: TextStyle(color: AppColor.kTextColor1),
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
                    hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: AppColor.kTextColor1,
                        ),
                  ),
                ),
                SizedBox(height: 26.h),
                Row(
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
                        onPressed: () {
                          _submitForm();
                          //   saveprofile();
                        },
                        child: Text(
                          'Update',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            AppColor.kForthColor,
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
                          showDeleteConfirmationDialog(context);
                        },
                        child: Text(
                          'Delete',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.h,
                ),
              ],
            ),
          ),
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
        constant.urlprojectimage = _imageUrl!;
        photoUrl = _imageUrl;
      });
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Text("Uploaded Image"),
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Text("Failed to Upload Image"),
        ),
      );
    }
  }

  void showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteConfirmationDialog();
      },
    ).then((value) {
      if (value != null && value) {
        delete(context);
      } else {
        print('cancelled');
      }
    });
  }

  void delete(BuildContext context) async {
    try {
      var url =
          Uri.parse("${constant.server}api/projects/${widget.projectID}/");
      var response = await http.delete(
        url,
        headers: {
          'content-Type': 'application/json',
          "Authorization": "Token ${token}",
        },
      );
      var result = response.body;

      if (response.statusCode == 204) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Deleted Successfully')));
        Navigator.of(context).pushNamed(RouteGenerator.main);
      } else {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Text("Failed to Delete"),
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
