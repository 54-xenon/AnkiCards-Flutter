// 必要なパッケージをインポート
  // DBのイニシャライザを記述するファイル -> 別ファイルにする必要はないかもだけどせっかくだから
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'card.dart';

late final isar;

Future<void> initializeIsar() async {
  final dir = await getApplicationCacheDirectory();
  isar = await Isar.open(
    [CardSchema], 
    directory: dir.path,
  );
}