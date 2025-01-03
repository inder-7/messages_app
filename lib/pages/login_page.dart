import 'package:flutter/material.dart';
import 'package:messages_app/services/auth/auth_service.dart';
import 'package:messages_app/componenets/my_button.dart';
import 'package:messages_app/componenets/my_textfield.dart';

class LoginPage extends StatelessWidget {
  // email and pw controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  // tap to go to register page
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  // login method
  void login(BuildContext context) async {
    // auth service
    final authService = AuthService();
    // try login
    try {
      await authService.signInWithEmailPassword(
          _emailController.text, _pwController.text);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // logo
          Icon(
            Icons.message,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(
            height: 50,
          ),
          // welcome message
          Text(
            "WELCOME BACK YOU'VE BEEN MISSED",
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary, fontSize: 16),
          ),
          const SizedBox(
            height: 25,
          ),
          //email textfield
          MyTextfield(
            hintText: "Email",
            obscureText: false,
            controller: _emailController,
          ),

          SizedBox(
            height: 10,
          ),
          // password

          MyTextfield(
            hintText: "Password",
            obscureText: true,
            controller: _pwController,
          ),
          SizedBox(
            height: 10,
          ),
          // button
          MyButton(
            text: "LOGIN",
            onTap: () => login(context),
          ),

          // register
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Not a member? ",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "Register now",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
