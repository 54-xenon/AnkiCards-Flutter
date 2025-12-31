import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.amber[100],
          ),
          child: Center(
            child: Text("設定ページ"),
          ),
        ),
      ),
    );
  }
}