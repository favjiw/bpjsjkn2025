import 'package:bpjs_jkn_2025/app/modules/home/controllers/home_controller.dart';
import 'package:bpjs_jkn_2025/app/shared/colors.dart';
import 'package:bpjs_jkn_2025/app/shared/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuItem extends StatelessWidget {
  final HomeMenuItemData data;

  const MenuItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: AppColors.mainWhite,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Image.asset(
                  data.iconPath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            if (data.isLocked)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 18.w,
                  height: 18.w,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.mainWhite,
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    Icons.lock,
                    size: 11.sp,
                    color: AppColors.mainWhite,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 6.h),
        Text(
          data.title,
          textAlign: TextAlign.center,
          style: AppTextStyles.profileLabel.copyWith(
            color: AppColors.mainBlack,
          ),
        ),
      ],
    );
  }
}
