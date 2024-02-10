import 'package:flutter/material.dart';

class AddBioPage extends StatefulWidget {
  @override
  _AddBioPageState createState() => _AddBioPageState();
}

class _AddBioPageState extends State<AddBioPage> {
  // Variable to store the bio string
  String bio = '';

  // Define a focus node for the text field
  final FocusNode _textFieldFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Unfocus the text field when the page loads
    _textFieldFocusNode.unfocus();
  }

  @override
  void dispose() {
    // Dispose of the focus node when the widget is disposed
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fumble'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Bio',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Tell us about yourself.',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              focusNode: _textFieldFocusNode, // Assign the focus node
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Enter your bio here...',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                // Update the bio variable when the text changes
                setState(() {
                  bio = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${bio.length}/300 characters',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                FloatingActionButton.extended(
                  onPressed: () {
                    // Handle the action when the Next button is pressed
                    // For example, you can navigate to the next page
                  },
                  label: Text('Next'),
                  icon: Icon(Icons.arrow_forward),
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
