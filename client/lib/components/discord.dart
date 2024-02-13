import 'package:flutter/material.dart';

// Styled button for signing in with Discord
class DiscordSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DiscordSignInButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF5865F2), // Discord's primary color
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/discord-logo.png', // Replace with your Discord logo image asset
            height: 24.0,
          ),
          const SizedBox(width: 10.0),
          const Text(
            'Sign in with Discord',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}