import 'package:ankicards/widget/buttonContainer.dart';
import 'package:flutter/material.dart';

class PlayPage extends StatelessWidget {
  const PlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // progress bar
              Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.amber[100],
                ),
              ),
              // flashcard
              Container(
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.lightBlue[50],
                ),
                child: Center(
                  child: Text(
                    "日本で一番高い山は?",
                    style: TextStyle(
                      fontSize: 30
                    ),
                  ),
                ),
              ),
              // button -> true or false
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.amberAccent
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MyButton(text: '分からなかった', onPressed: () {},),
                      MyButton(text: '分かった', onPressed: () {}),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}