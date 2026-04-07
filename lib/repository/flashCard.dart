import 'package:isar/isar.dart';

part 'flashCard.g.dart';

@collection
class FlashCard {
  // 自動インクリメントするID
  Id id = Isar.autoIncrement;

  // 作成日 -> これはカードの作成した時間を必ず記入するからnullを許容しない
  late DateTime createTime;

  // 最終更新日 -> 一度も編集してないなら、これはnullとするためnullを許容する
  late DateTime? lastupdateTime;

  // 最後に復習した日時 -> 未回答はnullとするからnull許容にする
  late DateTime? lastReviewedAt;
  
  late String question;

  late String answer;
  
  late String explanation;

  late bool? isCorrect;
  
  // tagコレクションとFlashCardをリンクさせる必要がある
  final tags = IsarLinks<Tag>();

}


// タグ付けした情報を保持するため
@collection
class Tag {
  // 自動でインクリメントするID
  Id id = Isar.autoIncrement;
  // 名前 -> タグの名前
  late String name;
  // 表示カラー -> 複数のタグが同じ色だと見分けることができないから、任意の色を割り当てることができる。
  late String? color;
}

// デッキ -> カードを格納する親フォルダ的なもの(カードの専用のidを持たせて、一致するカードをそのフォルダに属しているとすり)