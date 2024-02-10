import 'package:flutter/material.dart';
import 'package:swiping_card_deck/swiping_card_deck.dart';
import 'card.dart';

class SwipeList extends StatelessWidget {
  const SwipeList({Key? key}) : super(key: key);

  List<ExpandableBioCard> getCards() {
    return [
      const ExpandableBioCard(
        avatarUrl: 'https://media.discordapp.net/attachments/1181082647833890876/1202646104345284648/cowgan.png?ex=65d770f7&is=65c4fbf7&hm=c923634fe9f009750a1b65cef2588b8a0321b1511d00da2a0af949ace819b999&format=webp&quality=lossless&width=1536&height=1024&',
        name: 'Daniel I',
        bio: 'CSE/AMS double major who took comp geo + graph theory for fun. 5.0 GPA.',
      ),
    ];
  }
  
  @override
  Widget build(BuildContext context) {
    
    final List<Card> multipliedCards =
        getCards().expand((card) => List.generate(1, (_) => Card(child: card))).toList();

    final swipingCardDeck = SwipingDeck<Card>(
      cardDeck: multipliedCards,
      onDeckEmpty: () => debugPrint("Card deck empty"),
      onLeftSwipe: (Card card) => debugPrint("Swiped left!"),
      onRightSwipe: (Card card) => debugPrint("Swiped right!"),
      swipeThreshold: MediaQuery.of(context).size.width / 4,
      minimumVelocity: 10000,
      cardWidth: 375,
      rotationFactor: 0.25 / 3.14,
      swipeAnimationDuration: const Duration(milliseconds: 100),
      disableDragging: false,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false, // Set to false to remove debug banner
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
                      icon: Icon(Icons.close),
                      onPressed: () {
                        swipingCardDeck.swipeLeft();
                      },
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 16.0), // Add space between buttons
                  // Right-aligned button
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.check),
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
}
