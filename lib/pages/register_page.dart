import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:textcraft/components/button.dart';
import 'package:textcraft/components/textfield.dart';

import '../introduction_screen.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void signUp() async {
    // show loading circle

    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));

    if (_passwordController.text != _confirmPasswordController.text) {
      Navigator.pop(context);
      displayMessage('Password don\'t match');
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IntroScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessage(e.code);
    }
  }

  void displayMessage(String message) {
    showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              title: Text(message),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/logo.png",
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Let\'s create an account for you! ',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MyTextField(
                    controller: _emailController,
                    hintText: 'Enter email',
                    obscureText: false,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  MyTextField(
                    controller: _passwordController,
                    hintText: 'Enter Password',
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  MyTextField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyButton(
                    onTap: signUp,
                    text: 'Sign up',
                    data: 25,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already a member? ',
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'Log in',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
