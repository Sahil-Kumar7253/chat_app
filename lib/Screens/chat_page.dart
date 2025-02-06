import 'package:chat_app1/Services/chat/chat_service.dart';
import 'package:chat_app1/component/chatbubble.dart';
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

  FocusNode myFocusNode = FocusNode();

  @override
  void  initState(){
    super.initState();
    myFocusNode.addListener((){
      if(myFocusNode.hasFocus){
         Future.delayed(
           const Duration(milliseconds: 500),
             () => scrollDown(),
         );
      }
    });

    Future.delayed(const Duration(milliseconds: 500),
        () => scrollDown(),
    );
  }

  @override
  void dispose(){
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();
  void scrollDown(){
    _scrollController.animateTo(
    _scrollController.position.maxScrollExtent,
    duration: const Duration(milliseconds: 300),
    curve: Curves.fastOutSlowIn
    );
  }

  void sendMessage() async {
    if(_messageController.text.isNotEmpty){
      await _chatService.sendMessage(widget.recieverId,_messageController.text);
      _messageController.clear();
    }

    scrollDown();
  }

  @override
  Widget build(BuildContext context) {

    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode? Colors.grey : Colors.white,
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
            controller: _scrollController,
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
            ChatBubble(
              message : data["message"],
              currentUser: isMe,
            ),
          ],
        )
    );
  }

  Widget _buildUserInput(){
     return Padding(
       padding: const EdgeInsets.all(8.0),
       child: Row(
         children: [
              Expanded(
                  child: MyTextField(
                      hintText: "Type a Message",
                      obscureText: false,
                      controller: _messageController,
                      focusNode: myFocusNode,
                  )
              ),

           Container(
             decoration: const BoxDecoration(
               color: Colors.green,
               shape: BoxShape.circle,
             ),
             margin: const EdgeInsets.only(right: 20),
             child: IconButton(
                 onPressed: sendMessage,
                 icon: const Icon(Icons.send)
             ),
           )
         ],
       ),
     );
  }
}
