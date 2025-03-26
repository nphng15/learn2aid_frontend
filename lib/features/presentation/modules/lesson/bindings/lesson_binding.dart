import 'package:get/get.dart';
import '../controllers/video_analysis_controller.dart';
import '../../../../data/repositories/video_analysis_repository_impl.dart';
import '../../../../domain/usecases/analyze_video_usecase.dart';
import '../../../../domain/usecases/save_analysis_result_usecase.dart';

class LessonBinding implements Bindings {
  @override
  void dependencies() {
    // Đăng ký các dependencies theo đúng thứ tự
    
    // 1. Repository
    Get.put<VideoAnalysisRepositoryImpl>(
      VideoAnalysisRepositoryImpl(),
      permanent: true,
    );
    
    // 2. UseCases
    Get.put<AnalyzeVideoUseCase>(
      AnalyzeVideoUseCase(Get.find<VideoAnalysisRepositoryImpl>()),
      permanent: true,
    );
    
    Get.put<SaveAnalysisResultUseCase>(
      SaveAnalysisResultUseCase(Get.find<VideoAnalysisRepositoryImpl>()),
      permanent: true,
    );
    
    // 3. Controller
    Get.put<VideoAnalysisController>(
      VideoAnalysisController(
        analyzeVideoUseCase: Get.find<AnalyzeVideoUseCase>(),
        saveAnalysisResultUseCase: Get.find<SaveAnalysisResultUseCase>(),
      ),
      permanent: true,
    );
  }
} 