import 'package:get/get.dart';
import 'video_controller.dart';

class VideoBinding extends Bindings {
  @override
  void dependencies() {
    // Inject VideoController trực tiếp
    Get.put<VideoController>(VideoController());
  }
}
