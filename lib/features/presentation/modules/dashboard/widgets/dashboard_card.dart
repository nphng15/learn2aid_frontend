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
        color: Colors.white,
        border: Border.all(color: const Color(0xff215273), width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
