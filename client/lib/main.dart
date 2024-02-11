import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fumble/temphome.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:provider/provider.dart';
import 'auth.dart';
import 'common.dart';
import 'pages/create/page1.dart';
import 'pages/signin.dart';
import 'pages/signup.dart';
import 'package:fumble/home.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AuthProvider(),
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    var loading = Provider.of<AuthProvider>(context).loading;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // title: 'Fumble',
        home: HomePage(),
        // home: loading
        //     ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        //     : const Landing());
    );
  }
}

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
                  Text('Not a dating app',
                      style: TextStyle(
                          fontSize: 20, color: Colors.yellowAccent[100]))
                ]),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: isAuth ? const Go() : const SignIn(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return IntrinsicWidth(
      child: Column(
        children: [
          (!kIsWeb)
              ? DiscordSignInButton(
                  onPressed: () {
                    // Sign in
                    auth.signInDiscord();
                  },
                )
              : const SizedBox(),
          const SizedBox(height: 20),
          SizedBox(
            width: 250,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.yellow[100],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInPage()),
                );
              },
              child: const Text('Sign in with Email'),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 250,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.yellow[100],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                );
              },
              child: const Text('Sign up with Email'),
            ),
          ),
        ],
      ),
    );
  }
}

class Go extends StatefulWidget {
  const Go({super.key});

  @override
  State<Go> createState() => _GoState();
}

class _GoState extends State<Go> {
  @override
  void initState() {
    super.initState();
    final auth = Provider.of<AuthProvider>(context, listen: false);
    auth.syncUser();
  }

  void go(BuildContext context, RecordModel user) {
    if (user.data['profileComplete'] == true) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TempHome()),
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
        SizedBox(
            width: 150,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.yellow[100],
              ),
              onPressed: (auth.user == null)
                  ? null
                  : () {
                      go(context, auth.user!);
                    },
              child: const Text('Go'),
            )),
        const SizedBox(height: 20),
        SizedBox(
          width: 150,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.yellow[100],
            ),
            onPressed: () {
              auth.signOut();
            },
            child: const Text('Sign Out'),
          ),
        ),
      ],
    );
  }
}

// class DisplayUser extends StatelessWidget {
//   final String userId;
//   const DisplayUser({required this.userId, super.key});

//   Future<RecordModel> getUser() {
//     return pb.collection('users').getOne(userId);
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<RecordModel>(
//       future: getUser(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           return Text('User: ${snapshot.data?.data['username']}');
//         } else {
//           return const CircularProgressIndicator();
//         }
//       },
//     );
//   }
// }