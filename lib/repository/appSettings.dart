import 'package:isar_community/isar.dart';

part 'appSettings.g.dart';

@collection
class AppSettings {
  Id id = 1;

  // 'gemini' or 'afm'
  String aiProvider = 'gemini';
}
