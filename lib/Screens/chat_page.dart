import 'package:chat_app1/Services/chat/chat_service.dart';
import 'package:chat_app1/component/my_textField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Services/auth/auth_service.dart';

class ChatPage extends StatefulWidget {
  final String recieverEmail;
  final String recieverId;

  const ChatPage({
    super.key,
    required this.recieverEmail,
    required this.recieverId
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void sendMessage() async {
    if(_messageController.text.isNotEmpty){
      await _chatService.sendMessage(widget.recieverId,_messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.recieverEmail),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),

          _buildUserInput()
        ],
      ),
    );
  }

  Widget _buildMessageList(){
    String senderId = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(widget.recieverId,senderId),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return const Text("Error");
          }

          if(snapshot.connectionState == ConnectionState.waiting){
            return const Text("Loading...");
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
          );
        }
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isMe = data['senderId'] == _authService.getCurrentUser()!.uid;

    var alignment =
        isMe ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(data["message"]),
          ],
        )
    );
  }

  Widget _buildUserInput(){
     return Row(
       children: [
          Expanded(
              child: MyTextField(
                  hintText: "Type a Message",
                  obscureText: false,
                  controller: _messageController
              )
          ),

         IconButton(
             onPressed: sendMessage,
             icon: const Icon(Icons.send)
         )
       ],
     );
  }
}
