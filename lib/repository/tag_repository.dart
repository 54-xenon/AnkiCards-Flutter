import 'package:isar_community/isar.dart';
import 'flashCard.dart';
import 'isar_setup.dart';

class TagRepository {
  List<String> _normalizeTagNames(List<String> tagNames) {
    final normalized = <String>{};
    for (final name in tagNames) {
      final trimmed = name.trim();
      if (trimmed.isNotEmpty) normalized.add(trimmed);
    }
    return normalized.toList();
  }

  // 名前のリストからTagを解決する（存在しなければ新規作成）
  // writeTxn の内側から呼ぶことを想定
  Future<List<Tag>> resolveByNames(List<String> tagNames) async {
    final tags = <Tag>[];
    for (final name in _normalizeTagNames(tagNames)) {
      final existing = await isar.tags.filter().nameEqualTo(name).findFirst();
      if (existing != null) {
        tags.add(existing);
        continue;
      }
      final newTag = Tag()
        ..name = name
        ..color = null;
      await isar.tags.put(newTag);
      tags.add(newTag);
    }
    return tags;
  }

  Future<Tag> addTag({required String name, String? color}) async {
    final newTag = Tag()
      ..name = name
      ..color = color;
    await isar.writeTxn(() async {
      await isar.tags.put(newTag);
    });
    return newTag;
  }

  Future<List<Tag>> getAllTags() async {
    return isar.tags.where().sortByName().findAll();
  }

  Future<Tag?> getTagById(int id) async {
    return isar.tags.get(id);
  }

  Future<List<Tag>> searchTagsByName(String keyword) async {
    return isar.tags.filter().nameContains(keyword, caseSensitive: false).findAll();
  }

  Future<void> updateTag(Tag tag) async {
    await isar.writeTxn(() async {
      await isar.tags.put(tag);
    });
  }

  Future<void> deleteTag(int id) async {
    await isar.writeTxn(() async {
      final tag = await isar.tags.get(id);
      if (tag == null) return;

      final linkedCards = await isar.flashCards
          .filter()
          .tags((q) => q.idEqualTo(id))
          .findAll();
      for (final card in linkedCards) {
        await card.tags.load();
        card.tags.removeWhere((t) => t.id == id);
        await card.tags.save();
      }

      await isar.tags.delete(id);
    });
  }

  Future<void> deleteAllTags() async {
    await isar.writeTxn(() async {
      await isar.tags.clear();
    });
  }
}
