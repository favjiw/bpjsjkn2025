// lib/app/modules/consent/views/consent_page.dart

import 'package:bpjs_jkn_2025/app/modules/consent/controllers/consent_controller.dart';
import 'package:bpjs_jkn_2025/app/modules/consent/widgets/consent_checkbox_tile.dart';
import 'package:bpjs_jkn_2025/app/shared/colors.dart';
import 'package:bpjs_jkn_2025/app/shared/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ConsentView extends GetView<ConsentController> {
  const ConsentView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.secondaryWhite,
      appBar: AppBar(
        backgroundColor: AppColors.headerCyan,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Perizinan AI Agent',
          style: AppTextStyles.headingAppBar,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            children: [
              _buildHeader(),
              SizedBox(height: 12.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildSectionCard(
                        title: 'Pendaftaran Layanan',
                        description:
                        'AI Agent akan membantu mengisi data pada proses pendaftaran layanan fasilitas kesehatan.',
                        child: Obx(
                              () => Column(
                            children: [
                              ConsentCheckboxTile(
                                title: 'Akses data kepesertaan JKN',
                                description:
                                'Mengizinkan AI Agent membaca nomor kartu, nama, tanggal lahir, dan status kepesertaan untuk mengisi formulir pendaftaran.',
                                value: controller.consentRegisterBasicData.value,
                                onChanged: controller.toggleRegisterBasic,
                                isRequired: true,
                              ),
                              ConsentCheckboxTile(
                                title: 'Akses riwayat kunjungan dan rujukan',
                                description:
                                'Mengizinkan AI Agent melihat riwayat kunjungan dan rujukan untuk menyesuaikan pendaftaran layanan.',
                                value: controller.consentRegisterHistory.value,
                                onChanged: controller.toggleRegisterHistory,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      _buildSectionCard(
                        title: 'Perpanjang BPJS',
                        description:
                        'AI Agent akan menyiapkan data yang dibutuhkan untuk proses perpanjang kepesertaan BPJS.',
                        child: Obx(
                              () => Column(
                            children: [
                              ConsentCheckboxTile(
                                title: 'Akses data iuran dan status kepesertaan',
                                description:
                                'Mengizinkan AI Agent membaca status iuran, kelas perawatan, dan data keluarga untuk keperluan perpanjang.',
                                value: controller.consentExtendBasicData.value,
                                onChanged: controller.toggleExtendBasic,
                                isRequired: true,
                              ),
                              ConsentCheckboxTile(
                                title: 'Akses riwayat penonaktifan atau tunggakan',
                                description:
                                'Mengizinkan AI Agent memakai riwayat tunggakan atau penonaktifan sebagai konteks rekomendasi perpanjang.',
                                value: controller.consentExtendHistory.value,
                                onChanged: controller.toggleExtendHistory,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      _buildSectionCard(
                        title: 'Komunikasi dan Rekomendasi',
                        description:
                        'Mengatur cara AI Agent mengirim notifikasi dan rekomendasi terkait layanan JKN.',
                        child: Obx(
                              () => ConsentCheckboxTile(
                            title: 'Notifikasi dan rekomendasi melalui AI Agent',
                            description:
                            'Mengizinkan AI Agent mengirim pengingat jatuh tempo iuran, jadwal kontrol, dan rekomendasi layanan melalui aplikasi atau kanal resmi.',
                            value: controller.consentCommunication.value,
                            onChanged: controller.toggleCommunication,
                            isRequired: true,
                          ),
                        ),
                      ),
                      SizedBox(height: 80.h),
                    ],
                  ),
                ),
              ),
              Obx(
                    () => _buildBottomInfoAndButton(
                  isEnabled: controller.isAllRequiredAccepted,
                  onPressed: controller.isAllRequiredAccepted
                      ? controller.onConfirm
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.mainWhite,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Setujui akses data untuk AI Agent',
            style: AppTextStyles.labelBold,
          ),
          SizedBox(height: 4.h),
          Text(
            'Dengan memberikan izin, Anda mengizinkan AI Agent membaca data dari ekosistem JKN agar proses pendaftaran layanan dan perpanjang BPJS menjadi lebih cepat dan terarah.',
            style: AppTextStyles.bodyLight,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required String description,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.mainWhite,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.labelBold,
          ),
          SizedBox(height: 4.h),
          Text(
            description,
            style: AppTextStyles.bodyLight,
          ),
          SizedBox(height: 10.h),
          child,
        ],
      ),
    );
  }

  Widget _buildBottomInfoAndButton({
    required bool isEnabled,
    required VoidCallback? onPressed,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Anda dapat mengubah izin ini kapan saja di pengaturan privasi.',
          style: AppTextStyles.profileLabel,
        ),
        SizedBox(height: 8.h),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor:
              isEnabled ? AppColors.primaryBlue : AppColors.lightGrey,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              elevation: isEnabled ? 2 : 0,
            ),
            child: Text(
              'Konfirmasi dan Lanjutkan',
              style: AppTextStyles.recom,
            ),
          ),
        ),
      ],
    );
  }
}
