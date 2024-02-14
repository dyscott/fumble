import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../util/auth.dart';
import '../chat/chat.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  Future<List<ChatUser>> getMatchedUsers() async {
    var res = await pb.send('api/fumble/matches');

    List<RecordModel> list = [];
    for (var i in res) {
      list.add(RecordModel.fromJson(i));
    }
    List<ChatUser> users = [];
    for (var i in list) {
      final url = pb.files.getUrl(i, i.getStringValue('avatar')).toString();
      users.add(ChatUser(name: i.getStringValue('name'), avatarUrl: url, id: i.id));
    }

    return users;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getMatchedUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
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
                            backgroundImage: NetworkImage(
                                '${users[index].avatarUrl}?thumb=0x64'),
                          ),
                          title: Text(users[index].name),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ChatScreen(recipient: users[index]),
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