// lib/app/modules/consent/widgets/consent_checkbox_tile.dart

import 'package:bpjs_jkn_2025/app/shared/colors.dart';
import 'package:bpjs_jkn_2025/app/shared/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConsentCheckboxTile extends StatelessWidget {
  final String title;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool isRequired;

  const ConsentCheckboxTile({
    super.key,
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.secondaryWhite,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: CheckboxListTile(
        value: value,
        onChanged: (val) {
          if (val != null) onChanged(val);
        },
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: AppColors.primaryBlue,
        contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.bodySmallSemiBold,
              ),
            ),
            if (isRequired)
              Padding(
                padding: EdgeInsets.only(left: 4.w),
                child: Text(
                  'Wajib',
                  style: AppTextStyles.profileLabel.copyWith(
                    color: AppColors.yellow,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: Text(
            description,
            style: AppTextStyles.bodyLight,
          ),
        ),
      ),
    );
  }
}
