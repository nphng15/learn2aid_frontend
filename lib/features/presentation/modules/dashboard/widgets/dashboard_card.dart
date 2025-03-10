import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final double cardWidth;
  const DashboardCard({super.key, required this.cardWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      height: cardWidth * 1.2, // tỷ lệ chiều cao có thể thay đổi tùy thích
      decoration: BoxDecoration(
        color: const Color.fromRGBO(217, 217, 217, 1),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
