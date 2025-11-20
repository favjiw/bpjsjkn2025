import 'package:bpjs_jkn_2025/app/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  // Teks label umum seperti judul kecil card dan section
  static TextStyle get label => GoogleFonts.plusJakartaSans(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.mainBlack,
  );

  // Teks input search atau teks ringan
  static TextStyle get labelSearch => GoogleFonts.plusJakartaSans(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.darkGrey,
  );

  // Label yang perlu penekanan kuat
  static TextStyle get labelBold => GoogleFonts.plusJakartaSans(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.mainBlack,
  );

  // Judul di AppBar pada header berwarna
  static TextStyle get headingAppBar => GoogleFonts.plusJakartaSans(
    fontSize: 22.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.mainWhite,
  );

  // Body text ringan seperti deskripsi kecil
  static TextStyle get bodyLight => GoogleFonts.plusJakartaSans(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.darkGrey,
  );

  // Teks di dalam input field
  static TextStyle get inputText => GoogleFonts.plusJakartaSans(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.mainBlack,
  );

  // Judul besar onboarding atau banner informatif
  static TextStyle get onboardBigTitle => GoogleFonts.plusJakartaSans(
    fontSize: 28.sp,
    fontWeight: FontWeight.w800,
    color: AppColors.mainBlack,
  );

  // Subjudul onboarding atau teks banner sekunder
  static TextStyle get onboardBigSubtitle => GoogleFonts.plusJakartaSans(
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.darkGrey,
  );

  // Bottom nav tidak aktif
  static TextStyle get botnavInactive => GoogleFonts.plusJakartaSans(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.darkGrey,
  );

  // Bottom nav aktif menggunakan biru utama
  static TextStyle get botnavActive => GoogleFonts.plusJakartaSans(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryBlue,
  );

  // Body umum kecil
  static TextStyle get bodySmall => GoogleFonts.plusJakartaSans(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.mainBlack,
  );

  // Body kecil yang butuh penekanan
  static TextStyle get bodySmallSemiBold => GoogleFonts.plusJakartaSans(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.mainBlack,
  );

  // Masih dipertahankan jika nanti ada fitur nutrisi atau badge khusus
  static TextStyle get calorieActive => GoogleFonts.plusJakartaSans(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.calorie,
  );

  static TextStyle get calorieInactive => GoogleFonts.plusJakartaSans(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.calorie,
  );

  static TextStyle get carbsActive => GoogleFonts.plusJakartaSans(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.carbs,
  );

  static TextStyle get carbsInactive => GoogleFonts.plusJakartaSans(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.carbs,
  );

  // Teks putih di dalam badge atau tombol berwarna
  static TextStyle get recom => GoogleFonts.plusJakartaSans(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.mainWhite,
  );

  // Judul besar informasi misalnya nama fitur atau kartu utama
  static TextStyle get foodTitle => GoogleFonts.plusJakartaSans(
    fontSize: 22.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.mainBlack,
  );

  // Label penjelas di bawah judul kartu atau section
  static TextStyle get foodLabel => GoogleFonts.plusJakartaSans(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.darkGrey,
  );

  // Label kecil di profil seperti judul field
  static TextStyle get profileLabel => GoogleFonts.plusJakartaSans(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.darkGrey,
  );

  // Nilai di profil seperti nama, nomor kartu, dsb
  static TextStyle get profileUnit => GoogleFonts.plusJakartaSans(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.mainBlack,
  );
}
