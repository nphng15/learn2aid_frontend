import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import '../../domain/entities/video.dart';
import '../../domain/repositories/video_repository.dart';

class VideoRepositoryImpl implements VideoRepository {
  final ImagePicker _picker = ImagePicker();
  CameraController? _cameraController;

  @override
  Future<Video?> pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      return Video(path: pickedFile.path);
    }
    return null;
  }

  @override
  Future<Video?> recordVideo() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(cameras.first, ResolutionPreset.medium);
    await _cameraController!.initialize();

    await _cameraController!.startVideoRecording();
    await Future.delayed(const Duration(seconds: 5)); // Giả lập quay 5s
    XFile videoFile = await _cameraController!.stopVideoRecording();

    return Video(path: videoFile.path);
  }
}
