import 'package:bpjs_jkn_2025/app/modules/home/controllers/home_controller.dart';
import 'package:bpjs_jkn_2025/app/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PromoBannerCarousel extends StatefulWidget {
  const PromoBannerCarousel({super.key});

  @override
  State<PromoBannerCarousel> createState() => _PromoBannerCarouselState();
}

class _PromoBannerCarouselState extends State<PromoBannerCarousel> {
  late final PageController _pageController;
  late final HomeController _controller;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
    _controller = Get.find<HomeController>();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150.h,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _controller.bannerImages.length,
            onPageChanged: _controller.onBannerChanged,
            itemBuilder: (context, index) {
              final imagePath = _controller.bannerImages[index];
              return Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.r),
                    color: AppColors.mainWhite,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 8.h),
        Obx(
              () {
            final current = _controller.currentBannerIndex.value;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _controller.bannerImages.length,
                    (index) {
                  final bool isActive = index == current;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    width: isActive ? 10.w : 6.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.primaryBlue
                          : AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
