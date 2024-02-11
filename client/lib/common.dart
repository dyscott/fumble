import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'auth.dart';

class CreateProfileModel {
  String userId;
  String name;
  XFile? avatar;
  String bio = '';
  String? course;
  XFile? galleryImage;

  CreateProfileModel(
      {required this.userId,
      this.name = '',
      this.avatar,
      this.bio = '',
      this.course,
      this.galleryImage});

  Future<void> uploadProfile() async {
    if (kIsWeb) {
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
      return;
    }
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
