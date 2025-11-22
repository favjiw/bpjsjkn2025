// lib/app/modules/consent/controllers/consent_controller.dart

import 'package:get/get.dart';

class ConsentController extends GetxController {
  // Izin untuk pendaftaran layanan
  final consentRegisterBasicData = false.obs;
  final consentRegisterHistory = false.obs;

  // Izin untuk perpanjang BPJS
  final consentExtendBasicData = false.obs;
  final consentExtendHistory = false.obs;

  // Izin komunikasi dengan AI Agent (notifikasi dan rekomendasi)
  final consentCommunication = false.obs;

  bool get isAllRequiredAccepted {
    // Contoh logika minimal
    // Pendaftaran dan perpanjang butuh akses data dasar
    return consentRegisterBasicData.value &&
        consentExtendBasicData.value &&
        consentCommunication.value;
  }

  void toggleRegisterBasic(bool value) {
    consentRegisterBasicData.value = value;
  }

  void toggleRegisterHistory(bool value) {
    consentRegisterHistory.value = value;
  }

  void toggleExtendBasic(bool value) {
    consentExtendBasicData.value = value;
  }

  void toggleExtendHistory(bool value) {
    consentExtendHistory.value = value;
  }

  void toggleCommunication(bool value) {
    consentCommunication.value = value;
  }

  void onConfirm() {
    if (!isAllRequiredAccepted) return;

    // Di sini bisa dipanggil API atau navigasi
    // Contoh: Get.back(result: true);
  }
}
