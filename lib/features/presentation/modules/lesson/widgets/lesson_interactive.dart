import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:learn2aid/features/presentation/controller/video/video_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class LessonInteractive extends StatefulWidget {
  const LessonInteractive({super.key});

  @override
  _LessonInteractiveState createState() => _LessonInteractiveState();
}

class _LessonInteractiveState extends State<LessonInteractive> {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  bool _isRecording = false;
  late List<CameraDescription> cameras;
  CameraDescription? selectedCamera;
  final VideoController controller = Get.find<VideoController>();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  /// 🔹 **Khởi tạo Camera**
  Future<void> _initializeCamera({bool useFrontCamera = true}) async {
    if (await Permission.camera.request().isGranted &&
        await Permission.microphone.request().isGranted &&
        await Permission.storage.request().isGranted) {
      try {
        cameras = await availableCameras();

        selectedCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == (useFrontCamera ? CameraLensDirection.front : CameraLensDirection.back),
          orElse: () => cameras.first,
        );

        _cameraController = CameraController(
          selectedCamera!,
          ResolutionPreset.high,
          enableAudio: true,
        );

        await _cameraController!.initialize();
        setState(() => _isCameraInitialized = true);
      } catch (e) {
        _showErrorDialog("Lỗi khi mở camera: $e");
      }
    } else {
      _showErrorDialog("Không có quyền truy cập Camera hoặc Bộ nhớ!");
    }
  }

  /// 🔹 **Mở Camera Popup giống Messenger**
  void _openCameraPopup() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.white, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    "Quay Video",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.switch_camera, color: Colors.white, size: 28),
                    onPressed: () {
                      _initializeCamera(useFrontCamera: selectedCamera!.lensDirection == CameraLensDirection.back);
                    },
                  ),
                ],
              ),

              Expanded(
                child: _isCameraInitialized
                    ? CameraPreview(_cameraController!)
                    : const Center(child: CircularProgressIndicator(color: Colors.white)),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: GestureDetector(
                  onTap: _isRecording ? _stopRecording : _startRecording,
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      color: _isRecording ? Colors.red : Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// 🔹 **Bắt đầu quay video**
  Future<void> _startRecording() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      _showErrorDialog("Camera chưa được khởi tạo!");
      return;
    }
    try {
      await _cameraController!.prepareForVideoRecording();
      await _cameraController!.startVideoRecording();
      setState(() => _isRecording = true);
      print("🎥 Đang quay video...");
    } catch (e) {
      _showErrorDialog("Không thể bắt đầu quay video: $e");
    }
  }

  /// 🔹 **Dừng quay video và lưu vào thư viện**
  Future<void> _stopRecording() async {
    if (_cameraController == null || !_cameraController!.value.isRecordingVideo) return;
    try {
      XFile videoFile = await _cameraController!.stopVideoRecording();
      setState(() => _isRecording = false);

      await _saveVideoToGallery(videoFile.path);

      _showSuccessDialog("Video đã được lưu vào thư viện!");
      Navigator.pop(context);
    } catch (e) {
      _showErrorDialog("Không thể dừng quay video: $e");
    }
  }

  /// 🔹 **Lưu video vào thư viện bằng MediaStore**
  Future<void> _saveVideoToGallery(String videoPath) async {
    try {
      if (Platform.isAndroid) {
        final Directory? directory = await getExternalStorageDirectory();
        if (directory != null) {
          final String newPath = "${directory.path}/video_${DateTime.now().millisecondsSinceEpoch}.mp4";
          await File(videoPath).copy(newPath);
          print("✅ Video đã lưu: $newPath");
        } else {
          print("❌ Lỗi: Không tìm thấy thư mục lưu trữ.");
        }
      } else if (Platform.isIOS) {
        // Dành cho iOS (Sử dụng Photos Framework)
        await Process.run('osascript', ['-e', 'do shell script "mv $videoPath ~/Movies/"']);
        print("✅ Video đã lưu vào thư viện trên iOS.");
      }
    } catch (e) {
      print("❌ Lỗi khi lưu video: $e");
    }
  }

  /// 🔹 **Hiển thị thông báo lỗi**
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Lỗi"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  /// 🔹 **Hiển thị thông báo thành công**
  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Thành công"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: _openCameraPopup,
          icon: const Icon(Icons.videocam, color: Colors.white),
          label: const Text("Mở Camera", style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }
}
