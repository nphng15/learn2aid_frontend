import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../config/theme/app_color.dart';
import '../profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.secondary),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20 / 932 * screenHeight),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar
              Obx(() => CircleAvatar(
                radius: 50,
                backgroundImage: profileController.userPhotoUrl.value.isNotEmpty
                    ? NetworkImage(profileController.userPhotoUrl.value)
                    : null,
                child: profileController.userPhotoUrl.value.isEmpty
                    ? const Icon(Icons.person, size: 50, color: AppColors.secondary)
                    : null,
              )),
              
              SizedBox(height: 20 / 932 * screenHeight),
              
              // Tên người dùng
              Obx(() => Text(
                profileController.userName.value,
                style: GoogleFonts.lexend(
                  fontSize: 24 / 932 * screenHeight,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                ),
              )),
              
              SizedBox(height: 10 / 932 * screenHeight),
              
              // Email
              Obx(() => Text(
                profileController.userEmail.value,
                style: GoogleFonts.lexend(
                  fontSize: 16 / 932 * screenHeight,
                  color: AppColors.grey3,
                ),
              )),
              
              SizedBox(height: 40 / 932 * screenHeight),
              
              // Các thông tin khác có thể thêm ở đây
              
              // Nút đăng xuất
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => profileController.logout(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error,
                    padding: EdgeInsets.symmetric(vertical: 15 / 932 * screenHeight),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Đăng xuất',
                    style: GoogleFonts.lexend(
                      fontSize: 16 / 932 * screenHeight,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 