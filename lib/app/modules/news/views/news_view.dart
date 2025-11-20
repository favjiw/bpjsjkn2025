import 'package:bpjs_jkn_2025/app/modules/news/controllers/news_controller.dart';
import 'package:bpjs_jkn_2025/app/modules/news/widgets/news_featured_card.dart';
import 'package:bpjs_jkn_2025/app/modules/news/widgets/news_filter_chips.dart';
import 'package:bpjs_jkn_2025/app/modules/news/widgets/news_list_item.dart';
import 'package:bpjs_jkn_2025/app/shared/colors.dart';
import 'package:bpjs_jkn_2025/app/shared/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewsView extends GetView<NewsController> {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.secondaryWhite,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),
                // Search bar
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: AppColors.mainWhite,
                    borderRadius: BorderRadius.circular(28.r),
                    border: Border.all(
                      color: AppColors.primaryBlue,
                      width: 1.2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: AppColors.darkGrey,
                        size: 22.sp,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: TextField(
                          controller: controller.searchController,
                          style: AppTextStyles.inputText,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:
                            'Cari berita, testimoni, tips sehat atau gizi...',
                            hintStyle: AppTextStyles.bodyLight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.h),

                // Section title: Artikel
                Text(
                  'Artikel',
                  style: AppTextStyles.labelBold,
                ),
                SizedBox(height: 12.h),

                // Filter chips
                NewsFilterChips(controller: controller),

                SizedBox(height: 16.h),

                // Konten scrollable
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Featured horizontal cards
                    SizedBox(
                      height: 200.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.featuredNews.length,
                        separatorBuilder: (_, __) => SizedBox(width: 12.w),
                        itemBuilder: (context, index) {
                          final item = controller.featuredNews[index];
                          return NewsFeaturedCard(item: item);
                        },
                      ),
                    ),

                    SizedBox(height: 24.h),

                    Text(
                      'Berita Lainnya',
                      style: AppTextStyles.labelBold,
                    ),

                    SizedBox(height: 12.h),

                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.otherNews.length,
                      separatorBuilder: (_, __) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        final item = controller.otherNews[index];
                        return NewsListItem(item: item);
                      },
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
