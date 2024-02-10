import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfilePage1 extends StatefulWidget {
  const CreateProfilePage1({super.key});

  @override
  State<CreateProfilePage1> createState() => _CreateProfilePage1State();
}

class _CreateProfilePage1State extends State<CreateProfilePage1> {
  File? image;

  Future pickImage() async {
    var imagePicker = ImagePicker();
    var pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                pickImage();
              },
              child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 80,
                  child: image != null
                      ? Image.file(image!)
                      : const Icon(Icons.add_a_photo, size: 50, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
