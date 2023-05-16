import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kickfunding/ui/tab/widgets/profile/constants.dart';
import '../../../../theme/app_color.dart';
import 'package:image/image.dart' as img; // Import image package
import 'package:path_provider/path_provider.dart'; // Import path_provider package
import 'package:flutter_image_compress/flutter_image_compress.dart';

// class uploadpicture extends StatefulWidget {
//   const uploadpicture(
//       {Key? key, required this.buttoncolor, required this.height})
//       : super(key: key);

//   final Color buttoncolor;
//   final int height;

//   @override
//   State<uploadpicture> createState() => _uploadpictureState();
// }

// File? _profilePicture;

// class _uploadpictureState extends State<uploadpicture> {
//   Future pickercamera() async {
//     final file = await ImagePicker().getImage(source: ImageSource.gallery);
//     if (file != null) {
//       final image = img.decodeImage(File(file.path).readAsBytesSync());
//       final jpegImage = img.encodeJpg(image!);

//       // Get the directory to save the JPEG image
//       final appDir = await getApplicationDocumentsDirectory();
//       final filePath = '${appDir.path}/profile_image.jpg';

//       // Save the JPEG image
//       File(filePath).writeAsBytesSync(jpegImage);

//       setState(() {
//         _profilePicture = File(filePath);
//         constant.photofile = _profilePicture!.path;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all(
//           widget.buttoncolor,
//         ),
//         shape: MaterialStateProperty.all(
//           RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(
//               8.r,
//             ),
//           ),
//         ),
//         minimumSize: MaterialStateProperty.all(
//           Size(
//             double.infinity,
//             widget.height.h,
//           ),
//         ),
//       ),
//       onPressed: () {
//         pickercamera();
//       },
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Expanded(
//             child: Text(
//               constant.photofile,
//               overflow: TextOverflow.ellipsis,
//               maxLines: 1,
//               style: TextStyle(
//                 color: AppColor.kTextColor1,
//                 fontWeight: FontWeight.normal,
//                 fontSize: 13,
//               ),
//             ),
//           ),
//           Icon(
//             Icons.camera_alt_rounded,
//             color: Color.fromARGB(255, 155, 154, 154),
//             size: 23,
//           ),
//         ],
//       ),
//     );
//   }
// }

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
  Future<void> pickercamera() async {
    final XFile? file =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        _profilePicture = File(file.path);
        constant.image = _profilePicture;
        constant.photofile = _profilePicture!.path;
      });
    }
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
            color: Color.fromARGB(255, 155, 154, 154),
            size: 23,
          ),
        ],
      ),
    );
  }
}
