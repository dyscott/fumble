import 'package:flutter/material.dart';
import 'card.dart';
import 'common.dart';
import 'pages/create/page1.dart'; // Import the ExpandableBioCard component

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
    final model = CreateProfileModel(userId: widget.id, name: widget.name, bio: widget.bio);
    
    nav.push(
      MaterialPageRoute(
        builder: (context) => CreateProfilePage1(model: model),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ExpandableBioCard(
            avatarUrl: widget.avatarUrl,
            name: widget.name,
            bio: widget.bio,
            id: widget.id,
          ),
          const SizedBox(
              height: 20), // Add some space between the card and the button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
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
        ],
      ),
    );
  }
}
