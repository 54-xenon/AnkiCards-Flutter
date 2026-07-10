import 'package:foundation_models_framework/foundation_models_framework.dart';


class AfmService {

  // Foundation Modelがこのデバイスで使用できるかをチェックする
  Future<AvailabilityResponse> checkAfm() async {
    final foundationModels = FoundationModelsFramework.instance;
    final availability = await foundationModels.checkAvailability();
    return availability;
  }

  // 質問と回答からオンデバイスのFoundation Modelsで解説を生成する
  Future<String> generateExample(String question, String answer) async {
    final foundationModels = FoundationModelsFramework.instance;
    final response = await foundationModels.sendPrompt(
      '以下の質問と回答をもとに、学習者が理解しやすい解説を日本語で生成してください。\n\n質問: $question\n回答: $answer',
      instructions: 'あなたはフラッシュカードの学習をサポートするAIアシスタントです。質問と回答をもとに、簡潔でわかりやすい解説を生成してください。',
    );
    if (response.errorMessage != null) {
      throw Exception(response.errorMessage);
    }
    return response.content;
  }

}