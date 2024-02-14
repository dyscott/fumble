import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'util/auth.dart';
import 'pages/landing.dart';

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
        title: 'Fumble',
        // home: HomePage()
        home: loading
            ? const Scaffold(body: Center(child: CircularProgressIndicator()))
            : const Landing());
  }
}