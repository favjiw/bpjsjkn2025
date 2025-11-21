import 'package:get/get.dart';

enum ScenarioType {
  none,
  selfBooking, // skenario 1: periksa gigi
  familyMode,  // skenario 2: ayah radang tenggorokan
  voiceMode,   // skenario 3: kontrol diabetes
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({
    required this.text,
    required this.isUser,
  });
}

class ChatbotController extends GetxController {
  final messages = <ChatMessage>[].obs;
  final currentScenario = ScenarioType.none.obs;
  final isScenarioCompleted = false.obs;

  final isLoadingScenario = false.obs;

  void sendMessage(String rawInput) {
    if (rawInput.trim().isEmpty) return;

    messages.add(ChatMessage(text: rawInput.trim(), isUser: true));

    isScenarioCompleted.value = false;

    final input = rawInput.toLowerCase();

    if (input.contains('periksa gigi')) {
      _handleSelfBooking();
    } else if (input.contains('ayah saya') || input.contains('daftarkan ke poli')) {
      _handleFamilyMode();
    } else if (input.contains('kontrol diabetes')) {
      _handleVoiceMode();
    } else {
      _handleFallback();
    }
  }

  void _startLoading(ScenarioType scenario, String agentMessage) {
    currentScenario.value = scenario;
    isLoadingScenario.value = true;

    // Tambah agent bubble (typewriter)
    messages.add(ChatMessage(
      isUser: false,
      text: agentMessage,
    ));

    // delay loading → setelah itu tampilkan scenario form
    Future.delayed(const Duration(seconds: 2), () {
      if (currentScenario.value == scenario) {
        isLoadingScenario.value = false;
      }
    });
  }


  void _handleSelfBooking() {
    _startLoading(
      ScenarioType.selfBooking,
      'Baik, saya siapkan pendaftaran Poli Gigi & Mulut untuk besok. '
          'Silakan cek dan konfirmasi form pendaftaran yang saya buatkan.',
    );
  }

  void _handleFamilyMode() {
    _startLoading(
      ScenarioType.familyMode,
      'Baik, saya bantu daftarkan Ayah ke poli yang sesuai keluhan radang tenggorokan. '
          'Silakan cek form antrean untuk Bapak Budi.',
    );
  }

  void _handleVoiceMode() {
    _startLoading(
      ScenarioType.voiceMode,
      'Permintaan kontrol diabetes rutin besok sudah saya proses. '
          'Berikut konfirmasi jadwal Poli Penyakit Dalam untuk Bapak.',
    );
  }

  void _handleFallback() {
    currentScenario.value = ScenarioType.none;
    isLoadingScenario.value = false;
    messages.add(
      ChatMessage(
        isUser: false,
        text:
        'Maaf, untuk demo ini saya hanya merespon kata kunci:\n'
            '- "periksa gigi"\n'
            '- "ayah saya ... daftarkan ke poli"\n'
            '- "kontrol diabetes".',
      ),
    );
  }

  void completeScenario() {
    isScenarioCompleted.value = true;
    messages.add(
      ChatMessage(
        isUser: false,
        text: 'Tiket antrean berhasil dibuat (demo).',
      ),
    );
  }

  void resetScenario() {
    currentScenario.value = ScenarioType.none;
    isScenarioCompleted.value = false;
    isLoadingScenario.value = false;
  }
}
