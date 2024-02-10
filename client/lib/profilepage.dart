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
        padding: EdgeInsets.all(8.0),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple, // Background color of button
                foregroundColor: Colors.white, // Text color of button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0), // Circular border radius
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                child: Text(
                  'Edit',
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
