import 'package:bpjs_jkn_2025/app/modules/faq/controllers/faq_controller.dart';
import 'package:bpjs_jkn_2025/app/modules/faq/views/faq_detail_view.dart';
import 'package:bpjs_jkn_2025/app/shared/colors.dart';
import 'package:bpjs_jkn_2025/app/shared/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FaqItem extends StatelessWidget {
  final FaqItemData data;

  const FaqItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => FaqDetailView(data: data));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                data.question,
                style: AppTextStyles.bodySmall,
              ),
            ),
            SizedBox(width: 8.w),
            Row(
              children: [
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
                SizedBox(width: 10.w),
                Icon(
                  Icons.chevron_right,
                  size: 20.sp,
                  color: AppColors.darkGrey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
