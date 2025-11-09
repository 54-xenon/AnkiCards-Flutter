
import 'package:ankicards/widget/buttonContainer.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final dynamic card;
  final dynamic index;
  const EditPage({
    super.key,
    required this.card,
    required this.index,
  });

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  // テキストコントローラーを設定
  final TextEditingController _controllerQ = TextEditingController();
  final TextEditingController _controllerA = TextEditingController();
  final TextEditingController _controllerE = TextEditingController();


  @override
  Widget build(BuildContext context) {
      // からのテキストコントローラーに初期値を設定する
      _controllerQ.text = widget.card[0];
      _controllerA.text = widget.card[1];
      _controllerE.text = widget.card[2];


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
              //　TextFildが更新刺される -> 新しい文字列を代入して元の画面に戻る
              final updateCard = [
                // .textを指定しないと型エラーになる
                _controllerQ.text,
                _controllerA.text,
                _controllerE.text
              ];

              Navigator.pop(context, updateCard);
            }),
            MyButton(text: "Cancel", onPressed: () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }
}