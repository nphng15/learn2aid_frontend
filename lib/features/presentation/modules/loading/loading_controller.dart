import 'package:get/get.dart';

class LoadingController extends GetxController {
  // Dark mode state
  var isDark = true.obs;

  // Width factor state
  var widthFactor = 1.0.obs;

  // Update theme
  void toggleTheme(bool value) {
    isDark.value = value;
  }

  // Update width
  void changeWidthFactor(double? value) {
    if (value != null) {
      widthFactor.value = value;
    }
  }
}
