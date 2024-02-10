import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'common.dart';
import 'page4.dart';

class CreateProfilePage3 extends StatefulWidget {
  const CreateProfilePage3({super.key});

  @override
  State<CreateProfilePage3> createState() => _CreateProfilePage3State();
}

class _CreateProfilePage3State extends State<CreateProfilePage3> {
  String bio = '';

  List<File?> imageFiles = [];

  void addImage() async {
    var imagePicker = ImagePicker();
    var pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        imageFiles.add(File(pickedImage.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when the user taps outside the text field
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: TopBackButton(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Tell us more about yourself',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  MultiPhotoUpload(imageFiles: imageFiles, addImage: addImage),
                  const SizedBox(height: 20),
                  TextField(
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: 'Enter your bio here...',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      // Update the bio variable when the text changes
                      setState(() {
                        bio = value;
                      });
                    },
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '${bio.length}/300 characters',
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: NextButton(onPressed: () {
          // Navigate to the next page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateProfilePage4()),
          );
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}

class MultiPhotoUpload extends StatelessWidget {
  final List<File?> imageFiles;
  final VoidCallback addImage;

  const MultiPhotoUpload(
      {super.key, required this.imageFiles, required this.addImage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width,
        child: PageView.builder(
          itemCount: imageFiles.length < 5 ? imageFiles.length + 1 : 5,
          itemBuilder: (BuildContext context, int index) {
            if (index == imageFiles.length && index < 5) {
              return GestureDetector(
                onTap: addImage,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.rectangle,
                    ),
                    child: const Icon(
                      Icons.add_a_photo,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    image: imageFiles[index] != null
                        ? DecorationImage(
                            image: FileImage(imageFiles[index]!),
                            fit: BoxFit.cover,
                          )
                        : null,
                    shape: BoxShape.rectangle,
                  ),
                ),
              );
            }
          },
        ));
  }
}
