import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'auth.dart';

class CreateProfileModel {
  String userId;
  String name;
  File? avatar;
  String bio = '';
  String? course;
  File? galleryImage;

  CreateProfileModel(
      {required this.userId,
      this.name = '',
      this.avatar,
      this.bio = '',
      this.course,
      this.galleryImage});

  Future<void> uploadProfile() async {
    await pb.collection('users').update(userId, body: {
      'name': name,
      'bio': bio,
      'classes': course,
      'profileComplete': true,
    }, files: [
      http.MultipartFile.fromBytes('avatar', await avatar!.readAsBytes(),
          filename: avatar!.path.split('/').last),
      http.MultipartFile.fromBytes(
          'gallery', await galleryImage!.readAsBytes(),
          filename: galleryImage!.path.split('/').last),
    ]);
  }
}

class NextButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NextButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      label: const Text('Next', style: TextStyle(color: Colors.white)),
      icon: const Icon(Icons.arrow_forward, color: Colors.white),
      backgroundColor: Colors.purple,
    );
  }
}

class TopBackButton extends StatelessWidget {
  final Widget? child;
  const TopBackButton({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          const BackButton(),
          child ?? Container(),
        ],
      ),
    );
  }
}
