import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kickfunding/ui/tab/widgets/profile/constants.dart';
import '../../../../theme/app_color.dart';
import 'package:image/image.dart' as img; // Import image package
import 'package:path_provider/path_provider.dart'; // Import path_provider package
import 'package:flutter_image_compress/flutter_image_compress.dart';

class uploadfirebase extends StatefulWidget {
  const uploadfirebase(
      {super.key, required this.buttoncolor, required this.height});
  final Color buttoncolor;
  final int height;

  @override
  State<uploadfirebase> createState() => _uploadfirebaseState();
}

File? _image;

class _uploadfirebaseState extends State<uploadfirebase> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          widget.buttoncolor,
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
            widget.height.h,
          ),
        ),
      ),
      onPressed: () {
        uploadImage(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Text(
              constant.photofile,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  color: AppColor.kTextColor1,
                  fontWeight: FontWeight.normal,
                  fontSize: 13),
            ),
          ),
          Icon(
            Icons.camera_alt_rounded,
            color: AppColor.kTextColor1,
            size: 23,
          ),
        ],
      ),
    );
  }

  Future<void> pickImage() async {
    final XFile? file =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        _image = File(file.path);
        constant.image = _image;
        constant.photofile = _image!.path;
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
        print(url);
        constant.urlprofileimage = url;
        constant.urlprofile = url;
      });
    } catch (ex) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(ex.toString())));
    }
  }
}
