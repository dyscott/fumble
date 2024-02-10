import 'package:flutter/material.dart';
import 'messagelist.dart'; // Import your chat page component here
import 'swipelist.dart'; // Import your SwipeList component here

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const SwipeList(),
    const Text('Profile Page'),
    ChatPage(), // Replace Text widget with your ChatPage component
  ];

  static final List<String> _appBarTitles = <String>[
    'Home',
    'Profile',
    'Chat',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_selectedIndex]),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(40), // Set a high circular radius for all corners
        child: Container(
          color: Colors.grey.shade200, // Set a slightly darker background color
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: 'Chat',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.purple,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
