import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Cardcotainer extends StatelessWidget {

  final String question;
  final String answer;
  final String explanation;
  Function(BuildContext) deleteCard;
  Function(BuildContext) cardTap;
  Cardcotainer({
    super.key,
    required this.question,
    required this.answer,
    required this.explanation,
    required this.deleteCard,
    required this.cardTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // question
      padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: deleteCard,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(12),
              icon: Icons.delete,
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () => cardTap(context),
          child: Container(
            // Slidabelを使うと、widgetの幅がおかしくなるから一派いっぱいまで指定しておく
            width: double.infinity,
            padding: const EdgeInsets.all(30),
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
        ),
      ),
    );
  }
}