import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool currentUser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.currentUser
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: currentUser? Colors.green : Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(10),
            bottomRight: const Radius.circular(10),
            topRight: currentUser? const Radius.circular(0) : const Radius.circular(10),
            topLeft: currentUser? const Radius.circular(10) : const Radius.circular(0)
        )
      ),
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      child: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16
        ),
      ),
    );
  }
}
