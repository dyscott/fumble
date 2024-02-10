import 'package:flutter/material.dart';

class CardPage extends StatefulWidget {
  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {

List<Card> getCards() {
  return [
    Card(
      color: Colors.purple,
      child: Image.asset(
        'assets/images/gretta-fumble.png',
        height: 800,
        width: 400,
        fit: BoxFit.cover,
      ),
    ),
    Card(
      color: Colors.purple,
      child: Image.asset(
        'assets/images/giraffe.jpg',
        height: 800,
        width: 400,
        fit: BoxFit.cover,
      ),
    ),
  ];
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fumble'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Image at the top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/gretta-fumble.png', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          // Text at the top
          Positioned(
            top: 16.0,
            left: 16.0,
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Text(
                'Gretta',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Bio section
          Positioned(
            bottom: 120.0, // Adjust the position as needed
            left: 16.0,
            right: 16.0,
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7), // Adjust opacity as needed
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bio',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Looking for CSE 416 partner. Must have A in 316.',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Buttons at the bottom
          Positioned(
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
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
    );
  }
}
