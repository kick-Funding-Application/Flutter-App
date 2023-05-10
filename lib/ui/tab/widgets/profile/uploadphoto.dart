import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../theme/app_color.dart';

class uploadpicture extends StatefulWidget {
  const uploadpicture(
      {super.key, required this.buttoncolor, required this.height});
  final Color buttoncolor;
  final int height;

  @override
  State<uploadpicture> createState() => _uploadpictureState();
}

File? _profilePicture;

class _uploadpictureState extends State<uploadpicture> {
  Future pickercamera() async {
    final file = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _profilePicture = File(file!.path);
    });
  }

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
        pickercamera();
        
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Text(
              _profilePicture != null ? '$_profilePicture' : 'Upload Picture',
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
}
