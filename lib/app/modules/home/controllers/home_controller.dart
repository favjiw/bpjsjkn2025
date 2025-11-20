import 'package:get/get.dart';

class HomeController extends GetxController {
  final selectedBottomIndex = 0.obs;

  void onBottomNavTap(int index) {
    selectedBottomIndex.value = index;
  }

  List<HomeMenuItemData> menuItems = [
    HomeMenuItemData(
      title: 'Info Program\nJKN',
      iconPath: 'assets/info_program_ic.png',
      isLocked: true,
    ),
    HomeMenuItemData(
      title: 'TELEHEALTH',
      iconPath: 'assets/telehealth_ic.png',
      isLocked: true,
    ),
    HomeMenuItemData(
      title: 'Info Riwayat\nPelayanan',
      iconPath: 'assets/icare_ic.png',
      isLocked: true,
    ),
    HomeMenuItemData(
      title: 'Bugar',
      iconPath: 'assets/bugar_ic.png',
      isLocked: true,
    ),
    HomeMenuItemData(
      title: 'NEW Rehab\n(Cicilan)',
      iconPath: 'assets/rehab_ic.png',
      isLocked: true,
    ),
    HomeMenuItemData(
      title: 'Pendaftaran\nPeserta Baru',
      iconPath: 'assets/regis_home_ic.png',
      isLocked: true,
    ),
    HomeMenuItemData(
      title: 'Info Peserta',
      iconPath: 'assets/info_home_ic.png',
      isLocked: true,
    ),
    HomeMenuItemData(
      title: 'Info Lokasi\nFaskes',
      iconPath: 'assets/map_home_ic.png',
      isLocked: true,
    ),
    HomeMenuItemData(
      title: 'Perubahan\nData Peserta',
      iconPath: 'assets/form_ic.png',
      isLocked: true,
    ),
    HomeMenuItemData(
      title: 'Menu Lainnya',
      iconPath: 'assets/menu_ic.png',
      isLocked: false,
    ),
  ];

  // data banner bagian bawah
  List<String> bannerImages = [
    'assets/home_img.jpg',
    'assets/home_img.jpg',
    'assets/home_img.jpg',
  ];

  final currentBannerIndex = 0.obs;

  void onBannerChanged(int index) {
    currentBannerIndex.value = index;
  }

  void onMenuTap(HomeMenuItemData item) {
    if (item.isLocked) {
      Get.defaultDialog(
        title: 'Fitur tidak tersedia',
        middleText:
        'Fitur ini tidak dapat diakses karena aplikasi ini hanya untuk demo.',
        textConfirm: 'OK',
        onConfirm: () => Get.back(),
      );
    } else {
      // di sini nanti bisa diarahkan ke halaman sebenarnya
      // contoh: Get.toNamed('/info-program');
    }
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
