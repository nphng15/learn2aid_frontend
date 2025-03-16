import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../../config/routes/app_routes.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // Text controllers for email & password
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable states
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var authToken = ''.obs;

  // Đăng nhập với email & password (nếu có)
  Future<void> loginUser() async {
    isLoading.value = true;
    errorMessage.value = '';

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      authToken.value = (await userCredential.user!.getIdToken())!;
      // authToken.value = await userCredential.user!.getIdToken();
      Get.offAllNamed(AppRoutes.dashboard);
    } catch (e) {
      errorMessage.value = 'Login failed: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // Đăng nhập với Google
  Future<void> loginWithGoogle() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        isLoading.value = false;
        return; // Người dùng hủy đăng nhập
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      authToken.value = (await userCredential.user!.getIdToken())!;
      // authToken.value = await userCredential.user!.getIdToken();
      Get.offAllNamed(AppRoutes.dashboard);
    } catch (e) {
      errorMessage.value = 'Google login failed: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // Đăng xuất
  Future<void> logout() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
    authToken.value = '';
    Get.offAllNamed(AppRoutes.login);
  }
}

