import 'package:flutter/material.dart';
import 'package:fumble/common.dart';

import 'page5.dart';

class CreateProfilePage4 extends StatefulWidget {
  final CreateProfileModel model;

  const CreateProfilePage4({super.key, required this.model});

  @override
  State<CreateProfilePage4> createState() => _CreateProfilePage4State();
}

class _CreateProfilePage4State extends State<CreateProfilePage4> {
  List<List<dynamic>> boxes = [
    [
      'I attest that Fumble is not a dating app.',
      false,
    ],
    [
      'I agree to not use Fumble to find a romantic partner.',
      false,
    ],
    [
      'I agree to not use Fumble for any other non-academic purposes.',
      false,
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TopBackButton(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Terms and Conditions',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text(
                  'Please agree to the following:',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(height: 20),
                ...boxes
                    .map(
                      (List<dynamic> box) => CheckboxListTile(
                        title: Text(
                          box[0],
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        value: box[1],
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (bool? value) {
                          setState(() {
                            box[1] = value!;
                          });
                        },
                      ),
                    )
                    .toList(),
              ]),
              const SizedBox(height: 0),
            ],
          ),
        ),
      ),
      floatingActionButton: (boxes.every((box) => box[1] == true))
          ? NextButton(onPressed: () {
              // Navigate to the next page
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateProfilePage5(model: widget.model)),
              );
            })
          : null,
    );
  }
}
