import 'package:flutter/material.dart';

class ConfirmPage extends StatefulWidget {
  @override
  _ConfirmPageState createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fumble'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'All Set?',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40.0), // Add more space between text and button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle the action when the Next button is pressed
                  // For example, you can navigate to the next page
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0), // Increase padding
                  child: Text(
                    'Go',
                    style: TextStyle(
                      fontSize: 28.0, // Increase font size
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, // background color of button
                  foregroundColor: Colors.white, // text color of button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
