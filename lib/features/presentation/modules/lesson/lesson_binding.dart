import 'package:get/get.dart';
import 'lesson_controller.dart';

class VideoBinding extends Bindings {
  @override
  void dependencies() {
    // Inject LessonController trực tiếp
    Get.put<LessonController>(LessonController());
  }
}
