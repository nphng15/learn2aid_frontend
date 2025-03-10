import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global_widgets/dashboard_navbar.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/dashboard_section.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(225, 255, 214, 1),
      body: SafeArea(
        child: Column(
          children: [
            const DashboardHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const DashboardSection(title: "For you"),
                    const DashboardSection(title: "In process"),
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
