import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String recieverEmail;

  const ChatPage({
    super.key,
    required this.recieverEmail,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.recieverEmail),
        centerTitle: true,
      ),
    );
  }
}
