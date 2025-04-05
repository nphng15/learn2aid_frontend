import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:learn2aid/config/routes/app_pages.dart';
import 'package:learn2aid/config/routes/app_routes.dart';
import 'package:learn2aid/features/presentation/modules/auth/auth_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Khởi tạo Firestore
  FirebaseFirestore.instance;

  Get.put<AuthController>(AuthController(), permanent: true); // Sử dụng AuthController

  runApp(
    MyApp()  
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) => const MyApp(),
    // ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // khong cho man hinh xoay ngang
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login, // Chạy vào trang Loading trước
      getPages: AppPages.pages,
    );
  }
}


