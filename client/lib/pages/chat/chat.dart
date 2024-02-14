import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../util/auth.dart';

class ChatUser {
  final String name;
  final String avatarUrl;
  final String id;

  ChatUser({required this.name, required this.avatarUrl, required this.id});
}

class ChatScreen extends StatefulWidget {
  final ChatUser recipient;

  const ChatScreen({Key? key, required this.recipient}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  List<ChatMessage> chatHistory = [];
  bool loading = true;
  VoidCallback unsubscribe = () => {};

  @override
  void initState() {
    super.initState();
    getChatHistory();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    unsubscribe();

    super.dispose();
  }

  void getChatHistory() async {
    // Get the chat history from the server
    final user = Provider.of<AuthProvider>(context, listen: false).user!;
    final chats = await pb.collection('messages').getFullList(
          filter:
              '(author = "${user.id}" && recipient = "${widget.recipient.id}") || (author = "${widget.recipient.id}" && recipient = "${user.id}")',
          sort: 'created',
        );

    for (var i in chats) {
      chatHistory.add(ChatMessage(
        message: i.data['contents'],
        sentByMe: i.data['author'] == user.id,
      ));
    }

    // Setup subscription to new messages sent by the recipient
    unsubscribe = await pb.collection('messages').subscribe(
      "*",
      (e) {
        if (e.action == 'create' && e.record != null) {
          final message = e.record!.data['contents'];
          final sentByMe = e.record!.data['author'] == user.id;

          setState(() {
            chatHistory.add(ChatMessage(message: message, sentByMe: sentByMe));
          });
        }
      },
      filter:
          'author = "${widget.recipient.id}" && recipient = "${user.id}"',
    );

    setState(() {
      loading = false;
    });
  }

  void sendMessage() {
    final message = _textEditingController.text;
    final messenger = ScaffoldMessenger.of(context);
    if (message.isEmpty) return;

    // Send the message to the server
    final user = Provider.of<AuthProvider>(context, listen: false).user!;
    try {
      pb.collection('messages').create(body: {
        'author': user.id,
        'recipient': widget.recipient.id,
        'contents': message,
      });
      setState(() {
        chatHistory.add(ChatMessage(message: message, sentByMe: true));
      });
    } catch (e) {
      // Show error message
      messenger.showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }

    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipient.name),
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
              backgroundImage:
                  NetworkImage('${widget.recipient.avatarUrl}?thumb=0x64'),
            ),
          ],
        ),
        leadingWidth: 100,
      ),
      body: Column(
        children: [
          loading
              ? const CircularProgressIndicator()
              : ChatContents(chatHistory: chatHistory),
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
                    onPressed: sendMessage,
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

class ChatMessage {
  final String message;
  final bool sentByMe;

  ChatMessage({required this.message, required this.sentByMe});
}

class ChatContents extends StatelessWidget {
  final List<ChatMessage> chatHistory;

  const ChatContents({super.key, required this.chatHistory});

  @override
  Widget build(BuildContext context) {
    final reversed = chatHistory.reversed.toList();
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          reverse: true,
          itemCount: reversed.length,
          itemBuilder: (context, index) {
            final message = reversed[index].message;
            final sentByMe = reversed[index].sentByMe;

            if (!sentByMe) {
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
                    message,
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
                  child: Text(message),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
