import 'package:flutter/material.dart';
import '../widgets/quiz_header.dart';
import '../widgets/quiz_content.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(225, 255, 214, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 100),
            const SizedBox(height: 20),
            const QuizContent(),
          ],
        ),
      ),
    );
  }
}
