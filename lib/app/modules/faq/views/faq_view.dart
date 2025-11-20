import 'package:bpjs_jkn_2025/app/modules/faq/controllers/faq_controller.dart';
import 'package:bpjs_jkn_2025/app/modules/faq/widgets/faq_item.dart';
import 'package:bpjs_jkn_2025/app/modules/faq/widgets/faq_search_bar.dart';
import 'package:bpjs_jkn_2025/app/shared/colors.dart';
import 'package:bpjs_jkn_2025/app/shared/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FaqView extends GetView<FaqController> {
  const FaqView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.mainWhite,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: const FaqSearchBar(),
              ),
              SizedBox(height: 8.h),
              const Divider(height: 1),
              Expanded(
                child: Obx(
                      () => ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: controller.filteredFaqs.length,
                    separatorBuilder: (context, index) => const Divider(
                      height: 1,
                    ),
                    itemBuilder: (context, index) {
                      final item = controller.filteredFaqs[index];
                      return FaqItem(data: item);
                    },
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
