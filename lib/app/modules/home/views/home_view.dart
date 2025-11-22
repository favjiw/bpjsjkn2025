import 'package:bpjs_jkn_2025/app/modules/home/controllers/home_controller.dart';
import 'package:bpjs_jkn_2025/app/modules/home/widgets/header_section.dart';
import 'package:bpjs_jkn_2025/app/modules/home/widgets/menu_grid.dart';
import 'package:bpjs_jkn_2025/app/modules/home/widgets/online_queue_card.dart';
import 'package:bpjs_jkn_2025/app/modules/home/widgets/promo_banner_carousel.dart';
import 'package:bpjs_jkn_2025/app/shared/colors.dart';
import 'package:bpjs_jkn_2025/app/shared/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_) {
        return Scaffold(
          backgroundColor: AppColors.mainWhite,
          body: Column(
            children: [
              const HeaderSection(),
              SizedBox(height: 12.h),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Column(
                    children: [
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.toNamed('/choose-auth');
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // IconButton(onPressed: (){
                                //   Get.toNamed('/choose-auth');
                                // }, icon: Icon(Icons.output_rounded, color: AppColors.mainBlack,)),
                                SizedBox(width: 8.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hi, Andi',
                                      style: AppTextStyles.labelBold,
                                    ),
                                    Text(
                                      'Anggota keluarga aktif',
                                      style: AppTextStyles.bodySmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Text('v4.14.0', style: AppTextStyles.labelBold),
                        ],
                      ),
                      const OnlineQueueCard(),
                      SizedBox(height: 12.h),
                      MenuGrid(controller: controller),
                      SizedBox(height: 16.h),
                      const PromoBannerCarousel(),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
