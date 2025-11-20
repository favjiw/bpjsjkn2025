import 'package:bpjs_jkn_2025/app/modules/choose_auth/controllers/choose_auth_controller.dart';
import 'package:bpjs_jkn_2025/app/modules/choose_auth/widgets/choose_auth_button.dart';
import 'package:bpjs_jkn_2025/app/shared/colors.dart';
import 'package:bpjs_jkn_2025/app/shared/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChooseAuthView extends GetView<ChooseAuthController> {
  const ChooseAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainWhite,
      body: Stack(
        children: [
          // Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/login_bg_img.png',
              fit: BoxFit.contain,
            ),
          ),

          // Back button (lingkaran)
          Positioned(
            top: 50.h,
            left: 16.w,
            child: GestureDetector(
              onTap: controller.onBack,
              child: Container(
                width: 42.w,
                height: 42.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppColors.primaryBlue,
                      AppColors.secondaryBlue,
                    ],
                  ),
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.mainWhite,
                  size: 22.sp,
                ),
              ),
            ),
          ),

          // Content
          Positioned(
            // make it center
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 500.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      // Tombol Masuk (biru)
                      ChooseAuthButton(
                        text: "Masuk",
                        gradient: [
                          AppColors.primaryBlue,
                          AppColors.secondaryBlue,
                        ],
                        onTap: controller.onMasuk,
                      ),

                      SizedBox(height: 18.h),

                      // Tombol Daftar (oranye)
                      ChooseAuthButton(
                        text: "Daftar",
                        gradient: [
                          const Color(0xFFFF9800),
                          const Color(0xFFFFC107),
                        ],
                        onTap: controller.onDaftar,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Text('Demo Purpose')
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
