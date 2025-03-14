import 'package:get/get.dart';
import '../../../domain/entities/video.dart';
import '../../../domain/usecases/video/pick_video.dart';
import '../../../domain/usecases/video/record_video.dart';

class VideoController extends GetxController {
  final PickVideoUseCase pickVideoUseCase;
  final RecordVideoUseCase recordVideoUseCase;
  
  VideoController({
    required this.pickVideoUseCase,
    required this.recordVideoUseCase,
  });

  Rx<Video?> selectedVideo = Rx<Video?>(null);
  RxBool isRecording = false.obs;

  void pickVideo(String videoPath) {
    selectedVideo.value = Video(path: videoPath);
  }

  Future<void> startRecording() async {
    isRecording.value = true;
    print("🎬 Bắt đầu quay video...");
    Video? video = await recordVideoUseCase();
    if (video != null) {
      selectedVideo.value = video;
      print("Video đã quay xong: ${video.path}");
    } else {
      print("Không thể quay video.");
    }
    isRecording.value = false;
  }
}
