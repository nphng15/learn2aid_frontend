import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/models/video_model.dart';
import '../../../data/services/video_service.dart';

class VideoController extends GetxController {
  final VideoService _videoService = VideoService();
  
  // Danh sách video
  final RxList<VideoModel> videos = <VideoModel>[].obs;
  final RxList<VideoModel> forYouVideos = <VideoModel>[].obs;
  final RxList<VideoModel> inProgressVideos = <VideoModel>[].obs;
  
  // Video đang được chọn
  final Rx<VideoModel?> selectedVideo = Rx<VideoModel?>(null);
  
  // Trạng thái xem video
  final RxMap<String, double> videoProgress = <String, double>{}.obs;
  
  // Trạng thái
  final RxBool isLoading = true.obs;
  final RxString selectedCategory = 'all'.obs;
  final RxString searchQuery = ''.obs;
  
  // FocusNode để quản lý focus của thanh tìm kiếm
  final FocusNode searchFocusNode = FocusNode();
  
  // Danh sách ID video đang xem dở (giả lập - trong ứng dụng thực tế sẽ lưu vào cơ sở dữ liệu)
  final RxList<String> inProgressVideoIds = <String>['video1', 'video2'].obs;

  @override
  void onInit() {
    super.onInit();
    loadVideos();
  }
  
  @override
  void onClose() {
    // Giải phóng FocusNode khi controller bị hủy
    searchFocusNode.dispose();
    super.onClose();
  }

  // Tải danh sách video
  Future<void> loadVideos() async {
    isLoading.value = true;
    try {
      if (selectedCategory.value == 'all') {
        videos.value = await _videoService.getAllVideos();
      } else {
        videos.value = await _videoService.getVideosByCategory(selectedCategory.value);
      }
      
      // Cập nhật danh sách video theo loại
      updateVideoLists();
    } catch (e) {
      print('Error loading videos: $e');
    } finally {
      isLoading.value = false;
    }
  }
  
  // Cập nhật các danh sách video dựa trên tìm kiếm và bộ lọc
  void updateVideoLists() {
    // Cập nhật danh sách "For you"
    forYouVideos.value = videos.where((video) {
      // Tìm kiếm trong tiêu đề video
      final searchMatch = searchQuery.isEmpty || 
                          video.title.toLowerCase().contains(searchQuery.value.toLowerCase());
      return searchMatch;
    }).toList();
    
    // Cập nhật danh sách "In progress" - video đang xem dở
    inProgressVideos.value = videos.where((video) {
      // Kiểm tra video có trong danh sách đang xem dở không
      final isInProgress = inProgressVideoIds.contains(video.id);
      
      // Tìm kiếm trong tiêu đề video
      final searchMatch = searchQuery.isEmpty || 
                           video.title.toLowerCase().contains(searchQuery.value.toLowerCase());
      
      return isInProgress && searchMatch;
    }).toList();
  }

  // Thay đổi danh mục được chọn
  void changeCategory(String category) {
    selectedCategory.value = category;
    loadVideos();
    
    // Xóa focus khỏi thanh tìm kiếm
    searchFocusNode.unfocus();
  }
  
  // Tìm kiếm video theo tên
  void searchVideos(String query) {
    searchQuery.value = query;
    updateVideoLists();
  }
  
  // Thêm video vào danh sách đang xem dở
  void addToInProgress(String videoId) {
    if (!inProgressVideoIds.contains(videoId)) {
      inProgressVideoIds.add(videoId);
      updateVideoLists();
    }
  }
  
  // Đặt video đang được chọn
  void setSelectedVideo(VideoModel video) {
    selectedVideo.value = video;
    // Thêm vào danh sách đang xem dở
    addToInProgress(video.id);
  }
  
  // Cập nhật tiến trình xem video
  void updateVideoProgress(String videoId, double progress) {
    videoProgress[videoId] = progress;
    // Nếu progress = 1.0 (100%), có thể đánh dấu video đã xem xong
    // Hoặc giữ nó trong danh sách đang xem dở
  }
  
  // Lấy tiến trình xem của video
  double getVideoProgress(String videoId) {
    return videoProgress[videoId] ?? 0.0;
  }

  // Thêm phương thức openVideo nếu chưa tồn tại
  void openVideo(String videoUrl, String videoId) async {
    try {
      // Cập nhật video đang xem
      addToInProgress(videoId);
      
      // Lấy tiến trình hiện tại
      final double currentProgress = getVideoProgress(videoId);
      
      // Sử dụng url_launcher để mở video
      final Uri url = Uri.parse(videoUrl);
      final bool canLaunch = await canLaunchUrl(url);
      
      if (canLaunch) {
        // Hiển thị snackbar thông báo mở video
        Get.snackbar(
          'Đang mở video',
          'Video đang được mở trong trình duyệt...',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
        
        await launchUrl(url, mode: LaunchMode.externalApplication);
        
        // Mô phỏng tiến trình xem video (thực tế sẽ dựa trên thời gian thực tế người dùng xem)
        // Tăng tiến trình lên 15-30% sau mỗi lần xem
        final random = DateTime.now().millisecondsSinceEpoch % 100 / 100; // Số ngẫu nhiên từ 0-1
        double newProgress = currentProgress + (0.15 + (0.15 * random));
        if (newProgress > 1.0) newProgress = 1.0;
        
        // Cập nhật tiến trình
        updateVideoProgress(videoId, newProgress);
        
        // Hiển thị thông báo sau khi thoát video
        Get.snackbar(
          'Cập nhật tiến trình',
          'Tiến trình xem: ${(newProgress * 100).toStringAsFixed(0)}%',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
          backgroundColor: const Color(0xff55c595).withOpacity(0.7),
          colorText: Colors.white,
        );
        
      } else {
        Get.snackbar(
          'Lỗi',
          'Không thể mở video. Vui lòng thử lại sau.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Đã xảy ra lỗi: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
} 