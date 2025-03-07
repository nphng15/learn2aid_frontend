import 'package:flutter/material.dart';

class QuizContent extends StatelessWidget {
  const QuizContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '10/99',
            style: TextStyle(fontSize: 20, fontFamily: 'Lexend'),
          ),
          const SizedBox(height: 16),
          placeholderBox(height: 290),
          const SizedBox(height: 16),
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontFamily: 'Nunito Sans'),
          ),
          const SizedBox(height: 16),
          gridAnswers(),
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

  Widget gridAnswers() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        return Container(
          height: 184,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(217, 217, 217, 1),
            borderRadius: BorderRadius.circular(10),
          ),
        );
      },
    );
  }
}
