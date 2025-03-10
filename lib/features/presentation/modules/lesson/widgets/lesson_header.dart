import 'package:flutter/material.dart';

class LessonHeader extends StatelessWidget {
  const LessonHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Lesson',
        style: TextStyle(fontSize: 25, fontFamily: 'Space Mono'),
      ),
    );
  }
}
