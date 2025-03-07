import 'package:flutter/material.dart';

class LessonContent extends StatelessWidget {
  const LessonContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Section name',
            style: TextStyle(fontSize: 20, fontFamily: 'Lexend'),
          ),
          const Text(
            'Lesson name',
            style: TextStyle(fontSize: 40, fontFamily: 'Lexend'),
          ),
          const SizedBox(height: 16),
          placeholderBox(height: 480),
          const SizedBox(height: 16),
          descriptionSection(),
          playButton(),
        ],
      ),
    );
  }

  Widget placeholderBox({double height = 200}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(217, 217, 217, 1),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget descriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Description', style: TextStyle(fontSize: 26, fontFamily: 'Lexend')),
        const SizedBox(height: 8),
        const Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla facilisi.',
          style: TextStyle(fontSize: 13, fontFamily: 'Nunito Sans'),
        ),
      ],
    );
  }

  Widget playButton() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(237, 237, 237, 1),
          borderRadius: BorderRadius.circular(60),
        ),
        child: const Text('Play', style: TextStyle(fontSize: 16, fontFamily: 'Lexend')),
      ),
    );
  }
}
