import 'package:flutter/material.dart';
import '../../../global_widgets/dashboard_navbar.dart';
import '../widgets/lesson_header.dart';
import '../widgets/lesson_content.dart';
import '../widgets/lesson_interactive.dart';

class LessonPage extends StatelessWidget {
  const LessonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), 
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                // IconButton(
                //   icon: const Icon(Icons.arrow_back),
                //   onPressed: () => Get.back(),
                // ),
                const Expanded(child: LessonHeader()),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: PageView(
                controller: PageController(viewportFraction: 0.85),
                children: const [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LessonContent(),
                      SizedBox(height: 8),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LessonInteractive(),
                    ],
                  ),
                ],
              ),
            ),
            const DashboardNavBar(),
          ],
        ),
      ),
    );
  }
}
