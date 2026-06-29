import 'package:flutter/material.dart';

class CardFormFields extends StatelessWidget {
  final TextEditingController questionController;
  final TextEditingController answerController;
  final TextEditingController explanationController;
  final TextEditingController tagsController;

  const CardFormFields({
    super.key,
    required this.questionController,
    required this.answerController,
    required this.explanationController,
    required this.tagsController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          maxLines: 3,
          minLines: 2,
          autocorrect: true,
          controller: questionController,
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
          controller: answerController,
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
          controller: explanationController,
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
          controller: tagsController,
          decoration: const InputDecoration(
            labelText: 'タグ',
            hintText: 'タグ1, タグ2, タグ3（カンマ区切り）',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            prefixIcon: Icon(Icons.label_outline),
          ),
        ),
      ],
    );
  }
}
