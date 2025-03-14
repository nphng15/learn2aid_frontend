import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn2aid/config/routes/app_routes.dart';
import 'package:learn2aid/config/theme/app_color.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get device size to make it responsive
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Stack(
          children: [
            // Blue background covering the screen
            Container(
              width: screenWidth,
              height: screenHeight,
              color: AppColors.backgroundBlue,
            ),

            // White box on top
            Positioned(
              top: 0.257 * screenHeight,
              left: 0,
              child: Container(
                width: 1.017 * screenWidth,
                height: 0.742 * screenHeight,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0.043 * screenHeight),
                    topRight: Radius.circular(0.043 * screenHeight),
                  ),
                ),
              ),
            ),

            // "Login" title
            Positioned(
              top: 0.315 * screenHeight,
              left: 0.125 * screenWidth,
              child: Text(
                'Login',
                style: GoogleFonts.lexend(
                  fontSize: 0.043 * screenHeight,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondary,
                ),
              ),
            ),

            // Our login form
            Positioned(
              top: 0.442 * screenHeight,
              left: 0.047 * screenWidth,
              child: LoginForm(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
            ),

            // Social login note
            Positioned(
              top: 0.7768 * screenHeight,
              left: 0.3784 * screenWidth,
              child: Text(
                '- Or login with -',
                style: GoogleFonts.lexend(
                  fontSize: 14 / 932 * screenHeight,
                  color: AppColors.grey3,
                ),
              ),
            ),

            // Social buttons row
            Positioned(
              top: 0.8261 * screenHeight,
              left: 0.172 * screenWidth,
              child: Row(
                children: [
                  _socialButton(screenWidth, screenHeight),
                  SizedBox(width: 0.038 * screenWidth),
                  _socialButton(screenWidth, screenHeight),
                  SizedBox(width: 0.038 * screenWidth),
                  _socialButton(screenWidth, screenHeight),
                ],
              ),
            ),

            // Register link
            Positioned(
              top: 0.9214 * screenHeight,
              left: 0.2364 * screenWidth,
              child: Row(
                children: [
                  Text(
                    'Don’t have an account? ',
                    style: GoogleFonts.lexend(
                      fontSize: 14 / 932 * screenHeight,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.offNamed(AppRoutes.register);
                    },
                    child: Text(
                      'Register',
                      style: GoogleFonts.lexend(
                        fontSize: 14 / 932 * screenHeight,
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Mock social login button
  Widget _socialButton(double screenWidth, double screenHeight) {
    return Container(
      width: 0.189 * screenWidth,
      height: 0.0429 * screenHeight,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.grey4,
          width: 0.5,
        ),
      ),
      child: Icon(
        Icons.ac_unit,
        size: 0.025 * screenHeight,
        color: AppColors.primary,
      ),
    );
  }
}
