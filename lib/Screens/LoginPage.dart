import 'package:chat_app1/component/my_button.dart';
import 'package:chat_app1/component/my_textField.dart';
import 'package:flutter/material.dart';

import '../Services/auth/auth_service.dart';

class LoginPage extends StatelessWidget {
  //email and password controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final void Function()? onTap;

  LoginPage({
    super.key,
    required this.onTap
  });

  void login(BuildContext context) async{
    final authService = AuthService();
    try{
      await authService.signInEmailPassword(_emailController.text,_passwordController.text);
    }
    catch (e){
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.message,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),

          const SizedBox(height: 35),

          Text(
            "Welcome Back",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          const SizedBox(height: 25),

          //email
          MyTextField(
            hintText: 'Email Id',
            obscureText: false,
            controller: _emailController,
          ),

          const SizedBox(height: 25),

          //password
          MyTextField(
            hintText: 'Password',
            obscureText: true,
            controller: _passwordController,
          ),

          const SizedBox(height: 25),

          //login button
          MyButton(
            text: 'Login',
            onTap:() =>  login(context),
          ),

          const SizedBox(height: 25),

          //register
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "If Not Registered,",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "Register Here",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inversePrimary,               ),
                ),
              )
            ],
          )

        ],
      ),
    );
  }

}