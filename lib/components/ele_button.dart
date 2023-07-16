import "package:flutter/material.dart";

class EleButton extends StatelessWidget {
  final onPressed;
  final String text;
  EleButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.grey[900],
          textStyle: const TextStyle(color: Colors.white),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(28))),
      child: SizedBox(
        width: 100,
        height: 50,
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
