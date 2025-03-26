import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../domain/entities/video_analysis.dart';
import '../../../../domain/usecases/analyze_video_usecase.dart';
import '../../../../domain/usecases/save_analysis_result_usecase.dart';

class VideoAnalysisController extends GetxController {
  // Dependencies
  final AnalyzeVideoUseCase _analyzeVideoUseCase;
  final SaveAnalysisResultUseCase _saveAnalysisResultUseCase;
  final ImagePicker _picker = ImagePicker();
  
  VideoAnalysisController({
    AnalyzeVideoUseCase? analyzeVideoUseCase,
    SaveAnalysisResultUseCase? saveAnalysisResultUseCase,
  }) : _analyzeVideoUseCase = analyzeVideoUseCase ?? Get.find<AnalyzeVideoUseCase>(),
       _saveAnalysisResultUseCase = saveAnalysisResultUseCase ?? Get.find<SaveAnalysisResultUseCase>();
  
  // State variables
  final Rx<File?> videoFile = Rx<File?>(null);
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<VideoAnalysis?> analysisResult = Rx<VideoAnalysis?>(null);
  final RxString selectedMovementType = 'cpr'.obs; 
  
  // Chọn video từ thư viện
  Future<void> pickVideoFromGallery() async {
    try {
      final XFile? pickedFile = await _picker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(minutes: 5),
      );
      
      if (pickedFile != null) {
        videoFile.value = File(pickedFile.path);
        hasError.value = false;
        errorMessage.value = '';
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Không thể chọn video: $e';
    }
  }
  
  // Quay video mới
  Future<void> recordNewVideo() async {
    try {
      final XFile? pickedFile = await _picker.pickVideo(
        source: ImageSource.camera,
        maxDuration: const Duration(minutes: 5),
      );
      
      if (pickedFile != null) {
        videoFile.value = File(pickedFile.path);
        hasError.value = false;
        errorMessage.value = '';
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Không thể quay video: $e';
    }
  }
  
  // Phân tích video
  Future<void> analyzeVideo() async {
    if (videoFile.value == null) {
      hasError.value = true;
      errorMessage.value = 'Vui lòng chọn video trước khi phân tích';
      return;
    }
    
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';
      
      // Gọi usecase để phân tích video với loại phong trào được chọn
      final result = await _analyzeVideoUseCase.execute(
        videoFile.value!,
        movementType: selectedMovementType.value,
      );
      analysisResult.value = result;
      
      // Lưu kết quả phân tích
      await _saveAnalysisResultUseCase.execute(result);
      
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Lỗi khi phân tích video: $e';
    } finally {
      isLoading.value = false;
    }
  }
  
  // Reset state
  void resetState() {
    videoFile.value = null;
    hasError.value = false;
    errorMessage.value = '';
    analysisResult.value = null;
    // Không reset selectedMovementType để giữ nguyên lựa chọn của người dùng
  }
} 