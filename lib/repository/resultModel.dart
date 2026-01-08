
// 結果を表示するためのモデルクラス
 /* 
    リストで返すことも可能だが、配列の指定する場所を間違えることによるエラー、 
    拡張性を考えるとモデルクラスを採用する方が最善のため。
 */
class resultModel {
  // プロパティ
  final int correct;
  final int wrong;
  final int total;
  
  
  // コンストラクタ
  resultModel({
    required this.correct,
    required this.wrong,
    required this.total,
  });
  
}