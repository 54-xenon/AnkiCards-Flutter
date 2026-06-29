import 'package:ankicards/repository/flashCard.dart';
import 'package:ankicards/repository/flash_card_repository.dart';
import 'package:ankicards/widget/card_form_fields.dart';
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
            CardFormFields(
              questionController: _controllerQ,
              answerController: _controllerA,
              explanationController: _controllerE,
              tagsController: _controllerTags,
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
