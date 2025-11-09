import 'package:ankicards/screens/create_page.dart';
import 'package:ankicards/screens/edit_page.dart';
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
    // example
    ['日本で一番一番高い山は？', '富士山', '日本で一番高い山は富士山です。実は富士山は登山の難易度が非常に高いことでも有名です'],
  ];

  // カードを削除
  void deleteAction(int index) {
    setState(() {
      cardList.removeAt(index);
    });
  }

  // カードの編集
  void editAction(int index) async{
    // カードを更新する処理
    final updateCard = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditPage(
      card: cardList[index],
      index: index,
    )));

    if (updateCard != null) {
      setState(() {
        cardList[index] = updateCard;
      });
    }
  }


  // カードを追加する関数
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home"), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5, //横方向
          vertical: 5 //縦歩行
        ),
        child: ListView.builder(
          itemCount: cardList.length,
          itemBuilder: (context, index) {
            return Cardcotainer(
              question: cardList[index][0],
              answer: cardList[index][1],
              explanation: cardList[index][2],
              deleteCard: (context) => deleteAction(index),
              cardTap: (context) => editAction(index),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        // カードの作成画面へ移動する
        onPressed: () async {
          final newCard = await Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePage()));
          
          if (newCard != null) {
            setState(() {
              cardList.add(newCard);
            });
          }
        },
      ),
    );
  }
}
