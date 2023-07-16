import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:textcraft/components/button.dart';
import 'package:textcraft/components/textfield.dart';
import 'package:textcraft/pages/introduction_screen.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void signIn() async {
    // show loading circle

    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (context.mounted) {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => IntroScreen()));
      }
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome Back to',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      ' TextCraft AI',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
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
                  height: 20,
                ),
                MyButton(
                  onTap: signIn,
                  text: 'Sign in',
                  data: 25,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member? ',
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
                        'Register now',
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
    );
  }
}
