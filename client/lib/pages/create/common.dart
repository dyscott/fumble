import 'dart:io';

import 'package:flutter/material.dart';

class Profile {
  File? image;
  String? name;

  Profile({this.name});
}

class NextButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NextButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      label: const Text('Next', style: TextStyle(color: Colors.white)),
      icon: const Icon(Icons.arrow_forward, color: Colors.white),
      backgroundColor: Colors.purple,
    );
  }
}
