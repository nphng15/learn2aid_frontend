import 'package:flutter/material.dart';

class QuizHeader extends StatelessWidget {
  const QuizHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Quiz',
        style: TextStyle(fontSize: 25, fontFamily: 'Space Mono'),
      ),
    );
  }
}
