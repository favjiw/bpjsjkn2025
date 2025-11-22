import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

enum ScenarioType {
  none,
  selfBooking,   // periksa gigi
  familyMode,    // ayah radang tenggorokan
  voiceMode,     // kontrol diabetes (voice)
  renewBpjs,     // perpanjang bpjs
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

  late stt.SpeechToText speech;
  late FlutterTts tts;

  final isListening = false.obs;
  final voiceText = ''.obs;

  bool lastInputFromVoice = false;

  @override
  void onInit() {
    super.onInit();
    speech = stt.SpeechToText();
    tts = FlutterTts();

    tts.setLanguage('id-ID');
    tts.setSpeechRate(0.5);
    tts.setPitch(1.0);
  }

  Future<void> _speakIfNeeded(String text) async {
    if (!lastInputFromVoice) return;
    if (text.trim().isEmpty) return;

    try {
      await tts.stop();
      await tts.speak(text);
    } catch (_) {}
  }

  Future<void> speakForFormOrSuccess(String text) async {
    await _speakIfNeeded(text);
  }

  Future<void> startListening({String localeId = 'id_ID'}) async {
    try {
      final available = await speech.initialize(
        onStatus: (status) {},
        onError: (error) {
          isListening.value = false;
        },
      );

      if (!available) {
        return;
      }

      isListening.value = true;
      voiceText.value = '';

      await speech.listen(
        onResult: (result) async {
          voiceText.value = result.recognizedWords;

          if (result.finalResult) {
            await speech.stop();
            isListening.value = false;

            final spoken = voiceText.value.trim();
            if (spoken.isNotEmpty) {
              lastInputFromVoice = true;
              sendMessage(spoken, fromVoice: true);
              voiceText.value = '';
            }
          }
        },
        localeId: localeId,
        listenOptions: stt.SpeechListenOptions(
          listenMode: stt.ListenMode.dictation,
          partialResults: true,
          cancelOnError: true,
        ),
        listenFor: const Duration(seconds: 8),
        pauseFor: const Duration(milliseconds: 1500),
      );
    } catch (e) {
      isListening.value = false;
    }
  }

  Future<void> stopListening() async {
    if (!isListening.value) return;

    await speech.stop();
    isListening.value = false;

    final spoken = voiceText.value.trim();
    if (spoken.isNotEmpty) {
      lastInputFromVoice = true;
      sendMessage(spoken, fromVoice: true);
      voiceText.value = '';
    }
  }

  Future<void> toggleVoice() async {
    if (isListening.value) {
      await stopListening();
    } else {
      await startListening();
    }
  }

  void sendMessage(String rawInput, {bool fromVoice = false}) {
    final cleaned = rawInput.trim();
    if (cleaned.isEmpty) return;

    lastInputFromVoice = fromVoice;

    messages.add(
      ChatMessage(
        text: cleaned,
        isUser: true,
      ),
    );

    isScenarioCompleted.value = false;

    final input = cleaned.toLowerCase();

    if (input.contains('periksa gigi')) {
      _handleSelfBooking();
    } else if (input.contains('ayah saya') || input.contains('daftarkan ke poli')) {
      _handleFamilyMode();
    } else if (input.contains('kontrol diabetes')) {
      _handleVoiceMode();
    } else if (input.contains('perpanjang bpjs') ||
        input.contains('perpanjang jkn') ||
        input.contains('bayar iuran')) {
      _handleRenewBpjs();
    } else {
      _handleFallback();
    }
  }

  void _startLoading(ScenarioType scenario, String agentMessage) {
    currentScenario.value = scenario;
    isLoadingScenario.value = true;

    messages.add(
      ChatMessage(
        isUser: false,
        text: agentMessage,
      ),
    );

    _speakIfNeeded(agentMessage);

    Future.delayed(const Duration(seconds: 2), () {
      if (currentScenario.value == scenario) {
        isLoadingScenario.value = false;
      }
    });
  }

  void _handleSelfBooking() {
    _startLoading(
      ScenarioType.selfBooking,
      'Baik, saya siapkan pendaftaran Poli Gigi dan Mulut untuk besok. '
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
      'Baik Pak Agus. Jadwal kontrol diabetes di Poli Penyakit Dalam tersedia besok jam delapan pagi. '
          'Silakan cek kartu konfirmasi yang saya siapkan.',
    );
  }

  void _handleRenewBpjs() {
    _startLoading(
      ScenarioType.renewBpjs,
      'Baik, saya bantu proses perpanjangan iuran BPJS Kesehatan. '
          'Silakan cek simulasi tagihan dan metode pembayaran yang saya siapkan.',
    );
  }

  void _handleFallback() {
    currentScenario.value = ScenarioType.none;
    isLoadingScenario.value = false;

    const fallbackText =
        'Maaf, untuk demo ini saya hanya merespon kata kunci berikut:\n'
        '• "periksa gigi"\n'
        '• "ayah saya ... daftarkan ke poli"\n'
        '• "kontrol diabetes"\n'
        '• "perpanjang bpjs" atau "bayar iuran".';

    messages.add(
      ChatMessage(
        isUser: false,
        text: fallbackText,
      ),
    );

    _speakIfNeeded(fallbackText);
  }

  void completeScenario() {
    isScenarioCompleted.value = true;

    const msg = 'Aksi berhasil disimulasikan untuk keperluan demo.';
    messages.add(
      ChatMessage(
        isUser: false,
        text: msg,
      ),
    );

    _speakIfNeeded(msg);
  }

  void resetScenario() {
    currentScenario.value = ScenarioType.none;
    isScenarioCompleted.value = false;
    isLoadingScenario.value = false;
  }
}
