import 'package:flutter/material.dart';

class PreferenceForm extends StatefulWidget {
  @override
  _PreferenceFormState createState() => _PreferenceFormState();
}

class _PreferenceFormState extends State<PreferenceForm> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Padding(
                padding: EdgeInsets.all(16.0), // Added padding to the text
                child: Text(
                  'What are you looking for?',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: RadioListTile<String>(
                title: const Text(
                  'CSE 316',
                  style: TextStyle(fontSize: 18.0),
                ),
                value: 'CSE316',
                groupValue: _selectedOption,
                onChanged: (String? value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: RadioListTile<String>(
                title: const Text(
                  'CSE 373',
                  style: TextStyle(fontSize: 18.0),
                ),
                value: 'CSE373',
                groupValue: _selectedOption,
                onChanged: (String? value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: RadioListTile<String>(
                title: const Text(
                  'CSE 304',
                  style: TextStyle(fontSize: 18.0),
                ),
                value: 'CSE304',
                groupValue: _selectedOption,
                onChanged: (String? value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
              ),
            ),
            RadioListTile<String>(
              title: const Text(
                'CSE 416',
                style: TextStyle(fontSize: 18.0),
              ),
              value: 'CSE416',
              groupValue: _selectedOption,
              onChanged: (String? value) {
                setState(() {
                  _selectedOption = value;
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to the next screen or perform any desired action
        },
        label: const Text('Next', style: TextStyle(color: Colors.white)),
        icon: const Icon(Icons.arrow_forward, color: Colors.white),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}