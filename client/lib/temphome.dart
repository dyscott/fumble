import 'package:flutter/material.dart';

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
            ],
          ),
        ),
      ),
    );
  }
}
