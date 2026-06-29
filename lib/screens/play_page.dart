import 'package:ankicards/controller/play_controller.dart';
import 'package:ankicards/screens/resultPage.dart';
import 'package:flutter/material.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({super.key});

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  final PlayController _controller = PlayController();
  bool _isLoading = true;
  bool _showAnswer = false;

  Future<void> _initialize() async {
    await _controller.initialize();
    if (!mounted) return;
    if (_controller.totalQuestionCount == 0) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('先にカードを追加してください')),
      );
      return;
    }
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _answer(bool isCorrect) async {
    await _controller.answer(isCorrect);
    if (!mounted) return;
    if (_controller.isFinished) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Resultpage(result: _controller.getResult()),
        ),
      );
      return;
    }
    setState(() => _showAnswer = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final colorScheme = Theme.of(context).colorScheme;
    final progress = _controller.currentQuestionCount / _controller.totalQuestionCount;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          '${_controller.currentQuestionCount} / ${_controller.totalQuestionCount}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            borderRadius: BorderRadius.zero,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            children: [
              // カード
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _showAnswer = !_showAnswer),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: _showAnswer
                          ? colorScheme.tertiaryContainer
                          : colorScheme.surfaceContainer,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          // Q / A ラベル
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _showAnswer
                                    ? colorScheme.tertiary
                                    : colorScheme.primary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                _showAnswer ? '回答' : '質問',
                                style: TextStyle(
                                  color: _showAnswer
                                      ? colorScheme.onTertiary
                                      : colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          // カード本文
                          Expanded(
                            child: Center(
                              child: Text(
                                _showAnswer
                                    ? _controller.currentCard.answer
                                    : _controller.currentCard.question,
                                style: const TextStyle(fontSize: 24),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          // ヒント
                          if (!_showAnswer)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.touch_app_outlined,
                                  size: 16,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'タップして答えを確認',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 回答ボタン
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () => _answer(false),
                      icon: const Icon(Icons.close_rounded),
                      label: const Text(
                        '分からない',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(0, 60),
                        backgroundColor: colorScheme.errorContainer,
                        foregroundColor: colorScheme.onErrorContainer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () => _answer(true),
                      icon: const Icon(Icons.check_rounded),
                      label: const Text(
                        '分かった',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(0, 60),
                        backgroundColor: colorScheme.primaryContainer,
                        foregroundColor: colorScheme.onPrimaryContainer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
