import 'package:isar/isar.dart';

part 'flashCard.g.dart';

@collection
class FlashCard {
  // 自動インクリメントするID
  Id id = Isar.autoIncrement;
  
  late String question;

  late String answer;
  
  late String explanation;

  late bool? isCorrect;
}

// isarのnull許容 -> デフォルトの場合nullは許容しない(つまり、必ず初期値を入れる必要がある)。nullを許容したい場合は型の後に"?"を入れる