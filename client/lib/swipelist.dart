import 'package:flutter/material.dart';
import 'package:swiping_card_deck/swiping_card_deck.dart';

class SwipeList extends StatelessWidget {
  const SwipeList({Key? key}) : super(key: key);

  List<Card> getCards() {
    return [
      Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
    
            Image.asset(
              'assets/images/gretta-fumble.png',
              height: 500,
              width: 200,
              fit: BoxFit.cover,
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: const Text(
                'Gretta',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              color: Colors.purple,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bio',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Some bio text here...',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              color: Colors.purple,
              child: Text(
                'Bro',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Image.asset(
              'assets/images/giraffe.jpg',
              height: 400,
              width: 200,
              fit: BoxFit.cover,
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              color: Colors.purple,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bio',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Some bio text here...',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final List<Card> multipliedCards =
        getCards().expand((card) => List.generate(1, (_) => card)).toList();

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
