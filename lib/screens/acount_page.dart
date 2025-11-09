import 'package:flutter/material.dart';

class AcountPage extends StatelessWidget {
  const AcountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Center(
        child: Text("アカウント機能"),
      ),
    );
  }
}