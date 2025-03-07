import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../loading_controller.dart';
import '../widgets/loading_logo.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoadingController>();

    return Scaffold(
      appBar: AppBar(
        actions: [
          Obx(() => Switch(
                value: controller.isDark.value,
                onChanged: controller.toggleTheme,
              )),
          Obx(() => DropdownButton<double>(
                value: controller.widthFactor.value,
                onChanged: controller.changeWidthFactor,
                items: const [
                  DropdownMenuItem(value: 0.5, child: Text('Size: 50%')),
                  DropdownMenuItem(value: 0.75, child: Text('Size: 75%')),
                  DropdownMenuItem(value: 1.0, child: Text('Size: 100%')),
                ],
              )),
        ],
      ),
      body: Center(
        child: Obx(() => Container(
              width: MediaQuery.of(context).size.width * controller.widthFactor.value,
              child: const LoadingLogo(),
            )),
      ),
      backgroundColor: controller.isDark.value ? Colors.black : Colors.white,
    );
  }
}
