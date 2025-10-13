import 'package:flutter/material.dart';

class Cardcotainer extends StatelessWidget {
  final int id;
  final String question;
  final String answer;
  final String explanation;
  const Cardcotainer({
    super.key,
    required this.id,
    required this.question,
    required this.answer,
    required this.explanation
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // question
      padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.lightBlue[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // question
            Text(
              question
            ),
            SizedBox(height: 5),
            // answer
            Text(
              answer
            ),
            SizedBox(height: 5),
            Text(
              explanation
            )
          ],
        ),
      ),
    );
  }
}