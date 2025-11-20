import 'package:get/get.dart';

class ChooseAuthController extends GetxController {
  void onMasuk() {
    Get.toNamed('/login');
  }

  void onDaftar() {
    Get.toNamed('/register');
  }

  void onBack() {
    Get.back();
  }
}
