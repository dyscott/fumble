import 'package:flutter/material.dart';
import 'messagelist.dart'; // Import your chat page component here
import 'swipelist.dart'; // Import your SwipeList component here
import 'profilepage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const SwipeList(),
    const ProfilePage(
      avatarUrl:
          'https://cdn.discordapp.com/attachments/1181082647833890876/1205963843701047427/FA7223D0-AED6-4532-89FD-B340D7DC2C7E_1_105_c.jpeg?ex=65da485a&is=65c7d35a&hm=0479f565398735a3f5fe87deaa20e876fd297c3703919cacc22b4e68bd62fa36&',
      name: 'Daniel',
      bio: 'CSE/AMS double major who took comp geo + graph theory for fun. 5.0 GPA.',
    ),
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
        borderRadius: BorderRadius.circular(
            40), // Set a high circular radius for all corners
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
