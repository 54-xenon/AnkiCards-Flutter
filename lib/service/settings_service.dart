import 'package:ankicards/repository/appSettings.dart';
import 'package:ankicards/repository/isar_setup.dart';

enum AiProvider { gemini, afm }

class SettingsService {
  static final SettingsService instance = SettingsService._();
  SettingsService._();

  Future<AiProvider> getAiProvider() async {
    try {
      final settings = await isar.appSettings.get(1);
      return settings?.aiProvider == 'afm' ? AiProvider.afm : AiProvider.gemini;
    } catch (_) {
      return AiProvider.gemini;
    }
  }

  Future<void> setAiProvider(AiProvider provider) async {
    try {
      await isar.writeTxn(() async {
        final settings = AppSettings()..aiProvider = provider.name;
        await isar.appSettings.put(settings);
      });
    } catch (_) {
      throw Exception('設定の保存に失敗しました');
    }
  }
}
