import 'package:flutter/material.dart';

import '../../components/nav.dart';
import '../../models/create.dart';
import 'page3.dart';

class CreateProfilePage2 extends StatefulWidget {
  final CreateProfileModel model;

  const CreateProfilePage2({super.key, required this.model});

  @override
  State<CreateProfilePage2> createState() => _CreateProfilePage2State();
}

class _CreateProfilePage2State extends State<CreateProfilePage2> {
  final List<List<String>> options = [
    ['CSE 316', 'cse316'],
    ['CSE 416', 'cse416'],
    ['CSE 373', 'cse373']
  ];

  @override
  Widget build(BuildContext context) {
    var model = widget.model;

    return Scaffold(
      body: TopBackButton(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'What are you looking for?',
              style: TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Select the course you need a partner for',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 20.0),
            ...options
                .map(
                  (List<String> option) => RadioListTile<String>(
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                    title: Text(
                      option[0],
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    value: option[1],
                    groupValue: widget.model.course,
                    onChanged: (String? value) {
                      setState(() {
                        widget.model.course = value!;
                      });
                    },
                  ),
                )
                .toList(),
          ],
        ),
      ),
      floatingActionButton: (model.course == null)
          ? null
          : NextButton(onPressed: () {
              // Navigate to the next page
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateProfilePage3(model: model)),
              );
            }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
