import 'package:isar/isar.dart';

part 'flashCard.g.dart';

@collection
class FlashCard {
  // 自動インクリメントするID
  Id id = Isar.autoIncrement;
  
  late String question;

  late String answer;
  
  late String explanation;
}