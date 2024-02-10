import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'common.dart';
import 'page2.dart';

class CreateProfilePage1 extends StatefulWidget {
  const CreateProfilePage1({super.key});

  @override
  State<CreateProfilePage1> createState() => _CreateProfilePage1State();
}

class _CreateProfilePage1State extends State<CreateProfilePage1> {
  File? image;
  String name = '';

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

  void updateName(String value) {
    setState(() {
      name = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Who are you?',
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: pickImage,
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 80,
                backgroundImage: image != null ? FileImage(image!) : null,
                child: image == null
                    ? const Icon(
                        Icons.add_a_photo,
                        size: 40,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: updateName,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: (image == null || name.isEmpty)
          ? null
          : NextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateProfilePage2()),
                );
              },
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
