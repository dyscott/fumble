import 'package:flutter/material.dart';

import 'common.dart';
import 'page4.dart';

class CreateProfilePage3 extends StatefulWidget {
  const CreateProfilePage3({super.key});

  @override
  State<CreateProfilePage3> createState() => _CreateProfilePage3State();
}

class _CreateProfilePage3State extends State<CreateProfilePage3> {
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
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            const BackButton(),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Add Bio',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Tell us about yourself.',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextField(
                      focusNode: _textFieldFocusNode, // Assign the focus node
                      maxLines: 5,
                      decoration: const InputDecoration(
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
                    const SizedBox(height: 8.0),
                    Text(
                      '${bio.length}/300 characters',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: NextButton(onPressed: () {
        // Navigate to the next page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreateProfilePage4()),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
