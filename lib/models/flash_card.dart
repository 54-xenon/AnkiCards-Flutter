import 'package:hive/hive.dart';

part 'flash_card.g.dart';

@HiveType(typeId: 0)
class FlashCard {
  @HiveField(0)
  String question;

  @HiveField(1)
  String answer;

  @HiveField(2)
  String explanation;

  // コンストラクタ
  FlashCard(this.question, this.answer, this.explanation);
}


// key 
  
// value 
