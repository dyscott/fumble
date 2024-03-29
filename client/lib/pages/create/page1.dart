import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/nav.dart';
import '../../models/create.dart';
import 'page2.dart';

class CreateProfilePage1 extends StatefulWidget {
  final CreateProfileModel model;

  const CreateProfilePage1({super.key, required this.model});

  @override
  State<CreateProfilePage1> createState() => _CreateProfilePage1State();
}

class _CreateProfilePage1State extends State<CreateProfilePage1> {
  Future pickImage() async {
    var imagePicker = ImagePicker();
    var pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        widget.model.avatar = pickedImage;
      });
    }
  }

  void updateName(String value) {
    setState(() {
      widget.model.name = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var model = widget.model;

    ImageProvider<Object>? image;
    if (model.avatar != null) {
      if (kIsWeb) {
        image = Image.network(model.avatar!.path).image;
      } else {
        image = FileImage(File(model.avatar!.path));
      }
    }

    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when the user taps outside the text field
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: TopBackButton(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Who are you?',
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 16),
                const Text('Upload an avatar and enter your name',
                    style: TextStyle(
                      fontSize: 18.0,
                    )),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: pickImage,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 80,
                    backgroundImage: image,
                    child: model.avatar == null
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
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: updateName,
                    initialValue: model.name,
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: (model.avatar == null || model.name.isEmpty)
            ? null
            : NextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateProfilePage2(model: model)),
                  );
                },
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
