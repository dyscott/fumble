import 'package:Fumble/util/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/card.dart';
import '../../models/create.dart';
import '../create/page1.dart'; // Import the ExpandableBioCard component

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void handleEdit() async {
    final nav = Navigator.of(context);
    final user = Provider.of<AuthProvider>(context, listen: false).user!;

    final model = CreateProfileModel.fromUser(user);

    nav.push(
      MaterialPageRoute(
        builder: (context) => CreateProfilePage1(model: model),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user!;

    final avatarUrl = pb.files.getUrl(user, user.data['gallery'][0]).toString();

    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ExpandableBioCard(
              avatarUrl: avatarUrl,
              name: user.data['name'],
              bio: user.data['bio'],
              id: user.id,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: handleEdit,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
