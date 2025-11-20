import 'package:bpjs_jkn_2025/app/shared/colors.dart';
import 'package:bpjs_jkn_2025/app/shared/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageAsset;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // IMAGE
          SizedBox(
            height: 260.h,
            child: Image.asset(imageAsset),
          ),
          SizedBox(height: 40.h),

          Text(
            title,
            style: AppTextStyles.onboardBigTitle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),

          Text(
            description,
            style: AppTextStyles.onboardBigSubtitle.copyWith(
              color: AppColors.darkGrey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class OnboardingActivatePage extends StatelessWidget {
  const OnboardingActivatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 260.h,
            child: Image.asset("assets/onboard_3_img.png"),
          ),
          SizedBox(height: 40.h),
          Text(
            "Aktifkan Kolaborasi",
            style: AppTextStyles.onboardBigTitle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),

          Text(
            "Aktifkan Kolaborasi Keluarga agar AI dapat membantu mengatur kebutuhan kesehatan keluarga Anda.",
            style: AppTextStyles.onboardBigSubtitle.copyWith(
              color: AppColors.darkGrey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
