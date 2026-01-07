import 'package:ankicards/controller/play_controller.dart';
import 'package:ankicards/widget/buttonContainer.dart';
import 'package:flutter/material.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({super.key});

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  // controllerのインスタンス化
  final PlayController _controller = PlayController();
  bool _isLoading = true;
  late bool showCard;

  Future<void> _initialize() async {
    await _controller.inisilaize();
    setState(() {
      _isLoading = false;
    });
  }

  // 初期化
  @override
  void initState() {
    super.initState();
    // initStateにasync/awaitをつけることはできないから、メソッドとして切り出すことで初期化を完了するようにする
    _initialize();
    showCard = false;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
              GestureDetector(
                onTap: () {
                  // setStateを使って、continerに持たせておるboolを反転させる
                  // setStateがないと再描画されない
                  setState(() {
                    showCard = !showCard;
                  });
                },
                child: Container(
                  height: 350,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.lightBlue[50],
                  ),
                  child: Center(
                    child: Text(
                      showCard
                          ? _controller.currentCard.answer
                          : _controller.currentCard.question,
                      // "日本で一番高い山は?",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ),
              // button -> true or false
              Container(
                height: 100,
                decoration: BoxDecoration(color: Colors.amberAccent),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MyButton(
                      text: '分からない',
                      onPressed: () async {
                        await _controller.answer(false);
                        if (_controller.isFinished) {
                          Navigator.pop(context);
                          return; // returnを置くことで、setStateの処理をジャンプして、存在しないインデックスへのアクセスを防ぐ為に必要となる
                        }
                        setState(() {
                          // もし、回答を表示した場合に次の問題文の答えが見えないようにするため
                          showCard = false;
                        });
                      },
                    ),
                    MyButton(
                      text: '分かった',
                      onPressed: () async {
                        await _controller.answer(true);
                        if (_controller.isFinished) {
                          Navigator.pop(context);
                          return;
                        }
                        setState(() {
                          showCard = false;
                        });
                        // 状態を更新する必要がある
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
