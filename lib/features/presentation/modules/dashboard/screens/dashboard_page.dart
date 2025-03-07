import 'package:flutter/material.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/dashboard_section.dart';
import '../widgets/dashboard_navbar.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(225, 255, 214, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 100),
            const DashboardHeader(),
            const DashboardSection(title: "For you"),
            const DashboardSection(title: "In process"),
            const SizedBox(height: 20),
            const DashboardNavBar(),
          ],
        ),
      ),
    );
  }
}
