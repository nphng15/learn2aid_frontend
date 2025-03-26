import 'package:get/get.dart';
import '../controllers/video_analysis_controller.dart';
import '../../../../data/repositories/video_analysis_repository_impl.dart';
import '../../../../domain/usecases/analyze_video_usecase.dart';
import '../../../../domain/usecases/save_analysis_result_usecase.dart';

class VideoAnalysisBinding extends Bindings {
  @override
  void dependencies() {
    // Đăng ký repository
    Get.lazyPut<VideoAnalysisRepositoryImpl>(
      () => VideoAnalysisRepositoryImpl(),
    );
    
    // Đăng ký các use cases
    Get.lazyPut<AnalyzeVideoUseCase>(
      () => AnalyzeVideoUseCase(Get.find<VideoAnalysisRepositoryImpl>()),
    );
    
    Get.lazyPut<SaveAnalysisResultUseCase>(
      () => SaveAnalysisResultUseCase(Get.find<VideoAnalysisRepositoryImpl>()),
    );
    
    // Đăng ký controller
    Get.lazyPut<VideoAnalysisController>(
      () => VideoAnalysisController(),
    );
  }
} 