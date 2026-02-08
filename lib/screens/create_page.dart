import 'package:ankicards/service/gemini_api_service.dart';
import 'package:ankicards/widget/buttonContainer.dart';
import 'package:flutter/material.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  // gemini_api_serviceのインスタンスを作成する
  final GeminiApiService _geminiApiService = GeminiApiService();


  final TextEditingController _controllerQ = TextEditingController();
  final TextEditingController _controllerA = TextEditingController();
  final TextEditingController _controllerE = TextEditingController();

  // メモリ開放 -> 通常宣言はしないがメモリリーク防止のため
  @override
  void dispose() {
    super.dispose();
    _controllerQ.dispose();
    _controllerA.dispose();
    _controllerE.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("新規作成"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              maxLines: 2,
              autocorrect: true,
              controller: _controllerQ,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(), 
                ),
                border: OutlineInputBorder(),
                hintText: "質問",
              ),
            ),
            SizedBox(height: 20),
            // answer
            TextField(
              autocorrect: true,
              controller: _controllerA,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
                hintText: "回答",
              ),
            ),
            SizedBox(height: 20),
            // explation
            TextField(
              maxLines: 15,
              autocorrect: true,
              controller: _controllerE,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
                hintText: "解説",
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyButton(
                  text: "キャンセル",
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(width: 10),
                MyButton(
                  text: "保存",
                  onPressed: () {
                    // 直接値を渡すのではなく、一度定数を定義してそこに移して直接contextの後に渡す引数は1つだけにする
                    final question = _controllerQ.text;
                    final answer = _controllerA.text;
                    final explanation = _controllerE.text;

                    final newCard = [question, answer, explanation];
                    Navigator.pop(context, newCard);
                  },
                ),
                SizedBox(width: 10),
                MyButton(
                  text: "生成",
                  onPressed: () async {
                    // 1. 入力された値を読み込む
                    final question = _controllerQ.text;
                    final answer = _controllerA.text;
                    // 2. serviceを呼ぶ
                    final example = await _geminiApiService.responseExample(question, answer);
                    // 3. controllerに結果を流す
                    setState(() {
                      _controllerE.text = example;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
