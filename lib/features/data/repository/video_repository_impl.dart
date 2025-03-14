import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import '../../domain/entities/video.dart';
import '../../domain/repositories/video_repository.dart';

class VideoRepositoryImpl implements VideoRepository {
  final ImagePicker _picker = ImagePicker();
  CameraController? _cameraController;
  bool _isInitialized = false;

  @override
  Future<Video?> pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      return Video(path: pickedFile.path);
    }
    return null;
  }

  Future<void> _initializeCamera() async {
    if (!_isInitialized) {
      try {
        final cameras = await availableCameras();

        // 🔹 Chọn camera trước thay vì camera sau
        CameraDescription? frontCamera;
        for (var camera in cameras) {
          if (camera.lensDirection == CameraLensDirection.front) {
            frontCamera = camera;
            break;
          }
        }

        if (frontCamera == null) {
          print("❌ Không tìm thấy camera trước!");
          return;
        }

        _cameraController = CameraController(
          frontCamera,
          ResolutionPreset.medium,
          enableAudio: true,
        );

        await _cameraController!.initialize();
        _isInitialized = true;
      } catch (e) {
        print("⚠️ Lỗi khi khởi tạo CameraController: $e");
      }
    }
  }

  @override
  Future<Video?> recordVideo() async {
    await _initializeCamera();

    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      print("❌ Camera chưa sẵn sàng!");
      return null;
    }

    try {
      await _cameraController!.prepareForVideoRecording();
      await _cameraController!.startVideoRecording();
      await Future.delayed(const Duration(seconds: 5)); // Quay trong 5 giây
      XFile videoFile = await _cameraController!.stopVideoRecording();
      return Video(path: videoFile.path);
    } catch (e) {
      print("❌ Lỗi khi quay video: $e");
      return null;
    }
  }
}
