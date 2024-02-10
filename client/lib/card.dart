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
        title: Text('Fumble'),
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'regrett.able',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Text color
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'CSE 416',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Text color
                  ),
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: 40.0), // Add more space between text and button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle the action when the button is pressed
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                      child: Text(
                        'X',
                        style: TextStyle(
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple, // Background color of button
                      foregroundColor: Colors.white, // Text color of button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
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
