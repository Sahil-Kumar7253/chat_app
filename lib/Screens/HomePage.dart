import 'package:chat_app1/auth/auth_service.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

   void logout(){
      final _authService =  AuthService();
      _authService.signOut();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: logout,
              icon:const Icon(Icons.logout)
          )
        ],
      ),
    );
  }
}
