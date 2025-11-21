import 'package:bpjs_jkn_2025/app/modules/faq/controllers/faq_controller.dart';
import 'package:bpjs_jkn_2025/app/modules/faq/views/faq_view.dart';
import 'package:bpjs_jkn_2025/app/modules/home/controllers/home_controller.dart';
import 'package:bpjs_jkn_2025/app/modules/home/views/home_view.dart';
import 'package:bpjs_jkn_2025/app/modules/news/controllers/news_controller.dart';
import 'package:bpjs_jkn_2025/app/modules/news/views/news_view.dart';
import 'package:bpjs_jkn_2025/app/shared/colors.dart';
import 'package:bpjs_jkn_2025/app/shared/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/botnavbar_controller.dart';

class BotnavbarView extends GetView<BotnavbarController> {
  const BotnavbarView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => NewsController(), fenix: true);
    Get.lazyPut(() => FaqController(), fenix: true);

    final List<Widget> pages = [
      HomeView(),
      NewsView(),
      Container(color: Colors.green),
      FaqView(),
      Container(color: Colors.yellow),
    ];
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.secondaryWhite,
        body: pages[controller.currentIndex.value],
        bottomNavigationBar: SizedBox(
          width: 1.sw,
          height: 90.h,
          child: Stack(
            children: [
              Positioned(
                bottom: 0.h,
                left: 0.w,
                child: Container(
                  width: 1.sw,
                  height: 80.h,
                  decoration: BoxDecoration(color: AppColors.mainWhite),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          controller.currentIndex.value = 0;
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home_rounded,
                              color: controller.currentIndex.value == 0
                                  ? AppColors.primaryBlue
                                  : Colors.grey,
                            ),
                            // SvgPicture.asset(
                            //   controller.currentIndex.value == 0
                            //       ? 'assets/images/home_act_ic.svg'
                            //       : 'assets/images/home_inac_ic.svg',
                            //   width: 24.w,
                            //   height: 24.h,
                            // ),
                            SizedBox(height: 2.h),
                            Text(
                              'Home',
                              style: controller.currentIndex.value == 0
                                  ? AppTextStyles.botnavActive
                                  : AppTextStyles.botnavInactive,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.currentIndex.value = 1;
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.newspaper_rounded,
                              color: controller.currentIndex.value == 1
                                  ? AppColors.primaryBlue
                                  : Colors.grey,
                            ),
                            // SvgPicture.asset(
                            //   controller.currentIndex.value == 1
                            //       ? 'assets/images/meals_act_ic.svg'
                            //       : 'assets/images/meals_inac_ic.svg',
                            //   width: 24.w,
                            //   height: 24.h,
                            // ),
                            SizedBox(height: 2.h),
                            Text(
                              'Berita',
                              style: controller.currentIndex.value == 1
                                  ? AppTextStyles.botnavActive
                                  : AppTextStyles.botnavInactive,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 24.w, height: 24.h),
                      InkWell(
                        onTap: () {
                          controller.currentIndex.value = 3;
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.chat_bubble_rounded,
                              color: controller.currentIndex.value == 3
                                  ? AppColors.primaryBlue
                                  : Colors.grey,
                            ),
                            // SvgPicture.asset(
                            //   controller.currentIndex.value == 3
                            //       ? 'assets/images/stats_act_ic.svg'
                            //       : 'assets/images/stats_inac_ic.svg',
                            //   width: 24.w,
                            //   height: 24.h,
                            // ),
                            SizedBox(height: 2.h),
                            Text(
                              'FAQ',
                              style: controller.currentIndex.value == 3
                                  ? AppTextStyles.botnavActive
                                  : AppTextStyles.botnavInactive,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.currentIndex.value = 4;
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_pin,
                              color: controller.currentIndex.value == 4
                                  ? AppColors.primaryBlue
                                  : Colors.grey,
                            ),
                            // SvgPicture.asset(
                            //   controller.currentIndex.value == 4
                            //       ? 'assets/images/profile_act_ic.svg'
                            //       : 'assets/images/profile_inac_ic.svg',
                            //   width: 24.w,
                            //   height: 24.h,
                            // ),
                            SizedBox(height: 2.h),
                            Text(
                              'Profil',
                              style: controller.currentIndex.value == 4
                                  ? AppTextStyles.botnavActive
                                  : AppTextStyles.botnavInactive,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.mainWhite,
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    onTap: () {
                      controller.currentIndex.value = 2;
                    },
                    child: Container(
                      width: 56.w,
                      height: 56.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            AppColors.primaryBlue,
                            AppColors.secondaryBlue,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.credit_card,
                          color: AppColors.mainWhite,
                        ),
                        // child: SvgPicture.asset(
                        //   'assets/images/scan_ic.svg',
                        //   width: 32.w,
                        //   height: 32.h,
                        // ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed('/chatbot');
          },
          shape: const CircleBorder(),
          backgroundColor: AppColors.primaryBlue,
          child: Image.asset('assets/bot_ic.png', width: 35.w, height: 35.h, fit: BoxFit.cover,),
        ),
      ),
    );
  }
}
