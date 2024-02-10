import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:provider/provider.dart';

import 'auth.dart';

void main() async {
  // Load shared preferences and initialize PocketBase

  runApp(ChangeNotifierProvider(
    create: (context) => AuthProvider(),
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final loading = Provider.of<AuthProvider>(context).loading;

    return MaterialApp(
        home: loading
            ? const Scaffold(body: Center(child: CircularProgressIndicator()))
            : const Home());
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final isAuth = Provider.of<AuthProvider>(context).isAuthenticated;
    final userId = pb.authStore.model?.id;
    final signOut = Provider.of<AuthProvider>(context).signOut;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Hello World!'),
            Text('Are you signed in? $isAuth'),
            ElevatedButton(
                onPressed: () => {
                      // Navigate to the Auth screen
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Auth()))
                    },
                child: const Text('Sign In / Register')),
            ElevatedButton(onPressed: signOut, child: const Text('Sign Out')),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: isAuth
                  ? DisplayUser(userId: userId!)
                  : const Text('Not signed in'),
            ),
          ],
        ),
      ),
    );
  }
}

class DisplayUser extends StatelessWidget {
  final String userId;
  const DisplayUser({required this.userId, super.key});

  Future<RecordModel> getUser() {
    return pb.collection('users').getOne(userId);
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RecordModel>(
      future: getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Text('User: ${snapshot.data!.data['username']}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
