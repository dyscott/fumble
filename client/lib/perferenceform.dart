import 'package:flutter/material.dart';

class ChatUser {
  final String name;
  final String avatarUrl;

  ChatUser({required this.name, required this.avatarUrl});
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatUser> _chatUsers = []; // List of chat users, initially empty

  @override
  void initState() {
    super.initState();
    // Simulate API call to fetch chat users
    _fetchChatUsers();
  }

  void _fetchChatUsers() {
    // Simulated data for chat users
    List<ChatUser> users = [
      ChatUser(name: 'Person 1', avatarUrl: 'https://cdn.discordapp.com/avatars/476863335275429889/900e0140b19a58e4dc2dd4e3aa13380e.png?size=1024'),
      ChatUser(name: 'Person 2', avatarUrl: 'https://cdn.discordapp.com/attachments/1202636557958385737/1202640940792160329/danil.png?ex=65d76c28&is=65c4f728&hm=29d88707e8ad2f9a60cad906ff2f0a2662477c88fb40893d1ee2dbbcda5f883e&'),
      ChatUser(name: 'Person 3', avatarUrl: 'https://cdn.discordapp.com/attachments/1202636557958385737/1202640941169770506/gretel.png?ex=65d76c28&is=65c4f728&hm=f8b18afe0508d54f224c7ed0926a9008ebdca47bd5982f508f29a6982f8f2664&'),
      ChatUser(name: 'Person 4', avatarUrl: 'https://cdn.discordapp.com/attachments/1202636557958385737/1202637148906459196/rectangular-cows.png?ex=65d768a0&is=65c4f3a0&hm=d54705a7ccb386a232eccbd1bf97a19e8f3a52a59b4e1ec5b1a49e5df49d54b8&'),
      ChatUser(name: 'Person 5', avatarUrl: 'https://cdn.discordapp.com/attachments/1022545971432915035/1205733524989288468/0kVdiTtcqMtzxhqTM.png?ex=65d971d9&is=65c6fcd9&hm=b734d03391b18b5616c7b6148b34353379ece7a884a9d9de08326e22aee00afc&'),
    ];
    setState(() {
      _chatUsers = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Chats',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _chatUsers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(_chatUsers[index].avatarUrl),
                    ),
                    title: Text(_chatUsers[index].name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(person: _chatUsers[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  final ChatUser person;

  const ChatScreen({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(person.name),
      ),
      body: Center(
        child: Text(
          'Chat with ${person.name}',
          style: const TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
