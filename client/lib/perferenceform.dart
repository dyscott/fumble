import 'package:flutter/material.dart';

class SelectOptions extends StatefulWidget {
  @override
  _SelectOptionsState createState() => _SelectOptionsState();
}

class _SelectOptionsState extends State<SelectOptions> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Options'),
      ),
      body: Center(
        child: DropdownButton<String>(
          hint: Text('Select an option'),
          value: _selectedOption,
          onChanged: (String? newValue) {
            setState(() {
              _selectedOption = newValue!;
            });
          },
          items: <String>['Option 1', 'Option 2', 'Option 3']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}