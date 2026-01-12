import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CardContainer extends StatelessWidget {
  final String question;
  final String answer;
  final String explanation;
  final bool? isCorrect;
  final Function(BuildContext) deleteCard;
  final Function(BuildContext) cardTap;

  const CardContainer({
    super.key,
    required this.question,
    required this.answer,
    required this.explanation,
    required this.isCorrect,
    required this.deleteCard,
    required this.cardTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: deleteCard,
              backgroundColor: colorScheme.error,
              foregroundColor: colorScheme.onError,
              borderRadius: BorderRadius.circular(16),
              icon: Icons.delete,
            ),
          ],
        ),
        child: SizedBox(
          // Slidabelを使用すると、何故か横幅が小さくなるからその対策として、double.infinity(限界まで横幅を大きくする)
          width: double.infinity,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: colorScheme.surfaceContainer,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => cardTap(context),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 問題文（最重要）
                    Text(
                      question,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    /// 答え
                    Text(
                      answer,
                    ),
          
                    if (explanation.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        explanation,
                      ),
                    ],
                    const SizedBox(height: 12),
          
                    /// 前回の結果
                    if (isCorrect != null) 
                      Align(
                        alignment: Alignment.centerRight,
                        child: _ResultChip(isCorrect: isCorrect!),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ResultChip extends StatelessWidget {
  final bool isCorrect;

  const _ResultChip({required this.isCorrect});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Chip(
      avatar: Icon(
        isCorrect ? Icons.check : Icons.close,
        size: 16,
        color: isCorrect ? colorScheme.primary : colorScheme.error,
      ),
      label: Text(isCorrect ? '正解' : '不正解'),
      backgroundColor:
          isCorrect ? colorScheme.primaryContainer : colorScheme.errorContainer,
    );
  }
}
