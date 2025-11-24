import 'package:isar/isar.dart';

part 'card.g.dart';

@collection
class Card {
  // 自動インクリメントするID
  Id id = Isar.autoIncrement;
  
  late String question;

  late String answer;
  
  late String explanation;
}