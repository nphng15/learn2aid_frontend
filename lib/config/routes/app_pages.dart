import 'package:get/get.dart';
import 'package:learn2aid/features/presentation/modules/loading/loading_binding.dart';
import 'package:learn2aid/features/presentation/modules/loading/screens/loading_screen.dart';
import '../../features/presentation/modules/dashboard/dashboard_binding.dart';
import '../../features/presentation/modules/dashboard/screens/dashboard_page.dart';
import '../../features/presentation/modules/quiz/screens/quiz_page.dart';
import '../../features/presentation/modules/lesson/screens/lesson_page.dart';
import '../../features/presentation/modules/loading/screens/loading_screen.dart';
import 'app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.loading,
      page: () => const LoadingScreen(),
      binding: LoadingBinding(),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardPage(),
      // binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.quiz,
      page: () => const QuizPage(),
      // binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.lesson,
      page: () => const LessonPage(),
      // binding: DashboardBinding(),
    ),
  ];
}
