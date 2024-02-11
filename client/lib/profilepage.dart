import 'package:flutter/material.dart';
import 'card.dart'; // Import the ExpandableBioCard component

class ProfilePage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ExpandableBioCard(
              avatarUrl: avatarUrl,
              name: name,
              bio: bio,
              id: id,
            ),
            const SizedBox(height: 20), // Add some space between the card and the button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                width: 50, // Adjust the width of the button
                height: 50, // Adjust the height of the button
                child: ElevatedButton(
                  onPressed: () {
                    // Handle button press
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(), // Make the button a circle
                    backgroundColor: Colors.purple, // Background color of button
                    foregroundColor: Colors.white, // Text color of button
                  ),
                  child: const Icon(Icons.edit), // Icon displayed
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
 
  
}
