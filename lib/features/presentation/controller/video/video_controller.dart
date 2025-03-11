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

  Future<void> pickVideo() async {
    selectedVideo.value = await pickVideoUseCase();
  }

  Future<void> recordVideo() async {
    isRecording.value = true;
    selectedVideo.value = await recordVideoUseCase();
    isRecording.value = false;
  }
}
