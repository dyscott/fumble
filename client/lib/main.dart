import 'package:flutter/material.dart';
// import 'bioform.dart';
import 'confirm.dart';

void main() {
  runApp(MaterialApp(
    home: ConfirmPage(),
  ));
}


// import 'package:flutter/material.dart';
// //import 'package:pocketbase/pocketbase.dart';
// import 'package:provider/provider.dart';

// import 'auth.dart';
// import 'pages/create/page1.dart';
// import 'bioform.dart';




// void main() async {
//   // Load shared preferences and initialize PocketBase

//   runApp(ChangeNotifierProvider(
//     create: (context) => AuthProvider(),
//     child: const MainApp(),
//   ));
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final loading = Provider.of<AuthProvider>(context).loading;

//     return MaterialApp(

//         home: loading
//             ? const Scaffold(body: Center(child: CircularProgressIndicator()))
//             : const Home());
//   }
// }

// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final isAuth = Provider.of<AuthProvider>(context).isAuthenticated;

//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text('Fumble'),
//             const SizedBox(height: 20),
//             Container(
//               margin: const EdgeInsets.only(top: 20),
//               child: isAuth ? const Go() : const SignIn(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SignIn extends StatelessWidget {
//   const SignIn({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final auth = Provider.of<AuthProvider>(context);
//     return ElevatedButton(
//         onPressed: () {
//           // Sign in
//           auth.signIn();
//         },
//         child: const Text('Sign In / Register'));
//   }
// }

// class Go extends StatelessWidget {
//   const Go({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final auth = Provider.of<AuthProvider>(context);
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         ElevatedButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => CreateProfilePage1()),
//             );
//           },
//           child: const Text('Go'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             auth.signOut();
//           },
//           child: const Text('Sign Out'),
//         ),
//       ],
//     );
//   }
// }

// // class DisplayUser extends StatelessWidget {
// //   final String userId;
// //   const DisplayUser({required this.userId, super.key});

// //   Future<RecordModel> getUser() {
// //     return pb.collection('users').getOne(userId);
// //   }
  
// //   @override
// //   Widget build(BuildContext context) {
// //     return FutureBuilder<RecordModel>(
// //       future: getUser(),
// //       builder: (context, snapshot) {
// //         if (snapshot.connectionState == ConnectionState.done) {
// //           return Text('User: ${snapshot.data?.data['username']}');
// //         } else {
// //           return const CircularProgressIndicator();
// //         }
// //       },
// //     );
// //   }
// // }
