import 'package:ankicards/screens/edit_page.dart';
import 'package:flutter/material.dart';
import 'package:ankicards/collections/flashCard.dart';
import 'package:ankicards/collections/flash_card_repository.dart';
import 'package:ankicards/screens/create_page.dart';
import 'package:ankicards/widget/cardCotainer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CardRepository _cardRepository = CardRepository();
  late Future<List<FlashCard>> _flashCardsFuture;

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  void _loadCards() {
    _flashCardsFuture = _cardRepository.getAllCards();
  }

  Future<void> _addCard(List newCard) async {
    await _cardRepository.addCard(newCard);
    setState(() {
      _loadCards();
    });
  }

  Future<void> _deleteCard(int id) async {
    await _cardRepository.deleteCard(id);
    setState(() {
      _loadCards();
    });
  }

  Future<void> _updateCard(FlashCard flashCard) async {
    final updateCard = await Navigator.push<FlashCard>(
      context,
      MaterialPageRoute(builder: (_) => EditPage(card: flashCard)),
    );

    if (updateCard != null) {
      await _cardRepository.updateCard(updateCard);
      setState(() {
        _loadCards();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: FutureBuilder<List<FlashCard>>(
        future: _flashCardsFuture,
        builder: (context, snapshot) {
          // ① ローディング中
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // ② エラー
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // ③ データなし
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('カードがありません'));
          }
          // ④ データあり
          final cards = snapshot.data!;

          return ListView.builder(
            itemCount: cards.length,
            itemBuilder: (context, index) {
              final card = cards[index];
              return Cardcotainer(
                question: card.question,
                answer: card.answer,
                explanation: card.explanation,
                deleteCard: (_) => _deleteCard(card.id),
                cardTap: (_) => _updateCard(card),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final newCard = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreatePage()),
          );

          if (newCard != null) {
            await _addCard(newCard);
          }
        },
      ),
    );
  }
}
