import 'package:get/get.dart';
import '../controllers/video_analysis_controller.dart';
import '../../../../data/repositories/video_analysis_repository_impl.dart';
import '../../../../domain/repositories/video_analysis_repository.dart';
import '../../../../domain/usecases/analyze_video_usecase.dart';
import '../../../../domain/usecases/save_analysis_result_usecase.dart';
import '../controllers/lesson_controller.dart';

class LessonBinding implements Bindings {
  @override
  void dependencies() {
    // Đăng ký các dependencies theo đúng thứ tự
    
    // 1. Repository
    Get.lazyPut<VideoAnalysisRepository>(
      () => VideoAnalysisRepositoryImpl(),
      fenix: true,
    );
    
    // 2. UseCases
    Get.lazyPut<AnalyzeVideoUseCase>(
      () => AnalyzeVideoUseCase(Get.find<VideoAnalysisRepository>()),
      fenix: true,
    );
    
    Get.lazyPut<SaveAnalysisResultUseCase>(
      () => SaveAnalysisResultUseCase(Get.find<VideoAnalysisRepository>()),
      fenix: true,
    );
    
    // 3. Controllers
    Get.lazyPut<VideoAnalysisController>(
      () => VideoAnalysisController(
        analyzeVideoUseCase: Get.find<AnalyzeVideoUseCase>(),
        saveAnalysisResultUseCase: Get.find<SaveAnalysisResultUseCase>(),
      ),
      fenix: true,
    );
    
    // Đăng ký LessonController
    Get.lazyPut<LessonController>(
      () => LessonController(),
      fenix: true,
    );
  }
} 