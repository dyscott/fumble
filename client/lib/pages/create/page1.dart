import 'package:flutter/material.dart';

class CreateProfilePage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Create Profile Page 1'),
            ElevatedButton(
              child: Text('Next'),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => CreateProfilePage2()),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}