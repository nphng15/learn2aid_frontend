import 'package:get/get.dart';
import '../auth/login/login_controller.dart';

class ProfileController extends GetxController {
  final LoginController loginController = Get.find<LoginController>();

  // Observable variables cho thông tin profile
  var userEmail = ''.obs;
  var userName = ''.obs;
  var userPhotoUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Lấy thông tin từ LoginController
    userEmail.value = loginController.googleUserEmail.value;
    userName.value = loginController.googleUserName.value;
    userPhotoUrl.value = loginController.googleUserPhotoUrl.value;
  }

  Future<void> logout() async {
    await loginController.logout();
  }
} 