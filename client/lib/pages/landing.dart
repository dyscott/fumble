import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:provider/provider.dart';

import '../util/auth.dart';
import '../components/discord.dart';
import '../models/create.dart';
import 'auth/signin.dart';
import 'auth/signup.dart';
import 'create/page1.dart';
import 'home.dart';

// Standardized button for the landing page
class LandingButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const LandingButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.yellow[100],
          ),
          onPressed: onPressed,
          child: Text(text)),
    );
  }
}

// The landing page
class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    final isAuth = Provider.of<AuthProvider>(context).isAuthenticated;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/giraffe.jpg', fit: BoxFit.cover),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
            child: Container(
              color: Colors.black.withOpacity(0.25),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(children: [
                  Text('Fumble',
                      style: TextStyle(
                          fontSize: 60,
                          color: Colors.yellow[600],
                          fontWeight: FontWeight.bold)),
                  Text('Find your next project partner',
                      style: TextStyle(
                          fontSize: 20, color: Colors.yellowAccent[100]))
                ]),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: isAuth ? const LoggedIn() : const LoggedOut(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Buttons for the landing page when the user is not authenticated
class LoggedOut extends StatelessWidget {
  const LoggedOut({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return IntrinsicWidth(
      child: Column(
        children: [
          DiscordSignInButton(
            onPressed: () {
              // Sign in
              auth.signInDiscord();
            },
          ),
          const SizedBox(height: 20),
          LandingButton(
            text: 'Sign in with Email',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignInPage()),
              );
            },
          ),
          const SizedBox(height: 20),
          LandingButton(
            text: 'Register with Email',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUpPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Buttons for the landing page when the user is authenticated
class LoggedIn extends StatefulWidget {
  const LoggedIn({super.key});

  @override
  State<LoggedIn> createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {
  @override
  void initState() {
    super.initState();
    final auth = Provider.of<AuthProvider>(context, listen: false);
    auth.syncUser();
  }

  // Navigate to the home page if the user has completed their profile
  // Otherwise, navigate to the profile creation page
  void onGo(BuildContext context, RecordModel user) {
    if (user.data['profileComplete'] == true) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      final model = CreateProfileModel(userId: user.id);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreateProfilePage1(model: model)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LandingButton(
          onPressed: (auth.user == null)
              ? null
              : () {
                  onGo(context, auth.user!);
                },
          text: 'Go to Fumble',
        ),
        const SizedBox(height: 20),
        LandingButton(
          onPressed: () {
            auth.signOut();
          },
          text: 'Sign Out',
        ),
      ],
    );
  }
}
