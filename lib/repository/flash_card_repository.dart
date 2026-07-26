import 'package:isar_community/isar.dart';
import 'flashCard.dart';
import 'isar_setup.dart';
import 'tag_repository.dart';

class CardDraft {
  final String question;
  final String answer;
  final String explanation;
  final List<String> tagNames;

  CardDraft({
    required this.question,
    required this.answer,
    required this.explanation,
    required this.tagNames,
  });
}

class CardRepository {
  final TagRepository _tagRepository = TagRepository();

  Future<void> addCard(CardDraft cardData) async {
    final newCard = FlashCard()
      ..question = cardData.question
      ..answer = cardData.answer
      ..explanation = cardData.explanation
      ..createTime = DateTime.now()
      ..lastReviewedAt = null
      ..lastupdateTime = null
      ..isCorrect = null;

    await isar.writeTxn(() async {
      await isar.flashCards.put(newCard);
      final tags = await _tagRepository.resolveByNames(cardData.tagNames);
      newCard.tags.addAll(tags);
      await newCard.tags.save();
    });
  }

  // 全てのカードを記述
  Future<List<FlashCard>> getAllCards() async {
    return isar.flashCards.where().findAll();
  }

  Future<List<FlashCard>> getCardsByTagId(int tagId) async {
    return isar.flashCards.filter().tags((q) => q.idEqualTo(tagId)).findAll();
  }

  Future<void> addTagToCard({required int cardId, required int tagId}) async {
    await isar.writeTxn(() async {
      final card = await isar.flashCards.get(cardId);
      final tag = await isar.tags.get(tagId);
      if (card == null || tag == null) return;

      await card.tags.load();
      if (!card.tags.any((t) => t.id == tagId)) {
        card.tags.add(tag);
        await card.tags.save();
      }
    });
  }

  Future<void> removeTagFromCard({required int cardId, required int tagId}) async {
    await isar.writeTxn(() async {
      final card = await isar.flashCards.get(cardId);
      if (card == null) return;

      await card.tags.load();
      card.tags.removeWhere((t) => t.id == tagId);
      await card.tags.save();
    });
  }

  Future<List<Tag>> getTagsForCard(int cardId) async {
    final card = await isar.flashCards.get(cardId);
    if (card == null) return [];

    await card.tags.load();
    return card.tags.toList();
  }

  Future<void> updateCard(FlashCard flashCard) async {
    await isar.writeTxn(() async {
      await isar.flashCards.put(flashCard);
    });
  }

  Future<void> updateCardWithTags({
    required FlashCard flashCard,
    required List<String> tagNames,
  }) async {
    await isar.writeTxn(() async {
      await isar.flashCards.put(flashCard);

      final tags = await _tagRepository.resolveByNames(tagNames);
      await flashCard.tags.load();
      flashCard.tags.clear();
      flashCard.tags.addAll(tags);
      await flashCard.tags.save();
    });
  }

  Future<void> deleteCard(int id) async {
    await isar.writeTxn(() async {
      await isar.flashCards.delete(id);
    });
  }

  Future<List<FlashCard>> searchAndFilterCards({
    String keyword = '',
    List<int> tagIds = const [],
  }) async {
    List<FlashCard> cards;
    if (keyword.isEmpty) {
      cards = await isar.flashCards.where().findAll();
    } else {
      cards = await isar.flashCards
          .filter()
          .group((q) => q
              .questionContains(keyword, caseSensitive: false)
              .or()
              .answerContains(keyword, caseSensitive: false)
              .or()
              .explanationContains(keyword, caseSensitive: false))
          .findAll();
    }

    for (final card in cards) {
      await card.tags.load();
    }

    if (tagIds.isEmpty) return cards;

    return cards.where((card) {
      final cardTagIds = card.tags.map((t) => t.id).toSet();
      return tagIds.every((id) => cardTagIds.contains(id));
    }).toList();
  }

  Future<void> deleteAllCards() async {
    await isar.writeTxn(() async {
      await isar.flashCards.clear();
    });
  }
}
