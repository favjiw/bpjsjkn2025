import 'package:bpjs_jkn_2025/app/shared/colors.dart';
import 'package:bpjs_jkn_2025/app/shared/text_style.dart';
import 'package:bpjs_jkn_2025/app/modules/onboarding/controllers/onboarding_controller.dart';
import 'package:bpjs_jkn_2025/app/modules/onboarding/widgets/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: AppColors.secondaryWhite,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller.pageController,
              onPageChanged: controller.updatePageIndex,
              pageSnapping: true,
              physics: NeverScrollableScrollPhysics(),
              children: const [
                OnboardingPage(
                  title: "Kolaborasi Kesehatan",
                  description:
                  "Kenali fitur baru yang membantu keluarga mengelola layanan kesehatan dengan lebih mudah.",
                  imageAsset: "assets/onboard_1_img.png",
                ),
                OnboardingPage(
                  title: "Dukungan AI Pintar",
                  description:
                  "AI akan membantu mengingatkan jadwal kesehatan, pemantauan peserta, dan kebutuhan keluarga.",
                  imageAsset: "assets/onboard_2_img.png",
                ),
                OnboardingActivatePage(),
              ],
            ),
          ),

          // Indicator & Actions
          Padding(
            padding: EdgeInsets.only(bottom: 40.h),
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: controller.pageController,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    dotHeight: 10.h,
                    dotWidth: 10.h,
                    spacing: 8.w,
                    dotColor: Colors.grey.shade300,
                    activeDotColor: AppColors.primaryBlue,
                  ),
                ),
                SizedBox(height: 32.h),

                // BOTTOM BUTTONS
                Obx(() {
                  if (controller.pageIndex.value == 2) {
                    // PAGE 3
                    return Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 1.sw,
                            height: 48.h,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              onPressed: controller.onActivate,
                              child: Text(
                                "Aktifkan Kolaborasi",
                                style: AppTextStyles.labelBold.copyWith(
                                  color: AppColors.mainWhite,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          TextButton(
                            onPressed: controller.onLater,
                            child: Text(
                              "Nanti Saja",
                              style: AppTextStyles.labelBold.copyWith(
                                color: AppColors.primaryBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    // PAGE 1 & 2
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: controller.skip,
                            child: Text(
                              "Skip",
                              style: AppTextStyles.labelBold.copyWith(
                                color: AppColors.primaryBlue,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            onPressed: controller.nextPage,
                            child: Text(
                              "Next",
                              style: AppTextStyles.labelBold.copyWith(
                                color: AppColors.mainWhite,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
