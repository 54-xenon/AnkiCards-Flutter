// 必要なパッケージをインポート
  // DBのイニシャライザを記述するファイル -> 別ファイルにする必要はないかもだけどせっかくだから
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'flashCard.dart';

// 型を宣言しないとメソッドの参照エラーになる
late final Isar isar;

Future<void> initializeIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  isar = await Isar.open(
    [FlashCardSchema], 
    directory: dir.path,
  );
}