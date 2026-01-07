import 'package:ankicards/collections/flashCard.dart';
import 'package:ankicards/collections/flash_card_repository.dart';



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
  List<dynamic> _playList = [];
  // 出題管理用のリスト
  int _currentIndex = 0;
  // 結果のカウント
  int correctCount = 0; // -> true
  int incorrectCount = 0; // -> false

  // 初期化
  Future<void> inisilaize() async{
    // 保存したカードの取得
    _playList = await _cardRepository.getAllCards();
    // カードのランダム
    _playList.shuffle();
    // 各種変数の初期化
    _currentIndex = 0;
    correctCount = 0;
    incorrectCount = 0;
  }

  // 現在出題中のカードを取得
  FlashCard get currentCard {
    return _playList[_currentIndex];
  }
  
  // 今現在何問目か？ -> UI表示用
  int get currentQuestionCount {
    return _currentIndex + 1;
  }

  // 出題総数
  int get totalQuestionCount {
    return _playList.length;
  }

  Future<void> answer(bool isCorrect) async {
    final card = currentCard;

    // 結果のカウント
    if (isCorrect) {
      // true -> 分かったとしてカウント
      correctCount++;
      card.isCorrect = true;
    } else {
      // false -> 分からなかったとしてカウント
      incorrectCount++;
      card.isCorrect = false;
    }

    // DBに回答後の問題を保存
    await _cardRepository.updateCard(card);

    // インクリメントして次の問題へ
    _currentIndex++;
  }
  
  // 終了判定 -> 出題が全て終了したか
  bool get isFinished {
    return _currentIndex >= _playList.length;
  }

  // 結果の表示
  

}
