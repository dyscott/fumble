import 'package:flutter/material.dart';

class CardPage extends StatefulWidget {
  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fumble'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Add your image widget here
          Image.asset(
            'assets/images/gretta-fumble.png', // Replace 'assets/background_image.jpg' with your image path
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end, // Align content to the bottom
              children: [
                const Text(
                  'Gretta',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Text color
                  ),
                ),
                SizedBox(height: 40.0), // Add more space between text and buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align buttons to the ends
                  children: [
                    // Add left-aligned button
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        // Handle the action when the left button is pressed
                      },
                       backgroundColor: Colors.deepOrange,
                      color: Colors.white, // Icon color,
                    ),
                    // Add right-aligned button
                    IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () {
                        // Handle the action when the right button is pressed
                      },
                      color: Colors.white, // Icon color
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
