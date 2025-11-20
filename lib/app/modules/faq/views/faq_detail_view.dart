import 'package:bpjs_jkn_2025/app/modules/faq/controllers/faq_controller.dart';
import 'package:bpjs_jkn_2025/app/shared/colors.dart';
import 'package:bpjs_jkn_2025/app/shared/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FaqDetailView extends StatelessWidget {
  final FaqItemData data;

  const FaqDetailView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainWhite,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER GRADIENT
            Container(
              width: 1.sw,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
                  InkWell(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColors.mainWhite,
                      size: 22.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Center(
                    child: Text(
                      'FAQ',
                      style: AppTextStyles.headingAppBar,
                    ),
                  ),
                ],
              ),
            ),

            // CARD PERTANYAAN
            Transform.translate(
              offset: Offset(0, -12.h),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12.w),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: AppColors.mainWhite,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.question,
                      style: AppTextStyles.bodySmallSemiBold,
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 14.sp,
                          color: AppColors.darkGrey,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          data.date,
                          style: AppTextStyles.bodyLight,
                        ),
                        SizedBox(width: 16.w),
                        Icon(
                          Icons.remove_red_eye_outlined,
                          size: 14.sp,
                          color: AppColors.darkGrey,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${data.views.toStringAsFixed(2)}M',
                          style: AppTextStyles.bodyLight,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // JAWABAN
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Container(
                  width: 1.sw,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: AppColors.mainWhite,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      data.answer,
                      style: AppTextStyles.bodySmall,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
