import 'package:isar/isar.dart';
import 'flashCard.dart';
import 'isar_setup.dart';


class CardRepository {
  // create a new card
  Future<void> addCard(List cardData) async {
    final newCard = FlashCard()
       ..question = cardData[0]
       ..answer = cardData[1]
       ..explanation = cardData[2];
       // カスケード記法は記述の最後にコロンをつける
    await isar.writeTxn(() async {
      // 引数cardDateから受けどったデータnewCardをDBに保存する
      await isar.flashCards.put(newCard); 
    });
  }

  // update a card
  // delete a card

  // delete a  all cards
  Future<void> deleteAllCards(List cardData) async {

  }
}