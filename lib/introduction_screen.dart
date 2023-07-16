import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textcraft/components/ele_button.dart';

import 'auth/auth.dart';

class IntroScreen extends StatefulWidget {
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.linear,
    );
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                "Welcome to TextCraft AI",
                style: GoogleFonts.bebasNeue(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 43,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 200,
              width: 200,
              child: RotationTransition(
                turns: animation,
                child: Container(
                  width: 80,
                  height: 80,
                  child: Image.asset(
                    "assets/logo.png",
                    color: Colors.grey.shade900,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Simplify and enhance your writing tasks with AI-powered Summarization and Rephrasing",
                style: GoogleFonts.barlowCondensed(fontSize: 32),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30),
            EleButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AuthPage(),
                  ),
                );
              },
              text: 'Get Started',
            ),
          ],
        ),
      ),
    );
  }
}
