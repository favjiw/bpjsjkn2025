import 'dart:ui';

import 'package:bpjs_jkn_2025/app/modules/signin/controllers/signin_controller.dart';
import 'package:bpjs_jkn_2025/app/modules/signin/widgets/login_input_field.dart';
import 'package:bpjs_jkn_2025/app/shared/colors.dart';
import 'package:bpjs_jkn_2025/app/shared/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SigninView extends GetView<SigninController> {
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Image.asset(
                'assets/login_bg_img.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.15),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: controller.onBack,
                        child: Container(
                          width: 40.w,
                          height: 40.w,
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
                      SizedBox(width: 12.w),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    width: 150.w,
                    child: Image.asset(
                      'assets/mobile_jkn_logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            LoginInputField(
                              label:
                              'Nomor Induk Kependudukan (NIK)',
                              hint:
                              '16 Digit Nomor Induk Kependudukan (NIK)',
                              controller: controller.nikController,
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: 16.h),
                            Obx(
                                  () => LoginInputField(
                                label: 'Password',
                                hint: 'Password Mobile JKN',
                                controller: controller.passwordController,
                                obscureText:
                                controller.isObscurePassword.value,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.isObscurePassword.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: AppColors.darkGrey,
                                  ),
                                  onPressed:
                                  controller.togglePasswordVisibility,
                                ),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              'Captcha',
                              style: AppTextStyles.bodySmallSemiBold.copyWith(
                                color: AppColors.mainWhite,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.mainWhite,
                                borderRadius: BorderRadius.circular(16.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.12),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 40.h,
                                    width: 120.w,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFECE0FA),
                                      borderRadius:
                                      BorderRadius.circular(8.r),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '5A9X',
                                      style: AppTextStyles.bodySmallSemiBold,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  IconButton(
                                    onPressed: controller.onRefreshCaptcha,
                                    icon: Icon(
                                      Icons.refresh,
                                      color: Colors.deepOrangeAccent,
                                      size: 22.sp,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: TextField(
                                      controller:
                                      controller.captchaController,
                                      style: AppTextStyles.inputText,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Captcha',
                                        hintStyle: AppTextStyles.bodyLight,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 24.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 48.h,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(24.r),
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          AppColors.primaryBlue,
                                          AppColors.secondaryBlue,
                                        ],
                                      ),
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      borderRadius:
                                      BorderRadius.circular(24.r),
                                      child: InkWell(
                                        borderRadius:
                                        BorderRadius.circular(24.r),
                                        onTap: controller.onSubmit,
                                        child: Center(
                                          child: Text(
                                            'Masuk',
                                            style: AppTextStyles.labelBold
                                                .copyWith(
                                              color: AppColors.mainWhite,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                GestureDetector(
                                  onTap: controller.onFingerprint,
                                  child: Container(
                                    width: 48.w,
                                    height: 48.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          AppColors.primaryBlue,
                                          AppColors.secondaryBlue,
                                        ],
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.fingerprint,
                                      color: AppColors.mainWhite,
                                      size: 26.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            Center(
                              child: GestureDetector(
                                onTap: controller.onForgotPassword,
                                child: Text(
                                  'Lupa Kata Sandi',
                                  style: AppTextStyles.bodySmallSemiBold
                                      .copyWith(
                                    color: AppColors.secondaryBlue,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 24.h),
                            Center(
                              child: Text(
                                'Demo purpose',
                                style: AppTextStyles.bodyLight.copyWith(
                                  color: AppColors.mainWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
