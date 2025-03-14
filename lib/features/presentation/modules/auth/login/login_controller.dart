import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // Text controllers for email & password
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable states
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // This is just a placeholder function
  // You will add real API call in the future
  Future<void> loginUser() async {
    isLoading.value = true;
    errorMessage.value = '';

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // (Optional) Validate email & password here

    await Future.delayed(const Duration(seconds: 1)); // Fake delay

    // For now, let's just do a mock check
    if (email == 'test@gmail.com' && password == '123') {
      // Simulate success => Navigate to next screen
      // Remove keyboard focus
      Get.focusScope?.unfocus();

      // Replace with your real route
      Get.offNamed('/dashboard');
    } else {
      // Error => Show message
      errorMessage.value = 'Wrong email or password!';
    }

    isLoading.value = false;
  }
}
