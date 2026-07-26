import 'dart:async';

import 'package:ankicards/repository/flash_card_repository.dart';
import 'package:ankicards/repository/flashCard.dart';
import 'package:ankicards/repository/tag_repository.dart';
import 'package:ankicards/screens/create_page.dart';
import 'package:ankicards/screens/edit_page.dart';
import 'package:ankicards/widget/cardContainer.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final CardRepository _cardRepository = CardRepository();
  final TagRepository _tagRepository = TagRepository();
  final TextEditingController _searchController = TextEditingController();

  List<FlashCard> _cards = [];
  List<Tag> _allTags = [];
  final Set<int> _selectedTagIds = {};
  bool _initialLoading = true;
  String? _error;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _initialize();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _initialize() async {
    final tags = await _tagRepository.getAllTags();
    if (mounted) setState(() => _allTags = tags);
    await _loadCards();
  }

  Future<void> _reloadAll() async {
    final tags = await _tagRepository.getAllTags();
    if (mounted) setState(() => _allTags = tags);
    await _loadCards();
  }

  void _onSearchChanged() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), _loadCards);
  }

  Future<void> _loadCards() async {
    try {
      final cards = await _cardRepository.searchAndFilterCards(
        keyword: _searchController.text.trim(),
        tagIds: _selectedTagIds.toList(),
      );
      if (mounted) {
        setState(() {
          _cards = cards;
          _initialLoading = false;
          _error = null;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _initialLoading = false;
        });
      }
    }
  }

  void _toggleTag(int tagId) {
    setState(() {
      if (_selectedTagIds.contains(tagId)) {
        _selectedTagIds.remove(tagId);
      } else {
        _selectedTagIds.add(tagId);
      }
    });
    _loadCards();
  }

  Future<void> _addCard(CardDraft newCard) async {
    await _cardRepository.addCard(newCard);
    await _reloadAll();
  }

  Future<void> _deleteCard(int id) async {
    await _cardRepository.deleteCard(id);
    await _loadCards();
  }

  Future<void> _updateCard(FlashCard flashCard) async {
    final updateResult = await Navigator.push<EditCardResult>(
      context,
      MaterialPageRoute(builder: (_) => EditPage(card: flashCard)),
    );

    if (updateResult != null) {
      await _cardRepository.updateCardWithTags(
        flashCard: updateResult.card,
        tagNames: updateResult.tagNames,
      );
      await _reloadAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _SearchBar(controller: _searchController),
            if (_allTags.isNotEmpty)
              _TagFilterRow(
                tags: _allTags,
                selectedTagIds: _selectedTagIds,
                onTagToggle: _toggleTag,
              ),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('作成'),
        icon: const Icon(Icons.edit),
        onPressed: () async {
          final newCard = await Navigator.push<CardDraft>(
            context,
            MaterialPageRoute(builder: (_) => const CreatePage()),
          );
          if (newCard != null) await _addCard(newCard);
        },
      ),
    );
  }

  Widget _buildBody() {
    if (_initialLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(child: Text('Error: $_error'));
    }
    if (_cards.isEmpty) {
      return const Center(child: Text('カードがありません'));
    }
    return ListView.builder(
      itemCount: _cards.length,
      itemBuilder: (context, index) {
        final card = _cards[index];
        return CardContainer(
          question: card.question,
          answer: card.answer,
          explanation: card.explanation,
          isCorrect: card.isCorrect,
          tags: card.tags.toList(),
          deleteCard: (_) => _deleteCard(card.id),
          cardTap: (_) => _updateCard(card),
        );
      },
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;

  const _SearchBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: '検索...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: ValueListenableBuilder(
            valueListenable: controller,
            builder: (_, value, __) => value.text.isEmpty
                ? const SizedBox.shrink()
                : IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: controller.clear,
                  ),
          ),
          filled: true,
          fillColor: colorScheme.surfaceContainer,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        ),
      ),
    );
  }
}

class _TagFilterRow extends StatelessWidget {
  final List<Tag> tags;
  final Set<int> selectedTagIds;
  final void Function(int) onTagToggle;

  const _TagFilterRow({
    required this.tags,
    required this.selectedTagIds,
    required this.onTagToggle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: tags.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final tag = tags[index];
          final selected = selectedTagIds.contains(tag.id);
          return FilterChip(
            label: Text(tag.name),
            selected: selected,
            onSelected: (_) => onTagToggle(tag.id),
          );
        },
      ),
    );
  }
}
