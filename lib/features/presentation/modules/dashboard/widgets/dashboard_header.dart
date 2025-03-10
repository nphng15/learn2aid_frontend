import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  Widget searchField() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(217, 217, 217, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search...',
                  hintStyle: TextStyle(fontSize: 14),
                ),
            ),
            )
          ),
          Icon(Icons.search, size: 20),
        ],
      ),
    );
  }

      @override
      Widget build(BuildContext context) {
        return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.menu, size: 24),
              CircleAvatar(
                backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
                radius: 20,
              ),
            ],
          ),
          const SizedBox(height: 8),
          searchField(),
        ],
      ),
    );
  }
}