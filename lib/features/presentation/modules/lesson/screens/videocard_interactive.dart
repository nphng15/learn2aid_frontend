import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../../features/data/models/video_model.dart';
import '../lesson_controller.dart';

class LessonInteractive extends StatefulWidget {
  const LessonInteractive({super.key});

  @override
  State<LessonInteractive> createState() => _LessonInteractiveState();
}

class _LessonInteractiveState extends State<LessonInteractive> {
  late final LessonController _lessonController;
  late final VideoModel _video;
  bool _isLoading = true;
  double _progress = 0.0;
  
  @override
  void initState() {
    super.initState();
    _lessonController = Get.find<LessonController>();
    
    // Lấy thông tin video từ arguments hoặc từ controller
    _video = Get.arguments?['video'];
    
    if (_video == null) {
      Get.back();
      return;
    }
    
    // Giả lập việc phát video và cập nhật tiến trình
    _simulateVideoProgress();
    
    // Thực hiện mở video trong trình duyệt
    _openVideoInBrowser();
  }
  
  void _simulateVideoProgress() {
    // Tính toán thời gian cập nhật dựa trên thời lượng video
    // Ví dụ: cập nhật tiến trình mỗi 5% thời lượng video
    final videoDurationInSeconds = _video.durationInSeconds;
    final updateInterval = (videoDurationInSeconds / 20).ceil(); // Chia thành 20 bước
    
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
      
      // Bắt đầu cập nhật tiến trình
      final timer = Stream.periodic(Duration(seconds: updateInterval), (i) => i);
      timer.take(20).listen((i) {
        final newProgress = (i + 1) / 20;
        setState(() {
          _progress = newProgress;
        });
        // Cập nhật tiến trình trong controller
        _lessonController.updateVideoProgress(_video.id, newProgress);
      });
    });
  }
  
  Future<void> _openVideoInBrowser() async {
    if (_video.videoUrl.isNotEmpty) {
      try {
        final Uri url = Uri.parse(_video.videoUrl);
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } catch (e) {
        Get.snackbar(
          'Lỗi',
          'Không thể mở video. Hãy thử lại sau.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Xem video: ${_video.title}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Thanh tiến trình
                LinearProgressIndicator(
                  value: _progress,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xff55c595)),
                  minHeight: 8,
                ),
                
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Hiển thị thông báo
                        const Icon(
                          Icons.ondemand_video,
                          size: 80,
                          color: Color(0xff215273),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Video đang được phát trong trình duyệt',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tiến trình xem: ${(_progress * 100).toInt()}%',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 32),
                        
                        // Nút mở lại video
                        ElevatedButton.icon(
                          onPressed: _openVideoInBrowser,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Mở lại video'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff215273),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                        ),
                        
                        if (_progress >= 1.0) ...[
                          const SizedBox(height: 24),
                          const Text(
                            'Bạn đã hoàn thành video này!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff55c595),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: () => Get.back(),
                            icon: const Icon(Icons.check_circle),
                            label: const Text('Quay lại bài học'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff55c595),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
} 