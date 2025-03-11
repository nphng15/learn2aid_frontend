import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/video/video_controller.dart';

class LessonInteractive extends StatelessWidget {
  final VideoController controller = Get.find<VideoController>();

  LessonInteractive({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          if (controller.selectedVideo.value != null) {
            return Text("Video: ${controller.selectedVideo.value!.path}");
          }
          return Container();
        }),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: controller.recordVideo,
              icon: Obx(() => Icon(controller.isRecording.value ? Icons.stop : Icons.videocam)),
              label: Obx(() => Text(controller.isRecording.value ? "Stop" : "Record")),
            ),
            const SizedBox(width: 16),
            ElevatedButton.icon(
              onPressed: controller.pickVideo,
              icon: const Icon(Icons.upload_file),
              label: const Text("Upload"),
            ),
          ],
        ),
      ],
    );
  }
}
