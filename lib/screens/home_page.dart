import 'package:ankicards/widget/cardCotainer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List cardList = [
    // id, question, answer, explanation
    [001, '日本で一番一番高い山は？', '富士山', '日本で一番高い山は富士山です。実は富士山は登山の難易度が非常に高いことでも有名です'],
  ];

  // カードを追加する関数
  // カードを更新する関数
  // カードを削除する関数
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home"), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10, //横方向
          vertical: 10, //縦歩行
        ),
        child: ListView.builder(
          itemCount: cardList.length,
          itemBuilder: (context, index) {
            return Cardcotainer(
              id: cardList[index][0],
              question: cardList[index][1],
              answer: cardList[index][2],
              explanation: cardList[index][3],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // カード作成画面に遷移する
        },
      ),
    );
  }
}
