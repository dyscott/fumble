import 'package:flutter/material.dart';
import '../../components/card.dart';
import '../../models/create.dart';
import '../create/page1.dart'; // Import the ExpandableBioCard component

class ProfilePage extends StatefulWidget {
  // User information
  final String avatarUrl;
  final String name;
  final String bio;
  final String id;

  // make a pocketbase query
  // or fetch only the first record that matches the specified filter

  const ProfilePage({
    Key? key,
    required this.avatarUrl,
    required this.name,
    required this.bio,
    required this.id,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void handleEdit() async {
    final nav = Navigator.of(context);
    final model = CreateProfileModel(
        userId: widget.id, name: widget.name, bio: widget.bio);

    nav.push(
      MaterialPageRoute(
        builder: (context) => CreateProfilePage1(model: model),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ExpandableBioCard(
              avatarUrl: widget.avatarUrl,
              name: widget.name,
              bio: widget.bio,
              id: widget.id,
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
