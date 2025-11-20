import 'package:bpjs_jkn_2025/app/modules/news/controllers/news_controller.dart';
import 'package:bpjs_jkn_2025/app/shared/colors.dart';
import 'package:bpjs_jkn_2025/app/shared/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewsFilterChips extends StatelessWidget {
  final NewsController controller;

  const NewsFilterChips({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: controller.filters.map((label) {
            final bool isActive = controller.selectedFilter.value == label;
            return Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: ChoiceChip(
                label: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: Text(
                    label,
                    style: isActive
                        ? AppTextStyles.bodySmallSemiBold.copyWith(
                      color: AppColors.mainWhite,
                    )
                        : AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ),
                selected: isActive,
                selectedColor: AppColors.primaryBlue,
                backgroundColor: AppColors.mainWhite,
                shape: StadiumBorder(
                  side: BorderSide(
                    color: AppColors.primaryBlue,
                    width: 1.2,
                  ),
                ),
                onSelected: (_) => controller.onFilterSelected(label),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
