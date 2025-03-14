import 'package:flutter/material.dart';
import '../../../global_widgets/dashboard_navbar.dart';
import '../widgets/quiz_header.dart';
import '../widgets/quiz_content.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(225, 255, 214, 1),
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
                  physics: BouncingScrollPhysics(),
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
