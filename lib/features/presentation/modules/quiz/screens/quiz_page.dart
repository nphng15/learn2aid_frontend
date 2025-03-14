import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global_widgets/dashboard_navbar.dart';
import '../widgets/quiz_header.dart';
import '../widgets/quiz_content.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                // IconButton(
                //   icon: const Icon(Icons.arrow_back),
                //   onPressed: () => Get.back(),
                // ),
                const Expanded(child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      QuizHeader(),
                    ],
                  )
                ),
                )
              ],
            ),

            const SizedBox(height: 8),
            const Expanded(child: QuizContent()), // Sử dụng Expanded để tự scale
            const DashboardNavBar(), // Giữ Navbar cố định
          ],
        ),
      ),
    );
  }
}
