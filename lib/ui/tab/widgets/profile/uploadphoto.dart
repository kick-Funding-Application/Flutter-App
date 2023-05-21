import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kickfunding/ui/tab/widgets/profile/constants.dart';
import '../../../../theme/app_color.dart';
import 'package:image/image.dart' as img; // Import image package
import 'package:path_provider/path_provider.dart'; // Import path_provider package
import 'package:flutter_image_compress/flutter_image_compress.dart';

class uploadpicture extends StatefulWidget {
  const uploadpicture(
      {super.key, required this.buttoncolor, required this.height});
  final Color buttoncolor;
  final int height;

  @override
  State<uploadpicture> createState() => _uploadpictureState();
}

class _uploadpictureState extends State<uploadpicture> {
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
        _pickImage();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Text(
              _imageUrl != null ? '$_imageUrl' : 'Upload Picture',
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
            color: Color.fromARGB(255, 155, 154, 154),
            size: 23,
          ),
        ],
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
        constant.urlprofile = _imageUrl!;
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
}
