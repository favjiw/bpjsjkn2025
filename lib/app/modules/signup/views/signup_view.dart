import 'package:bpjs_jkn_2025/app/modules/signup/controllers/signup_controller.dart';
import 'package:bpjs_jkn_2025/app/modules/signup/widgets/signup_text_field.dart';
import 'package:bpjs_jkn_2025/app/shared/colors.dart';
import 'package:bpjs_jkn_2025/app/shared/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.mainWhite,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: 1.sw,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      AppColors.primaryBlue,
                      AppColors.secondaryBlue,
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: controller.onBack,
                      child: Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white24,
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: AppColors.mainWhite,
                          size: 22.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Pendaftaran Pengguna Mobile',
                      style: AppTextStyles.labelBold.copyWith(
                        color: AppColors.mainWhite,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 20.h,
                          ),
                          // decoration: BoxDecoration(
                          //   color: AppColors.mainWhite,
                          //   borderRadius: BorderRadius.circular(12.r),
                          //   boxShadow: [
                          //     BoxShadow(
                          //       color: Colors.black.withOpacity(0.06),
                          //       blurRadius: 8,
                          //       offset: const Offset(0, 3),
                          //     ),
                          //   ],
                          // ),
                          child: Column(
                            children: [
                              Container(
                                width: 56.w,
                                height: 56.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: Image.asset(
                                    'assets/mobile_jkn_logo.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                'Selamat Datang di Mobile JKN',
                                style: AppTextStyles.labelBold.copyWith(
                                  color: AppColors.primaryBlue,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'Silakan isi data diri Anda dengan sesuai.',
                                style: AppTextStyles.bodyLight,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 20.h),
                              Obx(
                                    () => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SignupTextField(
                                      label:
                                      'Nomor Induk Kependudukan (NIK)',
                                      hint:
                                      'Masukkan 16 digit Nomor Induk Kependudukan',
                                      controller: controller.nikController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(16),
                                      ],
                                      validator: controller.validateNik,
                                    ),
                                    SizedBox(height: 4.h),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${controller.nikLength.value}/16',
                                        style: AppTextStyles.bodyLight,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16.h),
                              SignupTextField(
                                label: 'Nama Lengkap',
                                hint: 'Masukkan nama lengkap Anda',
                                controller: controller.nameController,
                                validator: controller.validateName,
                              ),
                              SizedBox(height: 16.h),
                              SignupTextField(
                                label: 'Tanggal Lahir',
                                hint: 'DD-MM-YYYY',
                                controller: controller.dobController,
                                keyboardType: TextInputType.datetime,
                                validator: controller.validateDob,
                              ),
                              SizedBox(height: 16.h),
                              SignupTextField(
                                label: 'Kode Referral (Opsional)',
                                hint: 'Masukkan kode referral',
                                controller: controller.referralController,
                                validator: controller.validateReferral,
                                suffix: Icon(
                                  Icons.qr_code_2_outlined,
                                  color: AppColors.primaryBlue,
                                  size: 22.sp,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Captcha',
                                    style:
                                    AppTextStyles.bodySmallSemiBold.copyWith(
                                      color: AppColors.primaryBlue,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller:
                                          controller.captchaController,
                                          validator:
                                          controller.validateCaptcha,
                                          style: AppTextStyles.inputText,
                                          decoration: InputDecoration(
                                            hintText: 'Masukkan captcha',
                                            hintStyle:
                                            AppTextStyles.bodyLight,
                                            contentPadding:
                                            EdgeInsets.symmetric(
                                              horizontal: 10.w,
                                              vertical: 10.h,
                                            ),
                                            filled: true,
                                            fillColor: AppColors.mainWhite,
                                            enabledBorder:
                                            OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(4.r),
                                              borderSide: BorderSide(
                                                color: AppColors.primaryBlue,
                                                width: 1.4,
                                              ),
                                            ),
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(4.r),
                                              borderSide: BorderSide(
                                                color: AppColors.secondaryBlue,
                                                width: 1.6,
                                              ),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(4.r),
                                              borderSide: const BorderSide(
                                                color: Colors.red,
                                                width: 1.4,
                                              ),
                                            ),
                                            focusedErrorBorder:
                                            OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(4.r),
                                              borderSide: const BorderSide(
                                                color: Colors.red,
                                                width: 1.6,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      Container(
                                        width: 80.w,
                                        height: 40.h,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE0F2F1),
                                          borderRadius:
                                          BorderRadius.circular(6.r),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          'abcd',
                                          style:
                                          AppTextStyles.bodySmallSemiBold,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed:
                                        controller.onRefreshCaptcha,
                                        icon: Icon(
                                          Icons.refresh,
                                          color: Colors.deepOrangeAccent,
                                          size: 22.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Obx(
                              () => SizedBox(
                            width: 1.sw,
                            height: 48.h,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.r),
                                ),
                              ),
                              onPressed: controller.isSubmitting.value
                                  ? null
                                  : controller.onVerify,
                              child: Ink(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.r),
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      AppColors.primaryBlue,
                                      AppColors.secondaryBlue,
                                    ],
                                  ),
                                ),
                                child: Center(
                                  child: controller.isSubmitting.value
                                      ? SizedBox(
                                    width: 18.w,
                                    height: 18.w,
                                    child:
                                    const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor:
                                      AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                      : Text(
                                    'Verifikasi Data',
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
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
