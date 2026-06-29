import 'package:ankicards/repository/flashCard.dart';
import 'package:ankicards/repository/flash_card_repository.dart';
import 'package:ankicards/repository/resultModel.dart';



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
  List<FlashCard> _playList = [];
  int _currentIndex = 0;
  int _correctCount = 0;
  int _incorrectCount = 0;

  // 初期化
  Future<void> initialize() async {
    // 保存したカードの取得
    _playList = await _cardRepository.getAllCards();
    // カードのランダムに並び替える
    _playList.shuffle();
    // 各種変数の初期化
    _currentIndex = 0;
    _correctCount = 0;
    _incorrectCount = 0;
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
      _correctCount++;
      card.isCorrect = true;
      card.lastReviewedAt = DateTime.now();
    } else {
      _incorrectCount++;
      card.isCorrect = false;
      // 回答した時刻とかを記録する
      card.lastReviewedAt = DateTime.now();

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

  // 結果の表示 -> 結果を表示するためのデータを記録
  ResultModel getResult() {
    return ResultModel(
      correct: _correctCount,
      wrong: _incorrectCount,
      total: _correctCount + _incorrectCount,
    );
  }
  
}
