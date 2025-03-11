import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:learn2aid/config/routes/app_pages.dart';
import 'package:learn2aid/config/routes/app_routes.dart';
import 'package:learn2aid/features/domain/usecases/video/pick_video.dart';
import 'package:learn2aid/features/domain/usecases/video/record_video.dart';
import 'package:learn2aid/features/presentation/controller/video/video_controller.dart';
import 'package:learn2aid/features/presentation/global_widgets/scroll_behavior.dart';
import 'features/data/repository/video_repository_impl.dart';
import 'features/domain/repositories/video_repository.dart';

void main() {
  final VideoRepository repository = VideoRepositoryImpl();
  Get.put(VideoController(
    pickVideoUseCase: PickVideoUseCase(repository),
    recordVideoUseCase: RecordVideoUseCase(repository),
  ));

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // khong cho man hinh xoay ngang
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.dashboard,
      getPages: AppPages.pages,
    );
  }
}
