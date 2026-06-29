import 'package:ankicards/service/gemini_api_service.dart';
import 'package:ankicards/repository/flash_card_repository.dart';
import 'package:ankicards/widget/card_form_fields.dart';
import 'package:flutter/material.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final GeminiApiService _geminiApiService = GeminiApiService();
  final TextEditingController _controllerQ = TextEditingController();
  final TextEditingController _controllerA = TextEditingController();
  final TextEditingController _controllerE = TextEditingController();
  final TextEditingController _controllerTags = TextEditingController();

  bool _isGenerating = false;

  @override
  void dispose() {
    _controllerQ.dispose();
    _controllerA.dispose();
    _controllerE.dispose();
    _controllerTags.dispose();
    super.dispose();
  }

  Future<void> _generate() async {
    // 質問と回答がからの場合(OR) -> メッセージを表示して処理を終了させる
    if (_controllerQ.text.isEmpty || _controllerA.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("答えと回答を入力してください")));
      return;
    } else {
      // 生成中(true)へ値を変更
      setState(() => _isGenerating = true);
      try {
        // 質問と回答を送る(APIを叩く)
        final example = await _geminiApiService.responseExample(
          _controllerQ.text,
          _controllerA.text,
        );
        // 上記の処理が終わると、解説欄を管理してるコントローラに生成された文字列を代入し、setState関数でWidgetを更新する
        setState(() => _controllerE.text = example);
      } catch (e) {
        // エラーがある場合はsatefullwidgetの更新を行わなず、メソッドの処理を終了
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceFirst('Exception: ', ''))),
        );
      } finally {
        // 全ての処理が終わると生成していない(false)へ更新 -> 元の状態へ戻す
        setState(() => _isGenerating = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('新規作成'), elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CardFormFields(
              questionController: _controllerQ,
              answerController: _controllerA,
              explanationController: _controllerE,
              tagsController: _controllerTags,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _isGenerating ? null : _generate,
              icon:
                  _isGenerating
                      ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                      : const Icon(Icons.auto_awesome),
              label: Text(_isGenerating ? '生成中...' : 'AIで解説を自動生成'),
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 52),
                backgroundColor: colorScheme.secondaryContainer,
                foregroundColor: colorScheme.onSecondaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () {
                final tags =
                    _controllerTags.text
                        .split(',')
                        .map((tag) => tag.trim())
                        .where((tag) => tag.isNotEmpty)
                        .toList();

                // もし、質問と回答に何も入力されていない場合はこのページに止まって
                if (_controllerQ.text.isEmpty || _controllerA.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("質問と回答を入力してください")),
                  );
                  return;
                } else {
                  // 入力欄にどちらも入力されている場合はカードを保存する
                  Navigator.pop(
                    context,
                    CardDraft(
                      question: _controllerQ.text,
                      answer: _controllerA.text,
                      explanation: _controllerE.text,
                      tagNames: tags
                    ),
                  );
                }
              },
              icon: const Icon(Icons.save_outlined),
              label: const Text(
                '保存',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('キャンセル'),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
