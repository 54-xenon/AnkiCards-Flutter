import 'package:ankicards/screens/list_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('タップしてリストを表示'),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ListPage())),
        ),
      ),
    );
  }
}