import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninController extends GetxController {
  final nikController = TextEditingController();
  final passwordController = TextEditingController();
  final captchaController = TextEditingController();

  final isObscurePassword = true.obs;

  void togglePasswordVisibility() {
    isObscurePassword.value = !isObscurePassword.value;
  }

  void onSubmit() {
    // logika login
    Get.snackbar('Info', 'Login pressed (demo)');
  }

  void onFingerprint() {
    // logika fingerprint auth
    Get.snackbar('Info', 'Fingerprint pressed (demo)');
  }

  void onRefreshCaptcha() {
    // logika refresh captcha
    Get.snackbar('Info', 'Refresh captcha (demo)');
  }

  void onBack() {
    Get.back();
  }

  void onForgotPassword() {
    Get.snackbar('Info', 'Lupa kata sandi (demo)');
  }

  @override
  void onClose() {
    nikController.dispose();
    passwordController.dispose();
    captchaController.dispose();
    super.onClose();
  }
}
