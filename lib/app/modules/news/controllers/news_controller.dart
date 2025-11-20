import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsController extends GetxController {
  final searchController = TextEditingController();

  final filters = <String>[
    'Rekomendasi',
    'Berita Utama',
    'Testimoni',
  ];

  final selectedFilter = 'Berita Utama'.obs;

  final featuredNews = <NewsItem>[
    NewsItem(
      title:
      'Layanan Prima bagi Peserta Antarkan BPJS Kesehatan Raih Apresiasi Internasional',
      imagePath: 'assets/news/featured_1.png',
      date: '22-09-2025',
      views: 124,
      category: 'Berita Utama',
    ),
    NewsItem(
      title: 'Gerakan Hidup Sehat Bersama JKN di Berbagai Daerah',
      imagePath: 'assets/news/featured_2.png',
      date: '18-09-2025',
      views: 98,
      category: 'Rekomendasi',
    ),
  ];

  final otherNews = <NewsItem>[
    NewsItem(
      title:
      'Skrining Kesehatan Bikin Anak Muda Lebih Waspada Sejak Dini',
      imagePath: 'assets/news/other_1.png',
      date: '20-09-2025',
      views: 0,
      category: 'Berita Utama',
    ),
    NewsItem(
      title:
      'Ini Pengalaman Yosia Manfaat Layanan Digital Program JKN',
      imagePath: 'assets/news/other_2.png',
      date: '19-09-2025',
      views: 10,
      category: 'Berita Utama',
    ),
  ];

  void onFilterSelected(String label) {
    selectedFilter.value = label;
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}

class NewsItem {
  final String title;
  final String imagePath;
  final String date;
  final int views;
  final String category;

  NewsItem({
    required this.title,
    required this.imagePath,
    required this.date,
    required this.views,
    required this.category,
  });
}
