import 'package:flutter/material.dart';
import 'dashboard_card.dart';

class DashboardSection extends StatelessWidget {
  final String title;
  const DashboardSection({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.45; 

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontFamily: 'Lexend'),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: cardWidth * 1.2, // Chiều cao của ListView
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: 5,
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                return DashboardCard(cardWidth: cardWidth);
              },
            ),
          ),
        ],
      ),
    );
  }
}
