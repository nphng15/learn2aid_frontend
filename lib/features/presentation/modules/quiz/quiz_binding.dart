import 'package:get/get.dart';
import 'quiz_controller.dart';
import '../../../data/repositories/quiz_repository_impl.dart';
import '../../../domain/usecases/get_quizzes_usecase.dart';
import '../../../domain/usecases/get_quiz_questions_usecase.dart';
import '../../../domain/usecases/submit_quiz_result_usecase.dart';

class QuizBinding extends Bindings {
  @override
  void dependencies() {
    // Repository
    final repository = QuizRepositoryImpl();
    
    // Use cases
    final getQuizzesUseCase = GetQuizzesUseCase(repository);
    final getQuizQuestionsUseCase = GetQuizQuestionsUseCase(repository);
    final submitQuizResultUseCase = SubmitQuizResultUseCase(repository);
    
    // Controller
    Get.put<QuizController>(
      QuizController(
        getQuizzesUseCase: getQuizzesUseCase,
        getQuizQuestionsUseCase: getQuizQuestionsUseCase,
        submitQuizResultUseCase: submitQuizResultUseCase,
      )
    );
  }
} 