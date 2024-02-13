import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/nav.dart';
import '../../models/create.dart';
import 'page4.dart';

class CreateProfilePage3 extends StatefulWidget {
  final CreateProfileModel model;

  const CreateProfilePage3({super.key, required this.model});

  @override
  State<CreateProfilePage3> createState() => _CreateProfilePage3State();
}

class _CreateProfilePage3State extends State<CreateProfilePage3> {
  void setImage() async {
    var imagePicker = ImagePicker();
    var pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        widget.model.galleryImage = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var model = widget.model;

    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when the user taps outside the text field
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: TopBackButton(
          child: Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Tell us more about yourself',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  MultiPhotoUpload(
                    image: model.galleryImage,
                    setImage: setImage,
                  ),
                  TextField(
                    maxLines: 5,
                    maxLength: 300,
                    decoration: const InputDecoration(
                      hintText: 'Enter your bio here...',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      // Update the bio variable when the text changes
                      setState(() {
                        model.bio = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: (model.bio.isEmpty || model.galleryImage == null)
            ? null
            : NextButton(onPressed: () {
                // Navigate to the next page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateProfilePage4(model: model)),
                );
              }),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}

class MultiPhotoUpload extends StatelessWidget {
  final XFile? image;
  final VoidCallback setImage;

  const MultiPhotoUpload(
      {super.key, required this.image, required this.setImage});

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object>? image;
    if (this.image != null) {
      image = kIsWeb
          ? Image.network(this.image!.path).image
          : FileImage(File(this.image!.path));
    }

    return Expanded(
      child: Center(
        child: AspectRatio(
          aspectRatio: 1.0, // 1.0 for a square aspect ratio
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: setImage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    image: image != null
                        ? DecorationImage(
                            image: image,
                            fit: BoxFit.cover,
                          )
                        : null,
                    shape: BoxShape.rectangle,
                  ),
                  child: image == null ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo,
                        size: 48.0,
                        color: Colors.white,
                      ),
                      SizedBox(height: 32.0),
                      Text(
                        'Upload a gallery photo of yourself so that others can see you before they match',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ) : null,
                ),
              )),
        ),
      ),
    );
  }
}
