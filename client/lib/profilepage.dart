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
              child: Container(
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // handle button press
                        // swipingCardDeck.swipeLeft();
                      },
                      color: Colors.white,
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
 
  
}
