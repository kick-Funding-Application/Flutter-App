import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kickfunding/ui/constants.dart';
import '../../../../theme/app_color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image/image.dart' as img; // Import image package
import 'package:path_provider/path_provider.dart'; // Import path_provider package
import 'package:flutter_image_compress/flutter_image_compress.dart';

class uploadProjectImage extends StatefulWidget {
  const uploadProjectImage({
    super.key,
    this.onTap,
    required this.image,
  });
  final void Function()? onTap;
  final String image;

  @override
  State<uploadProjectImage> createState() => _uploadProjectImageState();
}

File? _image;

class _uploadProjectImageState extends State<uploadProjectImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Center(
          child: Column(
            children: [
              Container(
                width: 130.w,
                height: 130.w,
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    32.r,
                  ),
                  color: AppColor.kPlaceholder2,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://th.bing.com/th/id/OIP.331GjjPitU9zLBRx6caEFgHaF3?pid=ImgDet&rs=1"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      'Upload a photo ',
                      style: TextStyle(
                        color: AppColor.kTextColor2,
                        fontSize: 12.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    final XFile? file =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        _image = File(file.path);
        constant.projectImage = _image;
      });
    }
  }

  void uploadImage(context) async {
    pickImage();
    try {
      FirebaseStorage storage = FirebaseStorage.instanceFor(
          bucket: 'gs://kickfunding-a2c6e.appspot.com');
      Reference ref = storage
          .ref()
          .child(p.basename(_image!.path) + DateTime.now().toString());
      UploadTask storageUploadTask = ref.putFile(_image!);
      TaskSnapshot taskSnapshot = await storageUploadTask.whenComplete(() =>
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Uploaded Image Successfully'))));
      String url = await taskSnapshot.ref.getDownloadURL();

      setState(() {
        constant.urlprojectimage = url;
        print(url);
      });
    } catch (ex) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(ex.toString())));
    }
  }
}
