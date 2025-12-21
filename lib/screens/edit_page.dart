
import 'package:ankicards/collections/flashCard.dart';
import 'package:ankicards/widget/buttonContainer.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final FlashCard card;
  const EditPage({
    super.key,
    required this.card,
  });

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  // テキストコントローラーを設定
   // late -> lateを使うことで代入を後回しにすることができる
  late TextEditingController _controllerQ;
  late TextEditingController _controllerA;
  late TextEditingController _controllerE;

  @override
  void initState() {
    super.initState();
    _controllerQ = TextEditingController(text: widget.card.question);
    _controllerA = TextEditingController(text: widget.card.answer);
    _controllerE = TextEditingController(text: widget.card.explanation);

  }

  @override
  // メモリリリーク防止 -> 処理が終わるとメモリ解放(明示的にメモリ解放を宣言しておく)
  void dispose() {
    _controllerQ.dispose();
    _controllerA.dispose();
    _controllerE.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("edit Page"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder()
              ),
              // コントローラーの設定
              controller: _controllerQ,
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder()
              ),
              controller: _controllerA,
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder()
              ),
              controller: _controllerE,
            ),
            SizedBox(height: 10),
            MyButton(text: "Save", onPressed: () {
              final updateCard = widget.card
                ..question = _controllerQ.text
                ..answer = _controllerA.text
                ..explanation = _controllerE.text;              

              Navigator.pop(context, updateCard);
            }),
            MyButton(text: "Cancel", onPressed: () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }
}