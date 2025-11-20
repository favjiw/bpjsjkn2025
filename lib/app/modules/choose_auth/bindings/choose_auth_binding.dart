import 'package:get/get.dart';

import '../controllers/choose_auth_controller.dart';

class ChooseAuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseAuthController>(
      () => ChooseAuthController(),
    );
  }
}
