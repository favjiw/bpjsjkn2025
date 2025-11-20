import 'package:bpjs_jkn_2025/app/shared/colors.dart';
import 'package:bpjs_jkn_2025/app/shared/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnlineQueueCard extends StatelessWidget {
  const OnlineQueueCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.mainWhite,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 80.w,
            height: 70.w,
            decoration: BoxDecoration(
              color: AppColors.secondaryWhite,
              borderRadius: BorderRadius.circular(50.r),
              image: DecorationImage(
                image: AssetImage('assets/queue_ic.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Antrean Online',
                  style: AppTextStyles.labelBold.copyWith(
                    color: AppColors.primaryBlue,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Untuk kunjungan lebih efisien tanpa harus menunggu lama.',
                  style: AppTextStyles.bodyLight,
                ),
                SizedBox(height: 8.h),
                Container(
                  width: 1.sw,
                  height: 1.h,
                  color: AppColors.lightGrey,
                ),
                SizedBox(height: 8.h),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 34.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 25.w,
                          vertical: 6.h,
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Ambil Antrean',
                        style: AppTextStyles.recom,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
