import 'package:bpjs_jkn_2025/app/data/notification_helper.dart';
import 'package:get/get.dart';

class BotnavbarController extends GetxController {
  var currentIndex = 0.obs;
  void changePages(int index) {
    currentIndex.value = index;
  }
  void showRegisteredNotification() {
    NotificationHelper.showRegistrationNotification();
  }
}