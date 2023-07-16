import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:textcraft/pages/homepage.dart';
import 'login_or_register.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return LoginOrRegister();
            }
          })),
    );
  }
}
