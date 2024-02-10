import 'package:swiping_card_deck/swiping_card_deck.dart';
import 'package:flutter/material.dart';

// Define a custom Form widget.

class SwipeList extends StatelessWidget {
  const SwipeList({super.key});


  static const cards = <Card>[
    Card(
      color: Colors.red,
      child: const SizedBox(
        height: 800,
        width: 400,
      ),
    ),
    Card(
      color: Colors.green,
      child: const SizedBox(
        height: 800,
        width: 400,
      ),
    ),
  ];

  static final multipliedCards = cards.expand((card) => List.generate(20, (_) => card)).toList();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
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
      ),
    );
  }
}