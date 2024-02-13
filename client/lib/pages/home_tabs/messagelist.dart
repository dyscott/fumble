import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../util/auth.dart';

class ChatUser {
  final String name;
  final String avatarUrl;

  ChatUser({required this.name, required this.avatarUrl});
}

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  Future<List<ChatUser>> getMatchedUsers() async {
    var res = await pb.send('api/fumble/linkin');

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
  State<ChatScreen> createState() => _ChatScreenState();
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
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(widget.person.avatarUrl),
            ),
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
