import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fumble/auth.dart';
import 'package:pocketbase/pocketbase.dart';

import 'common.dart';

class TempHome extends StatelessWidget {
  const TempHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TopBackButton(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Thank you for signing up for Fumble!',
                  style: TextStyle(fontSize: 20.0)),
              SizedBox(height: 20),
              Text('Our beta will be launching soon,'),
              Text('we will notify you when it is ready!'),
              DisplayUser(userId: 'racoon'),
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
