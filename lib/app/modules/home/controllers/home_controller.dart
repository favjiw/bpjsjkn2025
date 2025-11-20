import 'package:get/get.dart';

class HomeController extends GetxController {
  final selectedBottomIndex = 0.obs;

  void onBottomNavTap(int index) {
    selectedBottomIndex.value = index;
  }

  List<HomeMenuItemData> menuItems = [
    HomeMenuItemData(
      title: 'Info Program\nJKN',
      iconPath: 'assets/icons/info_program.png',
      isLocked: false,
    ),
    HomeMenuItemData(
      title: 'TELEHEALTH',
      iconPath: 'assets/icons/telehealth.png',
      isLocked: false,
    ),
    HomeMenuItemData(
      title: 'Info Riwayat\nPelayanan',
      iconPath: 'assets/icons/info_riwayat.png',
      isLocked: true,
    ),
    HomeMenuItemData(
      title: 'Bugar',
      iconPath: 'assets/icons/bugar.png',
      isLocked: true,
    ),
    HomeMenuItemData(
      title: 'NEW Rehab\n(Cicilan)',
      iconPath: 'assets/icons/rehab.png',
      isLocked: false,
    ),
    HomeMenuItemData(
      title: 'Pendaftaran\nPeserta Baru',
      iconPath: 'assets/icons/pendaftaran.png',
      isLocked: true,
    ),
    HomeMenuItemData(
      title: 'Info Peserta',
      iconPath: 'assets/icons/info_peserta.png',
      isLocked: false,
    ),
    HomeMenuItemData(
      title: 'SOS',
      iconPath: 'assets/icons/sos.png',
      isLocked: false,
    ),
    HomeMenuItemData(
      title: 'Info Lokasi\nFaskes',
      iconPath: 'assets/icons/lokasi_faskes.png',
      isLocked: false,
    ),
    HomeMenuItemData(
      title: 'Perubahan\nData Peserta',
      iconPath: 'assets/icons/perubahan_data.png',
      isLocked: false,
    ),
    HomeMenuItemData(
      title: 'Pengaduan\nLayanan JKN',
      iconPath: 'assets/icons/pengaduan.png',
      isLocked: true,
    ),
    HomeMenuItemData(
      title: 'Menu Lainnya',
      iconPath: 'assets/icons/lainnya.png',
      isLocked: false,
    ),
  ];

  // data banner bagian bawah
  List<String> bannerImages = [
    'assets/banners/banner_1.png',
    'assets/banners/banner_2.png',
    'assets/banners/banner_3.png',
  ];

  final currentBannerIndex = 0.obs;

  void onBannerChanged(int index) {
    currentBannerIndex.value = index;
  }
}

class HomeMenuItemData {
  final String title;
  final String iconPath;
  final bool isLocked;

  HomeMenuItemData({
    required this.title,
    required this.iconPath,
    required this.isLocked,
  });
}
