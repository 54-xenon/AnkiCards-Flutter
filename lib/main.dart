import 'package:ankicards/screens/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AnkiCards',
      home: HomePage(),
      theme: ThemeData(
        // テーマのカラーを指定する
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.lightBlue[100],
          elevation: 0,
        )
      ),
    );
  }
}