import 'package:ankicards/service/gemini_api_service.dart';
import 'package:ankicards/repository/flash_card_repository.dart';
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
    setState(() => _isGenerating = true);
    try {
      final example = await _geminiApiService.responseExample(
        _controllerQ.text,
        _controllerA.text,
      );
      setState(() => _controllerE.text = example);
    } finally {
      setState(() => _isGenerating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('新規作成'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              maxLines: 3,
              minLines: 2,
              autocorrect: true,
              controller: _controllerQ,
              decoration: const InputDecoration(
                labelText: '質問',
                hintText: '問題文を入力してください',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              autocorrect: true,
              controller: _controllerA,
              decoration: const InputDecoration(
                labelText: '回答',
                hintText: '答えを入力してください',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              maxLines: 10,
              minLines: 5,
              autocorrect: true,
              controller: _controllerE,
              decoration: const InputDecoration(
                labelText: '解説',
                hintText: '解説を入力してください',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              autocorrect: true,
              controller: _controllerTags,
              decoration: const InputDecoration(
                labelText: 'タグ',
                hintText: 'タグ1, タグ2, タグ3（カンマ区切り）',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                prefixIcon: Icon(Icons.label_outline),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _isGenerating ? null : _generate,
              icon: _isGenerating
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
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
                final tags = _controllerTags.text
                    .split(',')
                    .map((tag) => tag.trim())
                    .where((tag) => tag.isNotEmpty)
                    .toList();

                Navigator.pop(
                  context,
                  CardDraft(
                    question: _controllerQ.text,
                    answer: _controllerA.text,
                    explanation: _controllerE.text,
                    tagNames: tags,
                  ),
                );
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
