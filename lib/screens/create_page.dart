import 'package:flutter/material.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[100],
        elevation: 0,
        title: const Text("Create new card"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          child: Column(
            children: [
              // question
              TextField(),
        
              // answer
              TextField(),
        
              // explation
              TextField(),
        
            ],
          )
        ),
      ),
    );
  }
}