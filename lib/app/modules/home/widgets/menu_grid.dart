import 'package:bpjs_jkn_2025/app/modules/home/controllers/home_controller.dart';
import 'package:bpjs_jkn_2025/app/modules/home/widgets/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuGrid extends StatelessWidget {
  final HomeController controller;

  const MenuGrid({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.menuItems.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 8.w,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final item = controller.menuItems[index];
          return MenuItem(data: item);
        },
      ),
    );
  }
}
