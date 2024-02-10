import 'package:flutter/material.dart';

import 'common.dart';

class CreateProfilePage2 extends StatefulWidget {
  const CreateProfilePage2({super.key});

  @override
  State<CreateProfilePage2> createState() => _CreateProfilePage2State();
}

class _CreateProfilePage2State extends State<CreateProfilePage2> {
  String? _selectedOption;

  final List<String> options = [
    'CSE 316',
    'CSE 373',
    'CSE 304',
    'CSE 416',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(
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
            ...options
                .map(
                  (String option) => Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: RadioListTile<String>(
                      title: Text(
                        option,
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      value: option,
                      groupValue: _selectedOption,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedOption = value;
                        });
                      },
                    ),
                  ),
                )
                .toList(),
          ],
        ),
      ),
      floatingActionButton: NextButton(onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
