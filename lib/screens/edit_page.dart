import 'package:ankicards/repository/flashCard.dart';
import 'package:ankicards/repository/flash_card_repository.dart';
import 'package:flutter/material.dart';

class EditCardResult {
  final FlashCard card;
  final List<String> tagNames;

  EditCardResult({required this.card, required this.tagNames});
}

class EditPage extends StatefulWidget {
  final FlashCard card;
  const EditPage({super.key, required this.card});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final CardRepository _cardRepository = CardRepository();

  late TextEditingController _controllerQ;
  late TextEditingController _controllerA;
  late TextEditingController _controllerE;
  late TextEditingController _controllerTags;

  @override
  void initState() {
    super.initState();
    _controllerQ = TextEditingController(text: widget.card.question);
    _controllerA = TextEditingController(text: widget.card.answer);
    _controllerE = TextEditingController(text: widget.card.explanation);
    _controllerTags = TextEditingController();
    _loadTags();
  }

  Future<void> _loadTags() async {
    final tags = await _cardRepository.getTagsForCard(widget.card.id);
    if (!mounted) return;
    setState(() {
      _controllerTags.text = tags.map((tag) => tag.name).join(', ');
    });
  }

  @override
  void dispose() {
    _controllerQ.dispose();
    _controllerA.dispose();
    _controllerE.dispose();
    _controllerTags.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('編集'),
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
            // 解説の入力欄
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
            // タグの入力欄
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
            const SizedBox(height: 32),
            // ボタン
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('キャンセル'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: FilledButton(
                    onPressed: () {
                      final updatedCard = widget.card
                        ..question = _controllerQ.text
                        ..answer = _controllerA.text
                        ..explanation = _controllerE.text
                        ..lastupdateTime = DateTime.now();

                      final tagNames = _controllerTags.text
                          .split(',')
                          .map((tag) => tag.trim())
                          .where((tag) => tag.isNotEmpty)
                          .toList();

                      Navigator.pop(
                        context,
                        EditCardResult(card: updatedCard, tagNames: tagNames),
                      );
                    },
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(0, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      '保存',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
