import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../config/theme/app_color.dart';
import '../../profile/screens/profile_screen.dart';
import '../../auth/login/login_controller.dart';

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
    final LoginController loginController = Get.find<LoginController>();
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.menu, size: 24),
              GestureDetector(
                onTap: () {
                  Get.to(() => const ProfileScreen());
                },
                child: Obx(() => CircleAvatar(
                  radius: 20,
                  backgroundImage: loginController.googleUserPhotoUrl.value.isNotEmpty
                      ? NetworkImage(loginController.googleUserPhotoUrl.value)
                      : null,
                  backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
                  child: loginController.googleUserPhotoUrl.value.isEmpty
                      ? const Icon(Icons.person, color: AppColors.secondary)
                      : null,
                )),
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