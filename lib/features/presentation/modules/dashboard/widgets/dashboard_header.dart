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
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF2A6F97)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Icon(Icons.search, size: 20, color: Color(0xFF2A6F97)),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search...',
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find<LoginController>();
    // Lấy tên người dùng từ tài khoản Google
    final String displayName = loginController.googleUserName.value.isNotEmpty
        ? _getFirstName(loginController.googleUserName.value)
        : "Name";
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.menu, size: 24, color: Color(0xFF2A6F97)),
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
          const SizedBox(height: 16),
          Text(
            "Hello, $displayName!",
            style: const TextStyle(
              fontSize: 28, 
              fontWeight: FontWeight.bold,
              fontFamily: 'Lexend',
              color: Color(0xFF2A6F97),
            ),
          ),
          Row(
            children: [
              Expanded(child: searchField()),
              const SizedBox(width: 8),
              Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                  color: const Color(0xff55c595),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    _showFilterDialog(context);
                  },
                  child: const Icon(
                    Icons.filter_list,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  // Hàm lấy first name từ full name
  String _getFirstName(String fullName) {
    if (fullName.isEmpty) return "Name";
    final nameParts = fullName.split(' ');
    return nameParts.first;
  }
  
  // Hiển thị dialog cho filter
  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            'Lọc bài học',
            style: TextStyle(
              color: Color(0xFF2A6F97),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildFilterOption('Tất cả bài học', context),
              const Divider(height: 1),
              _buildFilterOption('Đã hoàn thành', context),
              const Divider(height: 1),
              _buildFilterOption('Đang học', context),
              const Divider(height: 1),
              _buildFilterOption('Chưa bắt đầu', context),
              const Divider(height: 1),
              _buildFilterOption('Theo chủ đề', context),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF2A6F97),
              ),
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }
  
  // Widget tạo option trong filter
  Widget _buildFilterOption(String title, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        Get.snackbar(
          'Thông báo',
          'Đã chọn lọc: $title',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xff55c595),
          colorText: Colors.white,
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF2A6F97),
          ),
        ),
      ),
    );
  }
}