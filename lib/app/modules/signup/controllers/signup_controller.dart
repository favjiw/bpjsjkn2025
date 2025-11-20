import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final nikController = TextEditingController();
  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final referralController = TextEditingController();
  final captchaController = TextEditingController();

  final nikLength = 0.obs;
  final isSubmitting = false.obs;

  void onNikChanged(String value) {
    nikLength.value = value.length;
  }

  String? validateNik(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) {
      return 'NIK wajib diisi';
    }
    if (v.length != 16) {
      return 'NIK harus 16 digit';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(v)) {
      return 'NIK hanya boleh berisi angka';
    }
    return null;
  }

  String? validateName(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) {
      return 'Nama lengkap wajib diisi';
    }
    if (v.length < 3) {
      return 'Nama minimal 3 karakter';
    }
    return null;
  }

  String? validateDob(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) {
      return 'Tanggal lahir wajib diisi';
    }
    return null;
  }

  String? validateReferral(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) {
      return null;
    }
    if (v.length < 4) {
      return 'Kode referral minimal 4 karakter';
    }
    return null;
  }

  String? validateCaptcha(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) {
      return 'Captcha wajib diisi';
    }
    return null;
  }

  Future<void> onVerify() async {
    if (!formKey.currentState!.validate()) return;

    isSubmitting.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isSubmitting.value = false;

    Get.snackbar('Info', 'Verifikasi data berhasil (demo)');
  }

  void onRefreshCaptcha() {
    Get.snackbar('Info', 'Refresh captcha (demo)');
  }

  void onBack() {
    Get.back();
  }

  @override
  void onClose() {
    nikController.dispose();
    nameController.dispose();
    dobController.dispose();
    referralController.dispose();
    captchaController.dispose();
    super.onClose();
  }
}
