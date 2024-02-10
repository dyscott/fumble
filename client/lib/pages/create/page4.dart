import 'package:flutter/material.dart';
import 'package:fumble/pages/create/common.dart';

class CreateProfilePage4 extends StatefulWidget {
  const CreateProfilePage4({super.key});

  @override
  State<CreateProfilePage4> createState() => _CreateProfilePage4State();
}

class _CreateProfilePage4State extends State<CreateProfilePage4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TopBackButton(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'All Set?',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                  height: 40.0), // Add more space between text and button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle the action when the Next button is pressed
                    // For example, you can navigate to the next page
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.purple, // background color of button
                    foregroundColor: Colors.white, // text color of button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                    child: Text(
                      'Go!',
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
