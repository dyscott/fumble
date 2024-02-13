import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../util/auth.dart';

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
