import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:pocketbase/pocketbase.dart';

import '../util/auth.dart';

class CreateProfileModel {
  String userId;
  String name;
  XFile? avatar;
  String bio = '';
  String? course;
  XFile? galleryImage;
  bool edit;

  CreateProfileModel(
      {required this.userId,
      this.name = '',
      this.avatar,
      this.bio = '',
      this.course,
      this.galleryImage,
      this.edit = false});

  Future<void> uploadProfile() async {
    await pb.collection('users').update(userId, body: {
      'name': name,
      'bio': bio,
      'classes': course,
      'profileComplete': true,
    }, files: [
      http.MultipartFile.fromBytes('avatar', await avatar!.readAsBytes(),
          filename: avatar!.path.split('/').last),
      http.MultipartFile.fromBytes('gallery', await galleryImage!.readAsBytes(),
          filename: galleryImage!.path.split('/').last),
    ]);
  }

  static CreateProfileModel fromUser(RecordModel user) {
    final avatar = user.data['avatar'];
    final avatarUrl = pb.files.getUrl(user, avatar).toString();
    final XFile avatarFile = XFile(avatarUrl);

    final gallery = user.data['gallery'][0];
    final galleryUrl = pb.files.getUrl(user, gallery).toString();
    final XFile galleryFile = XFile(galleryUrl);

    return CreateProfileModel(
      userId: user.id,
      avatar: avatarFile,
      name: user.data['name'],
      bio: user.data['bio'],
      course: user.data['classes'],
      galleryImage: galleryFile,
      edit: true,
    );
  }
}
