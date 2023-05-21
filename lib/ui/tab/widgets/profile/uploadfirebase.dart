import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:kickfunding/ui/tab/widgets/profile/constants.dart';

class ImagePickerButton extends StatefulWidget {
  @override
  _ImagePickerButtonState createState() => _ImagePickerButtonState();
}

class _ImagePickerButtonState extends State<ImagePickerButton> {
  File? _image;
  String? _imageUrl;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 25);

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _pickImage();
      },
      child: Text('Pick Image'),
    );
  }
}
