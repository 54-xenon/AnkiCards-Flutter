import 'package:isar/isar.dart';
import 'flashCard.dart';
import 'isar_setup.dart';

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

// タグ機能を管理するクラス
class TagRepository {
  // タグを作成
  Future<Tag> addTag({required String name, String? color}) async {
    final newTag = Tag()
      ..name = name
      ..color = color;

    await isar.writeTxn(() async {
      await isar.tags.put(newTag);
    });

    return newTag;
  }

  // すべてのタグを取得
  Future<List<Tag>> getAllTags() async {
    return isar.tags.where().sortByName().findAll();
  }

  // idでタグを取得
  Future<Tag?> getTagById(int id) async {
    return isar.tags.get(id);
  }

  // 名前でタグを検索（部分一致）
  Future<List<Tag>> searchTagsByName(String keyword) async {
    return isar.tags.filter().nameContains(keyword, caseSensitive: false).findAll();
  }

  // タグを更新
  Future<void> updateTag(Tag tag) async {
    await isar.writeTxn(() async {
      await isar.tags.put(tag);
    });
  }

  // タグを削除（カードとのリンクも同時に解除）
  Future<void> deleteTag(int id) async {
    await isar.writeTxn(() async {
      final tag = await isar.tags.get(id);
      if (tag == null) {
        return;
      }

      final linkedCards = await isar.flashCards.filter().tags((q) => q.idEqualTo(id)).findAll();
      for (final card in linkedCards) {
        await card.tags.load();
        card.tags.removeWhere((linkedTag) => linkedTag.id == id);
        await card.tags.save();
      }

      await isar.tags.delete(id);
    });
  }

  // タグをすべて削除
  Future<void> deleteAllTags() async {
    await isar.writeTxn(() async {
      // .clearで全てのデータを削除する
      await isar.tags.clear();
    });
  }
}

// フラッシュカードの処理を管理するclass
class CardRepository {
  List<String> _normalizeTagNames(List<String> tagNames) {
    final normalizedTagNames = <String>{};
    for (final tagName in tagNames) {
      final normalizedTagName = tagName.trim();
      if (normalizedTagName.isEmpty) {
        continue;
      }
      normalizedTagNames.add(normalizedTagName);
    }
    return normalizedTagNames.toList();
  }

  Future<List<Tag>> _resolveTags(List<String> tagNames) async {
    final tags = <Tag>[];

    for (final tagName in _normalizeTagNames(tagNames)) {
      final existingTag = await isar.tags.filter().nameEqualTo(tagName).findFirst();
      if (existingTag != null) {
        tags.add(existingTag);
        continue;
      }

      final newTag = Tag()
        ..name = tagName
        ..color = null;
      await isar.tags.put(newTag);
      tags.add(newTag);
    }

    return tags;
  }

  // カードを作成
  Future<void> addCard(CardDraft cardData) async {
    final newCard =
        FlashCard()
          ..question = cardData.question
          ..answer = cardData.answer
          ..explanation = cardData.explanation
          ..createTime = DateTime.now()
          ..lastReviewedAt = null
          ..lastupdateTime = null
          ..isCorrect = null;

    // カスケード記法は記述の最後にコロンをつける -> これをつけないとエラーになる
    // 一つのオブジェクトに対して、連続でメソッドやプロパティを連続で指定できる記法のこと
    await isar.writeTxn(() async {
      // 引数cardDateから受けどったデータnewCardをDBに保存する
      await isar.flashCards.put(newCard);
      final tags = await _resolveTags(cardData.tagNames);
      newCard.tags.addAll(tags);
      await newCard.tags.save();
    });
  }

  // すべてのカードを取得
  Future<List<FlashCard>> getAllCards() async {
    return isar.flashCards.where().findAll();
  }

  // タグ付きのカードをすべて取得
  Future<List<FlashCard>> getCardsByTagId(int tagId) async {
    return isar.flashCards.filter().tags((q) => q.idEqualTo(tagId)).findAll();
  }

  // カードにタグを追加
  Future<void> addTagToCard({required int cardId, required int tagId}) async {
    await isar.writeTxn(() async {
      final card = await isar.flashCards.get(cardId);
      final tag = await isar.tags.get(tagId);
      if (card == null || tag == null) {
        return;
      }

      await card.tags.load();
      if (!card.tags.any((existingTag) => existingTag.id == tagId)) {
        card.tags.add(tag);
        await card.tags.save();
      }
    });
  }

  // カードからタグを削除
  Future<void> removeTagFromCard({required int cardId, required int tagId}) async {
    await isar.writeTxn(() async {
      final card = await isar.flashCards.get(cardId);
      if (card == null) {
        return;
      }

      await card.tags.load();
      card.tags.removeWhere((tag) => tag.id == tagId);
      await card.tags.save();
    });
  }

  // カードに紐づくタグを取得
  Future<List<Tag>> getTagsForCard(int cardId) async {
    final card = await isar.flashCards.get(cardId);
    if (card == null) {
      return [];
    }

    await card.tags.load();
    return card.tags.toList();
  }

  // カードを更新
  Future<void> updateCard(FlashCard flashCard) async {
    // DBに保存したデータを取り出す
    await isar.writeTxn(() async {
      await isar.flashCards.put(flashCard);
    });
  }

  // カード更新時にタグを同期
  Future<void> updateCardWithTags({
    required FlashCard flashCard,
    required List<String> tagNames,
  }) async {
    await isar.writeTxn(() async {
      await isar.flashCards.put(flashCard);

      final tags = await _resolveTags(tagNames);
      await flashCard.tags.load();
      flashCard.tags.clear();
      flashCard.tags.addAll(tags);
      await flashCard.tags.save();
    });
  }

  // カードを削除
  Future<void> deleteCard(int id) async {
    await isar.writeTxn(() async {
      await isar.flashCards.delete(id);
    });
  }

  // カードをすべて削除
  Future<void> deleteAllCards() async {
    await isar.writeTxn(() async {
      // .clearで全てのデータを削除する
      await isar.flashCards.clear();
    });
  }
}
