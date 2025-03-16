import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../loading_controller.dart';

class LoadingScreen extends GetView<LoadingController> {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Nền trắng
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Phần dấu cộng
              // Thay Icon(...) bằng Image.asset(...) khi có file ảnh
              Container(
                width: 150,
                height: 150,
                child: Image.asset('lib/assets/learn2aid.png')
              ),
              const SizedBox(height: 20),

              // 4 dots
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    bool isActive = (controller.currentDot.value == index);
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: isActive ? const Color(0xFF55C595) : Colors.black26,
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                );
              }),
              const SizedBox(height: 20),
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Learn',
                      style: TextStyle(
                        color: Color(0xFF215273),
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '2',
                      style: TextStyle(
                        color: Color(0xFF55C595), 
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Aid',
                      style: TextStyle(
                        color: Color(0xFF215273),
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
