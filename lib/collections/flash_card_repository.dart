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
        // 一つのオブジェクトに対して、連続でメソッドやプロパティを連続で指定できる記法のこと
    await isar.writeTxn(() async {
      // 引数cardDateから受けどったデータnewCardをDBに保存する
      await isar.flashCards.put(newCard); 
    });
  }

  // get a all cards 
  Future<List<FlashCard>> getAllCards() async {
    return await isar.flashCards.where().findAll();
  }

  // update a card
  Future<void> updateCard(FlashCard flashCard) async {
    // DBに保存したデータを取り出す
    await isar.writeTxn(() async {
      await isar.flashCards.put(flashCard);
    });
  }

  // delete a card
  Future<void> deleteCard(int id) async {
    await isar.writeTxn(() async {
      await isar.flashCards.delete(id);
    });
  }

  // delete a  all cards
  Future<void> deleteAllCards() async {
    await isar.writeTxn(() async {
      // .clearで全てのデータを削除する
      await isar.flashCards.clear();
    });
  }
}