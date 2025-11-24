import 'package:ankicards/screens/home_page.dart';
import 'package:flutter/material.dart';



// Hive(DBの初期化)
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AnkiCards',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // テーマのカラーを指定する
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.lightBlue[100],
          elevation: 0,
        ),
        // 背景色の指定
        scaffoldBackgroundColor: Colors.lightBlue[50],
        // floating ActionButton color
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.lightBlue[100],
        )
        // テーマの切り替え(Light/Dark)
      ),
    );
  }
}