import 'package:flutter/material.dart';
import '../../../global_widgets/dashboard_navbar.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/dashboard_section.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const DashboardHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Section video đề xuất cho người dùng
                    const DashboardSection(
                      title: "For you",
                      sectionType: "for_you",
                    ),
                    
                    // Section video đang xem dở
                    const DashboardSection(
                      title: "In progress",
                      sectionType: "in_progress",
                    ),
                  ],
                ),
              ),
            ),
            const DashboardNavBar(),
          ],
        ),
      ),
    );
  }
}
