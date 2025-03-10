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
            style: TextStyle(fontSize: 18, fontFamily: 'Lexend'),
          ),
          const SizedBox(height: 8),
          Expanded(
            flex: 4, 
            child: placeholderBox(),
          ),
          const SizedBox(height: 8),
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontFamily: 'Nunito Sans'),
          ),
          const SizedBox(height: 8),
          Expanded(
            flex: 3, 
            child: gridAnswers(),
          ),
        ],
      ),
    );
  }

  Widget placeholderBox() {
    return Container(
      width: double.infinity,
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
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 2.5, // Điều chỉnh tỷ lệ để không bị méo
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(217, 217, 217, 1),
            borderRadius: BorderRadius.circular(10),
          ),
        );
      },
    );
  }
}
