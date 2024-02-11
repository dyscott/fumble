import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

import 'auth.dart';

class ChatUser {
  final String name;
  final String avatarUrl;

  ChatUser({required this.name, required this.avatarUrl});
}

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  Future<List<ChatUser>> getMatchedUsers() async {
    var res = await pb.send('api/fumble/racoon');

    List<RecordModel> list = [];
    for (var i in res) {
      list.add(RecordModel.fromJson(i));
    }
    List<ChatUser> users = [];
    for (var i in list) {
      final url = pb.files.getUrl(i, i.getStringValue('avatar')).toString();
      users.add(ChatUser(
          name: i.getStringValue('name'), avatarUrl: url));
    }

    return users;
  }
  // void _fetchChatUsers() {
  //   // Simulated data for chat users
  //   List<ChatUser> users = [
  //     ChatUser(name: 'Cowgan', avatarUrl: 'https://media.discordapp.net/attachments/1181082647833890876/1202646104345284648/cowgan.png?ex=65d770f7&is=65c4fbf7&hm=c923634fe9f009750a1b65cef2588b8a0321b1511d00da2a0af949ace819b999&=&format=webp&quality=lossless&width=1536&height=1024'),
  //     ChatUser(name: 'Maccabee', avatarUrl: 'https://cdn.discordapp.com/attachments/1202636557958385737/1202640940792160329/danil.png?ex=65d76c28&is=65c4f728&hm=29d88707e8ad2f9a60cad906ff2f0a2662477c88fb40893d1ee2dbbcda5f883e&'),
  //     ChatUser(name: 'Gretta', avatarUrl: 'https://cdn.discordapp.com/attachments/1202636557958385737/1202640941169770506/gretel.png?ex=65d76c28&is=65c4f728&hm=f8b18afe0508d54f224c7ed0926a9008ebdca47bd5982f508f29a6982f8f2664&'),
  //     ChatUser(name: 'Dylan', avatarUrl: 'https://cdn.discordapp.com/attachments/1202636557958385737/1202637148906459196/rectangular-cows.png?ex=65d768a0&is=65c4f3a0&hm=d54705a7ccb386a232eccbd1bf97a19e8f3a52a59b4e1ec5b1a49e5df49d54b8&'),
  //     ChatUser(name: 'Mehadi', avatarUrl: 'https://cdn.discordapp.com/attachments/1022545971432915035/1205733524989288468/0kVdiTtcqMtzxhqTM.png?ex=65d971d9&is=65c6fcd9&hm=b734d03391b18b5616c7b6148b34353379ece7a884a9d9de08326e22aee00afc&'),
  //   ];
  //   setState(() {
  //     _chatUsers = users;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getMatchedUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<ChatUser> users = snapshot.data as List<ChatUser>;
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(users[index].avatarUrl),
                          ),
                          title: Text(users[index].name),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ChatScreen(person: users[index]),
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
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class ChatScreen extends StatefulWidget {
  final ChatUser person;

  const ChatScreen({Key? key, required this.person}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  List<Map<String, String>> chatHistory = [
    {'message': 'Hello!', 'sender': 'other'},
    {'message': 'Hi, how are you?', 'sender': 'me'},
    {'message': 'I\'m good, thanks!', 'sender': 'other'},
  ];

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.person.name),
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            // const SizedBox(width: 12), // Add some padding between the back arrow and the avatar
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(widget.person.avatarUrl),
            ),
            // const SizedBox(width: 8), // Add some padding between the avatar and the title
          ],
        ),
        leadingWidth: 100,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: chatHistory.length,
                itemBuilder: (context, index) {
                  final message = chatHistory[index]['message'];
                  final sender = chatHistory[index]['sender'];

                  if (sender == 'other') {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        decoration: const BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            topRight: Radius.circular(12.0),
                            bottomRight: Radius.circular(12.0),
                          ),
                        ),
                        child: Text(
                          message!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  } else {
                    return Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            topRight: Radius.circular(12.0),
                            bottomLeft: Radius.circular(12.0),
                          ),
                        ),
                        child: Text(message!),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          BottomAppBar(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                        hintText: 'Type your message...',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      String message = _textEditingController.text;
                      if (message.isNotEmpty) {
                        setState(() {
                          chatHistory.add({'message': message, 'sender': 'me'});
                        });
                        _textEditingController.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
