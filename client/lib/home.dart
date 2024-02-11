import 'package:flutter/material.dart';
import 'package:fumble/auth.dart';
import 'package:pocketbase/pocketbase.dart';
import 'messagelist.dart'; // Import your chat page component here
import 'swipelist.dart'; // Import your SwipeList component here
import 'profilepage.dart';

   String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(
      r"<[^>]*>",
      multiLine: true,
      caseSensitive: true
    );

    return htmlText.replaceAll(exp, '');
  }
class HomePage extends StatefulWidget {

  
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
  int _selectedIndex = 0;

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
            selectedItemColor: const Color.fromRGBO(156, 39, 176, 1),
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }

  final List<Widget> _widgetOptions = <Widget>[
    const SwipeList(),
    FutureBuilder<RecordModel>(
      future: getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          final recordModel = snapshot.data!;
         final url = pb.files.getUrl(recordModel, recordModel.data['avatar']).toString(); 
          String bio = removeAllHtmlTags(recordModel.data['bio']);
          return ProfilePage(
            avatarUrl: url,
            name: recordModel.data['name'] ?? 'Unknown',
            bio: bio,
            id: recordModel.data['id'] ?? 'No ID',
          );
        } else {
          return const Center(
            child: Text('No data available'),
          );
        }
      },
    ),
    const ChatPage(),
  ];

  static Future<RecordModel> getUser() {
    final String userID = pb.authStore.model.id;
    return pb.collection('users').getOne(userID);
  }
}
