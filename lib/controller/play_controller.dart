import 'package:ankicards/collections/flash_card_repository.dart';
import 'package:flutter/material.dart';



// playControllerの処理手順
/* 
  1. カードを全て取得
  2. 取得したカードを出題用のリストに一旦保存
  3. List.shuffle()でランダムに出題する
  4. 問題の回答を記録
  5. 出題が全て終わると、結果を出力する

*/

class PlayController {
  // CardRepositoryのインスタンス化
  // DBかららカードを読み込むメソッドを使いたいからCardRepositoryからインスタンス化
  final CardRepository _cardRepository = CardRepository();
  // late -> 後で初期化したい時に使う
  late List<dynamic> playList;
  // 今出題してるカードが何問目かをカウントする
  int currentIndex = 0;
  // カードの取得
  Future loadCards() async{
     playList = await _cardRepository.getAllCards();
  }

  // 保存したリストをランダムに出題する
  void serveCards() {
    return playList.shuffle();
  }

  // 出題した問題を管理する
  void checkCard(bool result) {
    if (result != true) {
      // flashCardsのboolをtrueにする
    } else {
      // flashCardsのboolをfalseにする
    }
  }

  // 出題が終了 -> 結果を表示するメソッド


}
