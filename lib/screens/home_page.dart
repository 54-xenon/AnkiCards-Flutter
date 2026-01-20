import 'package:ankicards/screens/play_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // AnkiCardsのタイトル的なな何か -> ダッシュボード機能が充実してくると削除する予定
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      maxRadius: 30,
                      child: Text(
                        "🚀",
                        style: TextStyle(
                          fontSize: 40,
                        ),
                      ),
                    ),
                    Text(
                      "AnkiCards",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // カードの総数と、連続達成日、今現在の正答率を表示する

              // 出題開始ボタン
              GestureDetector(
                onTap:() => Navigator.push(
                  context,MaterialPageRoute(builder: (context) => PlayPage()),
                ),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 30,
                        ),
                        Text(
                          "Start",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}