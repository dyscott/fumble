import 'package:flutter/material.dart';
import 'package:fumble/common.dart';
import 'package:fumble/temphome.dart';

class CreateProfilePage5 extends StatefulWidget {
  final CreateProfileModel model;

  const CreateProfilePage5({super.key, required this.model});

  @override
  State<CreateProfilePage5> createState() => _CreateProfilePage5State();
}

class _CreateProfilePage5State extends State<CreateProfilePage5> {
  var agreed = false;

  void onGo() async {
    final nav = Navigator.of(context);

    await widget.model.uploadProfile();

    nav.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const TempHome()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TopBackButton(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'All set?',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: onGo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                    child: Text(
                      'Get Started!',
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
