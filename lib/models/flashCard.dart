class Card {
  // 作成するカードに関するプロパティ -> firebaseなどのNoSQLのmBassに対応できるようにしておく

  // コンストラクタ
  Card({
    required this.id,
    required this.questtion,
    required this.answer,
    required this.explanation,
  });

  // プロファイル
  String id;
  String questtion;
  String answer;
  String explanation;

}