import 'package:flutter/material.dart';
import 'package:swiping_card_deck/swiping_card_deck.dart';
import 'card.dart';

class SwipeList extends StatelessWidget {
  const SwipeList({Key? key}) : super(key: key);

  List<ExpandableBioCard> getCards() {
    return [
      ExpandableBioCard(
        avatarUrl: 'https://media.discordapp.net/attachments/1181082647833890876/1202646104345284648/cowgan.png?ex=65d770f7&is=65c4fbf7&hm=c923634fe9f009750a1b65cef2588b8a0321b1511d00da2a0af949ace819b999&format=webp&quality=lossless&width=1536&height=1024&',
        name: 'Gretta',
        bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      ),
    ];
  }
  
  @override
  Widget build(BuildContext context) {
    final List<Card> multipliedCards =
        getCards().expand((card) => List.generate(1, (_) => Card(child: card))).toList();

    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SwipingCardDeck(
                      cardDeck: multipliedCards,
                      onDeckEmpty: () => debugPrint("Card deck empty"),
                      onLeftSwipe: (Card card) => debugPrint("Swiped left!"),
                      onRightSwipe: (Card card) => debugPrint("Swiped right!"),
                      swipeThreshold: MediaQuery.of(context).size.width / 4,
                      minimumVelocity: 10000,
                      cardWidth: 400,
                      rotationFactor: 0.25 / 3.14,
                      swipeAnimationDuration: const Duration(milliseconds: 400),
                      disableDragging: false,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 12.0,
              right: 12.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        // Handle the action when the left button is pressed
                      },
                      color: Colors.white,
                    ),
                  ),
                  // Right-aligned button
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () {
                        // Handle the action when the right button is pressed
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
