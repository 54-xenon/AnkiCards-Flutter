// GeminiAPIを使用するための処理を書く
import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiApiService {
  // POST -> GeminiAPIへ、question・answerを送信して処理する
  Future<http.Response> requestExample(String question, String answer) {
    return http.post(
      Uri.parse('http://localhost:8080/api/gemini/example'),
      headers: <String, String>{
        // 文字コードとかの設定を明示的に宣言しているっぽい
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'question': question, 'answer': answer}),
    );
  }

  // json形式で返されるresposeをデコードして、テキストに戻す
  Future<String> responseExample(String question, String answer) async {
    // 1. POSTリクエストを送信
    final response = await requestExample(question, answer);

    // 2. ステータスコードで判定
    if (response.statusCode == 200) {
      // 3. 成功時：JSONをデコードして解説文を返す
      final decoded = jsonDecode(response.body);
      return decoded['example'] as String;
    } else {
      // 失敗時：エラーメッセージがあれば拾って例外にする
      try {
        final decoded = jsonDecode(response.body);
        throw Exception(decoded['message'] ?? 'Failed to request.');
      } catch (e) {
        throw Exception(
          'message: $e'
          'Failed to request.'
        );
      }
    }
  }
}
