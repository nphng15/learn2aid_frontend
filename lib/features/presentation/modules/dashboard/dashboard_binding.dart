import 'package:get/get.dart';
import '../profile/profile_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    // Inject ProfileController trực tiếp
    Get.put<ProfileController>(ProfileController());
  }
}
