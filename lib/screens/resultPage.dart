import 'package:ankicards/repository/resultModel.dart';
import 'package:flutter/material.dart';

class Resultpage extends StatelessWidget {
  final ResultModel result;
  const Resultpage({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final accuracy = result.total > 0
        ? (result.correct / result.total * 100).round()
        : 0;

    return Scaffold(
      body: SafeArea(
        child: PopScope(
          canPop: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              children: [
                const Spacer(),

                // タイトル
                Text(
                  '学習完了！',
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '今日もよく頑張りました 🎉',
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 40),

                // 正答率サークル
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.primaryContainer,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$accuracy%',
                        style: textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                      ),
                      Text(
                        '正答率',
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // スタッツカード
                Row(
                  children: [
                    _StatCard(
                      label: '正解',
                      value: '${result.correct}問',
                      icon: Icons.check_circle_outline,
                      color: colorScheme.primaryContainer,
                      onColor: colorScheme.onPrimaryContainer,
                    ),
                    const SizedBox(width: 12),
                    _StatCard(
                      label: '不正解',
                      value: '${result.wrong}問',
                      icon: Icons.cancel_outlined,
                      color: colorScheme.errorContainer,
                      onColor: colorScheme.onErrorContainer,
                    ),
                    const SizedBox(width: 12),
                    _StatCard(
                      label: '合計',
                      value: '${result.total}問',
                      icon: Icons.list_alt_outlined,
                      color: colorScheme.surfaceContainer,
                      onColor: colorScheme.onSurface,
                    ),
                  ],
                ),

                const Spacer(),

                FilledButton.icon(
                  onPressed: () =>
                      Navigator.popUntil(context, (route) => route.isFirst),
                  icon: const Icon(Icons.home_rounded),
                  label: const Text(
                    'ホームに戻る',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final Color onColor;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.onColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, color: onColor, size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: onColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: onColor),
            ),
          ],
        ),
      ),
    );
  }
}
