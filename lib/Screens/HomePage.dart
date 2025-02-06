import 'package:chat_app1/Services/chat/chat_service.dart';
import 'package:chat_app1/component/userTile.dart';
import 'package:flutter/material.dart';
import '../Services/auth/auth_service.dart';
import '../component/my_drawer.dart';
import 'chat_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Home"),
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList(){
    return StreamBuilder(
        stream: _chatService.getUserStream(),
        builder: (context,snapshot){
          if(snapshot.hasError){
            return const Text("ERROR");
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Text("Loading...");
          }

          return ListView(
            children: snapshot.data!
                .map<Widget>((userData) => _buildUserListItem(userData,context))
                .toList()
          );
        }
    );
  }

  Widget _buildUserListItem(Map<String,dynamic> userData, BuildContext context){
     //display all user except your own
    if(userData['email'] != _authService.getCurrentUser()!.email) {
      return Usertile(
        text: userData["name"],
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                        recieverEmail: userData["name"],
                        recieverId: userData["uid"],
                      )));
        },
      );
    }else{
      return Container(

      );
    }
  }
}
