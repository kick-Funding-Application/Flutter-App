import 'package:flutter/material.dart';
import 'package:kickfunding/theme/app_color.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Delete Project',
        style:
            TextStyle(color: AppColor.kForthColor, fontWeight: FontWeight.bold),
      ),
      content: Text(
        'Are you sure you want to delete this project?',
        style: TextStyle(color: AppColor.kTextColor1),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // User pressed "Cancel"
            Navigator.of(context).pop(false); // Return false
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: AppColor.kTextColor1),
          ),
        ),
        TextButton(
          onPressed: () {
            // User pressed "Delete"
            Navigator.of(context).pop(true); // Return true
          },
          child: Text(
            'Delete',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
