import 'package:get/get.dart';

class ChooseAuthController extends GetxController {
  void onMasuk() {
    Get.toNamed('/signin');
  }

  void onDaftar() {
    Get.toNamed('/signup');
  }

  void onBack() {
    Get.back();
  }
}
