import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../features/data/models/video_model.dart';
import '../../../global_widgets/dashboard_navbar.dart';
import '../lesson_controller.dart';
import '../../../modules/dashboard/video_controller.dart';
import '../widgets/lesson_header.dart';
import '../widgets/lesson_content.dart';
import '../widgets/lesson_interactive.dart';

class LessonPage extends StatelessWidget {
  const LessonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LessonController lessonController = Get.find<LessonController>();
    final VideoController videoController = Get.find<VideoController>();
    final VideoModel? video = Get.arguments?['video'] ?? videoController.selectedVideo.value;

    return Scaffold(
      backgroundColor: Colors.white, 
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Get.back(),
                ),
                Expanded(
                  child: LessonHeader(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: PageView(
                controller: PageController(viewportFraction: 0.85),
                physics: const BouncingScrollPhysics(),
                children: [
                  // Trang 1: Thông tin và xem video
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        video != null 
                            ? LessonContent(
                                imageUrl: video.thumbnailUrl,
                                description: video.description,
                                durationInSeconds: video.durationInSeconds,
                                progress: videoController.getVideoProgress(video.id),
                                title: video.title,
                                category: video.category,
                                videoId: video.id,
                                videoUrl: video.videoUrl,
                                videoController: videoController,
                              )
                            : const LessonContent(),
                      ],
                    ),
                  ),
                  // Trang 2: Video tương tác
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LessonInteractive(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const DashboardNavBar(),
          ],
        ),
      ),
    );
  }
}
