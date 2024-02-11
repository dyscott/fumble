import 'package:flutter/material.dart';
import 'package:fumble/auth.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:swiping_card_deck/swiping_card_deck.dart';
import 'card.dart';
import 'home.dart';

class CardUser {
  final String name;
  final String avatarUrl;
  final String bio;
  final String id;

  CardUser(
      {required this.name,
      required this.avatarUrl,
      required this.bio,
      required this.id});
}

class SwipeList extends StatelessWidget {
  const SwipeList({Key? key}) : super(key: key);

  // Query wingman to get possible matches
  Future<List<CardUser>> getPossibleMatches() async {
    var res = await pb.send('api/fumble/wingman');

    List<RecordModel> list = [];
    for (var i in res) {
      list.add(RecordModel.fromJson(i));
    }
    List<CardUser> users = [];
    for (var i in list) {
      final url = pb.files.getUrl(i, i.data['gallery'][0]).toString();
      users.add(
        CardUser(
            name: i.getStringValue('name'),
            avatarUrl: url,
            bio: removeAllHtmlTags(i.getStringValue('bio')),
            id: i.id),
      );
    }
    return users;
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
      debugPrint('Error updating database: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPossibleMatches(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<CardUser> users = snapshot.data as List<CardUser>;
          final cards = users.map((user) {
            return ExpandableBioCard(
              avatarUrl: user.avatarUrl,
              name: user.name,
              bio: user.bio,
              id: user.id,
            );
          }).toList();
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(children: [
                  swipingCardDeck,
                  // Show a message when the card deck is empty
                  if (swipingCardDeck.cardDeck.isEmpty)
                    const Center(
                      child: Text(
                        "You're out of matches... check back later!",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              )),
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
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
