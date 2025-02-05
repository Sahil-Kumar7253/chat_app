import 'package:flutter/material.dart';
import '../Services/auth/auth_service.dart';
import '../component/my_button.dart';
import '../component/my_textField.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cnfpasswordController = TextEditingController();
  final void Function()? onTap;

  RegisterPage({
    super.key,
    required this.onTap
  });

  void register(BuildContext context) async {
    final _authService = AuthService();

    if (_passwordController.text == _cnfpasswordController.text) {
      try {
        await _authService.signUpwithEmailPassword(
            _emailController.text, _passwordController.text);
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: Text(e.toString()),
                )
        );
      }
    }
    else {
      showDialog(
          context: context,
          builder: (context) =>
          const AlertDialog(
            title: Text("Password doesn't match"),)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.message,
            size: 60,
            color: Theme
                .of(context)
                .colorScheme
                .primary,
          ),

          const SizedBox(height: 35),

          Text(
            "Welcome Back",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme
                  .of(context)
                  .colorScheme
                  .primary,
            ),
          ),

          const SizedBox(height: 25),

          //email
          MyTextField(
            hintText: 'Email Id',
            obscureText: false,
            controller: _emailController,
          ),

          const SizedBox(height: 15),

          //password
          MyTextField(
            hintText: 'Password',
            obscureText: true,
            controller: _passwordController,
          ),

          const SizedBox(height: 15),

          MyTextField(
            hintText: 'Confirm Password',
            obscureText: true,
            controller: _cnfpasswordController,
          ),

          const SizedBox(height: 25),

          //register button
          MyButton(
            text: 'Register',
            onTap: () => register(context),
          ),

          const SizedBox(height: 25),

          //register
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "If Already Registered,",
                style: TextStyle(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .primary,
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "Login Here",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme
                        .of(context)
                        .colorScheme
                        .inversePrimary,),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}