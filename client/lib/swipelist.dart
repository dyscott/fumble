import 'package:flutter/material.dart';
import 'package:fumble/auth.dart';
import 'package:swiping_card_deck/swiping_card_deck.dart';
import 'card.dart';

class SwipeList extends StatelessWidget {
  const SwipeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ExpandableBioCard> cards = [
      const ExpandableBioCard(
        avatarUrl: 'https://media.discordapp.net/attachments/1181082647833890876/1202646104345284648/cowgan.png?ex=65d770f7&is=65c4fbf7&hm=c923634fe9f009750a1b65cef2588b8a0321b1511d00da2a0af949ace819b999&format=webp&quality=lossless&width=1536&height=1024&',
        name: 'Cowgan',
        bio: 'Moo Moo Moo Moo. Need grass. PhD Student researching cowputational geometry, lmk if you are in CSE 599.',
        id: "mju72zm5bsn9mz5",
      ),
    ];

    final swipingCardDeck = SwipingDeck<ExpandableBioCard>(
      cardDeck: cards,
      onDeckEmpty: () => debugPrint("Card deck empty"),
      onLeftSwipe: (card) {
        // Handle left swipe (reject)
        updateDatabase(card, false);
        debugPrint("Swiped left!");
      },
      onRightSwipe: (card) {
        // Handle right swipe (like)
        updateDatabase(card, true);
        debugPrint("Swiped right!");
      },
      swipeThreshold: MediaQuery.of(context).size.width / 4,
      minimumVelocity: 10000,
      cardWidth: 375,
      rotationFactor: 0.25 / 3.14,
      swipeAnimationDuration: const Duration(milliseconds: 100),
      disableDragging: false,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: swipingCardDeck,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Left-aligned button
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        swipingCardDeck.swipeLeft();
                      },
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16.0), // Add space between buttons
                  // Right-aligned button
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: () {
                        swipingCardDeck.swipeRight();
                      },
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateDatabase(ExpandableBioCard card, bool liked) async {
    try {
      // Get user ID and target ID from the card
      final String userID = pb.authStore.model.id;
      final String targetID = card.id;

      // Update the database with match/reject status
      final body = <String, dynamic>{
        "author": userID,
        "target": targetID,
        "status": liked ? "like" : "reject"
      };
      await pb.collection('matches').create(body: body);
    } catch (e) {
      // ignore: avoid_print
      print('Error updating database: $e');
    }
  }
}
