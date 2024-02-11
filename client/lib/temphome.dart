import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fumble/auth.dart';
import 'package:pocketbase/pocketbase.dart';

import 'common.dart';
import 'messagelist.dart';

class TempHome extends StatelessWidget {
  const TempHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TopBackButton(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Thank you for signing up for Fumble!',
                  style: TextStyle(fontSize: 20.0)),
              const SizedBox(height: 20),
              const Text('Our beta will be launching soon,'),
              const Text('we will notify you when it is ready!'),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChatPage()),
                  );
                },
                child: const Text('Messages'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DisplayUser extends StatelessWidget {
  final String userId;
  const DisplayUser({required this.userId, super.key});

  Future<List<RecordModel>> getUser() async {
    print('running');
    var res = await pb.send('api/fumble/racoon');

    print(res);

    List<RecordModel> list = [];
    for (var i in res) {
      list.add(RecordModel.fromJson(i));
    }

    return list;
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RecordModel>>(
      future: getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Text('User: ${snapshot.data}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
