import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/routes/app_routes.dart';

class DashboardNavBar extends StatelessWidget {
  const DashboardNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 82,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(239, 239, 239, 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          circleNavButton(
            onTap: () => Get.offNamed(AppRoutes.dashboard),
            isActive: Get.currentRoute == AppRoutes.dashboard,
          ),
          circleNavButton(
            onTap: () => Get.offNamed(AppRoutes.lesson),
            isActive: Get.currentRoute == AppRoutes.lesson,
          ),
          circleNavButton(
            onTap: () => Get.offNamed(AppRoutes.quiz),
            isActive: Get.currentRoute == AppRoutes.quiz,
          ),
          circleNavButton(
            onTap: () {}, // Placeholder cho chức năng khác
            isActive: false,
          ),
        ],
      ),
    );
  }

  Widget circleNavButton({VoidCallback? onTap, bool isActive = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: isActive
              ? const Color.fromRGBO(33, 82, 115, 1) // Màu active
              : const Color.fromRGBO(217, 217, 217, 1), // Màu inactive
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
