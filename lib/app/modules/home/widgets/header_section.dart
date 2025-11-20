import 'package:bpjs_jkn_2025/app/modules/home/widgets/online_queue_card.dart';
import 'package:bpjs_jkn_2025/app/shared/colors.dart';
import 'package:bpjs_jkn_2025/app/shared/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 12.h,
        bottom: 16.h,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.headerCyan,
            AppColors.primaryBlue,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // bar status dan ikon di atas bisa diabaikan, lebih fokus konten
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            ],
          ),
        ],
      ),
    );
  }
}
