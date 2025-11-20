import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaqController extends GetxController {
  final searchController = TextEditingController();
  final faqs = <FaqItemData>[].obs;
  final filteredFaqs = <FaqItemData>[].obs;

  @override
  void onInit() {
    super.onInit();

    faqs.assignAll([
      FaqItemData(
        question: 'Siapa sajakah yang masuk dalam Anggota Keluarga',
        views: 7.36,
        date: '29-07-2019',
        answer:
        'Anggota Keluarga adalah istri/suami yang sah, anak kandung, '
            'anak tiri dari perkawinan yang sah, dan anak angkat yang sah.',
      ),
      FaqItemData(
        question: 'Berapa besaran iuran PBI?',
        views: 4.4,
        date: '15-03-2020',
        answer:
        'Iuran Peserta Penerima Bantuan Iuran (PBI) dibayarkan oleh '
            'pemerintah sesuai ketentuan peraturan perundang-undangan yang berlaku.',
      ),
      FaqItemData(
        question:
        'Berapa besaran iuran Peserta PBPU/Mandiri/Perseorangan?',
        views: 3.17,
        date: '10-05-2020',
        answer:
        'Besaran iuran peserta PBPU/Mandiri/Perseorangan mengikuti kelas '
            'layanan dan ketentuan tarif yang ditetapkan pemerintah.',
      ),
      FaqItemData(
        question: 'Cara Perubahan Data Melalui Aplikasi Mobile JKN?',
        views: 2.91,
        date: '02-08-2021',
        answer:
        'Perubahan data peserta dapat dilakukan melalui menu Perubahan '
            'Data Peserta pada aplikasi Mobile JKN sesuai petunjuk yang tersedia.',
      ),
      FaqItemData(
        question: 'Bagaimana Jika Kartu Peserta Hilang',
        views: 2.39,
        date: '11-09-2021',
        answer:
        'Peserta dapat mencetak kembali kartu elektronik (e-ID) melalui '
            'aplikasi Mobile JKN atau menghubungi fasilitas pelayanan terkait.',
      ),
      FaqItemData(
        question: 'Aplikasi Mobile JKN',
        views: 2.24,
        date: '01-01-2019',
        answer:
        'Mobile JKN adalah aplikasi resmi BPJS Kesehatan yang memudahkan '
            'peserta dalam mengakses informasi dan layanan JKN-KIS.',
      ),
    ]);

    filteredFaqs.assignAll(faqs);
  }

  void onSearch() {
    final query = searchController.text.toLowerCase().trim();
    if (query.isEmpty) {
      filteredFaqs.assignAll(faqs);
    } else {
      filteredFaqs.assignAll(
        faqs.where(
              (f) => f.question.toLowerCase().contains(query),
        ),
      );
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}

class FaqItemData {
  final String question;
  final double views; // jutaan, contoh 7.36M
  final String date;
  final String answer;

  FaqItemData({
    required this.question,
    required this.views,
    required this.date,
    required this.answer,
  });
}
