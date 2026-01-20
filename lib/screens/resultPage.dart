import 'package:ankicards/repository/resultModel.dart';
import 'package:flutter/material.dart';

class Resultpage extends StatelessWidget {
  final resultModel result; 
  const Resultpage({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: PopScope(
          // 戻るジェチャの無効化 -> popを無効化
          canPop: false,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Great👏",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.lightGreen,
                  maxRadius: 70,
                  child: Icon(
                    Icons.check,
                    size: 100,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "正解: ${result.correct}問",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  "不正解: ${result.wrong}問",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  "合計: ${result.total}問",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                GestureDetector(
                  // 最初のホーム画面まで一気に戻る -> Flutterの画面遷移はスタック構造だから、ひたすらpopし続ける
                  onTap: () => Navigator.popUntil(context, (route) => route.isFirst),
                  child: Container(
                    width: 200,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row (
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                        Text(
                          "Home",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          
                // GestureDetector(
                //   child: Container(
                //     width: 200,
                //     height: 60,
                //     decoration: BoxDecoration(
                //       border: Border.all(
                //         width: 3,
                //       ),
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Icon(
                //           Icons.replay,
                //         ),
                //         Text(
                //           "リトライ",
                //           style: TextStyle(
                //             fontSize: 20,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         )
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        )
      ),
    );
  }
}
