import 'package:ankicards/widget/buttonContainer.dart';
import 'package:flutter/material.dart';
import 'package:ankicards/collections/flash_card_repository.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final TextEditingController _controllerQ = TextEditingController();
  final TextEditingController _controllerA = TextEditingController();
  final TextEditingController _controllerE = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create new card"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // question
            TextField(
              controller: _controllerQ,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "質問を入力"
              ),
            ),
        
            SizedBox(height: 10),
            // answer
            TextField(
              controller: _controllerA,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "回答を入力"
              ),
            ),
            SizedBox(height: 10),
            // explation
            TextField(
              controller: _controllerE,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "解説を入力"
              ),
            ),
            // taped ok button -> リストに追加して、home_pageのListViewをsetStateで更新
            MyButton(text: "ok", onPressed: () {
              // 直接値を渡すのではなく、一度定数を定義してそこに移して直接contextの後に渡す引数は1つだけにする
              final question = _controllerQ.text;
              final answer = _controllerA.text;
              final explanation = _controllerE.text;
              
              final newCard = [question, answer, explanation];
              Navigator.pop(context, newCard);

              // newCardからデータベースに保存する -> cardListの配列に追加するコードは削除する予定
              // newCardの流れまでは同じ
                // card_repositoriに記述した、カード追加メソッドに配列を渡すように設定する
              // インスタンスを作成 -> 実体化
              final repo = CardRepository();
              repo.addCard(newCard);
              
            }),
            MyButton(text: "cancel", onPressed: () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }
}