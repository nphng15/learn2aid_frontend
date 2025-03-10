import 'package:flutter/material.dart';
import 'dashboard_card.dart';

class DashboardSection extends StatelessWidget {
  final String title;
  const DashboardSection({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(2, (_) => 
              DashboardCard(cardWidth: (screenWidth - 48) / 2),
            ),
          ),
        ],
      ),
    );
  }
}
