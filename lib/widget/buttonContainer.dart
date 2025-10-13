import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  MyWidget({
    super.key,
    required this.text,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.lightBlue[100],
      onPressed: onPressed,
      child: Text(text),
    );
  }
}