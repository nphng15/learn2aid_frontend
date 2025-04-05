import 'package:get/get.dart';
import '../../../../features/data/models/video_model.dart';
import '../../../../features/data/services/video_service.dart';
import '../dashboard/video_controller.dart';

class LessonController extends GetxController {
  final VideoService _videoService = VideoService();
  late final VideoController _videoController;
  
  final RxBool isLoading = false.obs;
  final RxString currentTab = 'content'.obs;
  
  @override
  void onInit() {
    super.onInit();
    _videoController = Get.find<VideoController>();
  }
  
  //cập nhật tiến trình xem video
  void updateVideoProgress(String videoId, double progress) {
    _videoController.updateVideoProgress(videoId, progress);
  }
  
  //đánh dấu video đã hoàn thành
  void markVideoAsCompleted(String videoId) {
    _videoController.updateVideoProgress(videoId, 1.0);
  }
  
  //lấy video tiếp theo cùng danh mục
  Future<VideoModel?> getNextVideoInCategory(String currentVideoId, String category) async {
    isLoading.value = true;
    try {
      final videos = await _videoService.getVideosByCategory(category);
      isLoading.value = false;
      
      // Tìm vị trí của video hiện tại
      final currentIndex = videos.indexWhere((video) => video.id == currentVideoId);
      if (currentIndex != -1 && currentIndex < videos.length - 1) {
        // Trả về video tiếp theo nếu có
        return videos[currentIndex + 1];
      }
      return null;
    } catch (e) {
      isLoading.value = false;
      return null;
    }
  }
} 