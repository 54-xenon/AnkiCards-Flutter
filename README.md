# ankicards

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

---
# AnkiCards-Flutter
AnkiCardsは、フラッシュカードを作成するときに面倒なことを軽減するために開発しました。煩わしいサインアップ、広告、ロックされた機能は存在しません！
AnkiCardsは以下の機能をサポートします。シンプルで本当に必要な機能に重点を置き、毎日使いたくなるようなデザインのアプリです。

# 機能(実装済み)
- カードの作成、編集、削除
- 出題機能
- 広告なし
- Material3のUI
- 継続したアップデート
- 結果の表示と保存
- Geminiによる、カードの解説を自動で生成
- アプリケーションのローカライズ(日本語環境への最適化)

# 間もなく登場
優先度順に並べてます。このほかにも改善してほしい所があれば、どんどんisue立ててください。できる限り対応したします。
- テーマの自動切り替え
- タグによる分類
- ダッシュボード
- iPadOSに最適化されたUI
- 高度な復習機能(忘却曲線に基づくリマインド機能)
- フォルダによってカードを整理

# ストアへのリリース
2026年中には、AppSotreでの公開を目指しています。

# ディレクトリ構成
```
.
├── controller
│   └── play_controller.dart
├── main.dart
├── repository
│   ├── flash_card_repository.dart
│   ├── flashCard.dart
│   ├── flashCard.g.dart
│   ├── isar_setup.dart
│   └── resultModel.dart
├── screens
│   ├── create_page.dart
│   ├── edit_page.dart
│   ├── home_page.dart
│   ├── list_page.dart
│   ├── play_page.dart
│   ├── resultPage.dart
│   └── setting_page.dart
└── widget
    ├── buttonContainer.dart
    └── cardCotainer.dart
```
