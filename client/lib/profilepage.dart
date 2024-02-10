import 'package:flutter/material.dart';
import 'card.dart'; // Import the ExpandableBioCard component

class ProfilePage extends StatelessWidget {
  // User information
  final String avatarUrl;
  final String name;
  final String bio;

  const ProfilePage({
    Key? key,
    required this.avatarUrl,
    required this.name,
    required this.bio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ExpandableBioCard(
              avatarUrl: avatarUrl,
              name: name,
              bio: bio,
            ),
            SizedBox(height: 20), // Add some space between the card and the button
            ElevatedButton(
              onPressed: () {
                // Handle edit button tap
                // Navigate to the edit profile page or show a dialog for editing
              },
              child: Text('Edit'),
            ),
          ],
        ),
      ),
    );
  }
}
