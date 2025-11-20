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
      height: 110.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/appbar_img.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
