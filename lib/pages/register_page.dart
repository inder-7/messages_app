import 'package:flutter/material.dart';
import 'package:messages_app/auth/auth_service.dart';
import 'package:messages_app/componenets/my_button.dart';
import 'package:messages_app/componenets/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmpwController = TextEditingController();

  // tap to go to login page
  final void Function()? onTap;
   RegisterPage({super.key, required this.onTap});
    // register function
   void register(BuildContext context)async {
    final _auth = AuthService();
    if(_pwController.text == _confirmpwController.text){
      try{
        _auth.signUpWithEmailPassword(_emailController.text, _pwController.text);
      }catch (e){
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
      }
      // passwords dont match 
      else{
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Passwords don't match"),
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
            "Let's create an account for you",
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
          // confirm pw
          MyTextfield(
            hintText: "Confirm Password",
            obscureText: true,
            controller: _confirmpwController,
          ),
          SizedBox(
            height: 10,
          ),
          // button
          MyButton(
            text: "Register",
            onTap: () => register(context),
          ),

          // register
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account? ",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "Login now",
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