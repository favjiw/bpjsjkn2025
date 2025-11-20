import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final pageIndex = 0.obs;
  final pageController = PageController();

  void updatePageIndex(int index) {
    pageIndex.value = index;
  }

  void nextPage() {
    if (pageIndex.value < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      onActivate();
    }
  }

  void skip() {
    pageController.jumpToPage(2);
    pageIndex.value = 2;
  }



  void onActivate() {
    // nanti tambahkan save ke local storage
    Get.offAllNamed('/botnavbar');
  }
}
