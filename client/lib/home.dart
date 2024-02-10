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
          'https://media.discordapp.net/attachments/1181082647833890876/1202646104345284648/cowgan.png?ex=65d770f7&is=65c4fbf7&hm=c923634fe9f009750a1b65cef2588b8a0321b1511d00da2a0af949ace819b999&format=webp&quality=lossless&width=1536&height=1024&',
      name: 'Daniel',
      bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
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
