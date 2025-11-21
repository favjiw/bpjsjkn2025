import 'dart:async';

import 'package:bpjs_jkn_2025/app/modules/chatbot/controllers/chatbot_controller.dart';
import 'package:bpjs_jkn_2025/app/modules/chatbot/widgets/chatbot_scenarios.dart';
import 'package:bpjs_jkn_2025/app/shared/colors.dart';
import 'package:bpjs_jkn_2025/app/shared/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatbotView extends GetView<ChatbotController> {
  const ChatbotView({super.key});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.secondaryWhite,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.mainWhite,
          elevation: 0,
          title: Row(
            children: [
              SizedBox(width: 5.w,),
              Image.asset('assets/bot_ic.png', width: 35.w, fit: BoxFit.cover,),
              SizedBox(width: 12.w,),
              Text(
                'Hippo',
                style: AppTextStyles.labelBold,
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Obx(
                      () {
                    final scenarioType = controller.currentScenario.value;
                    final isCompleted = controller.isScenarioCompleted.value;
                    final isLoading = controller.isLoadingScenario.value;
                    final msgs = controller.messages;

                    return ListView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      children: [
                        for (final msg in msgs)
                          _ChatBubble(
                            message: msg,
                          ),

                        if (scenarioType != ScenarioType.none) ...[
                          SizedBox(height: 12.h),
                          LoadingAgenticRow(
                            scenarioType: scenarioType,
                            isLoading: isLoading,
                          ),
                        ],

                        if (!isLoading && scenarioType != ScenarioType.none) ...[
                          SizedBox(height: 12.h),
                          ScenarioPanel(
                            scenarioType: scenarioType,
                            isCompleted: isCompleted,
                            onComplete: controller.completeScenario,
                          ),
                        ],

                        SizedBox(height: 80.h),
                      ],
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 12.h),
                decoration: BoxDecoration(
                  color: AppColors.mainWhite,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 6,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textController,
                        style: AppTextStyles.inputText,
                        decoration: InputDecoration(
                          hintText:
                          'Ketik perintah, contoh: Saya mau periksa gigi besok',
                          hintStyle: AppTextStyles.bodyLight,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.r),
                            borderSide: BorderSide(
                              color: AppColors.primaryBlue,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 10.h,
                          ),
                        ),
                        onSubmitted: (value) {
                          controller.sendMessage(value);
                          textController.clear();
                        },
                      ),
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: () {
                        controller.sendMessage(textController.text);
                        textController.clear();
                      },
                      child: Container(
                        width: 44.w,
                        height: 44.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              AppColors.primaryBlue,
                              AppColors.secondaryBlue,
                            ],
                          ),
                        ),
                        child: Icon(
                          Icons.send,
                          size: 20.sp,
                          color: AppColors.mainWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const _ChatBubble({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;

    final align =
    isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final color =
    isUser ? AppColors.primaryBlue : AppColors.mainWhite;
    final textColor =
    isUser ? AppColors.mainWhite : AppColors.mainBlack;
    final radius = isUser
        ? BorderRadius.only(
      topLeft: Radius.circular(16.r),
      topRight: Radius.circular(16.r),
      bottomLeft: Radius.circular(16.r),
    )
        : BorderRadius.only(
      topLeft: Radius.circular(16.r),
      topRight: Radius.circular(16.r),
      bottomRight: Radius.circular(16.r),
    );

    return Column(
      crossAxisAlignment: align,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 4.h),
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 8.h,
          ),
          decoration: BoxDecoration(
            color: color,
            borderRadius: radius,
            boxShadow: [
              if (!isUser)
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
          child: isUser
              ? Text(
            message.text,
            style: AppTextStyles.bodySmall.copyWith(
              color: textColor,
            ),
          )
              : TypewriterText(
            text: message.text,
            style: AppTextStyles.bodySmall.copyWith(
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }
}

class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration speed;

  const TypewriterText({
    super.key,
    required this.text,
    required this.style,
    this.speed = const Duration(milliseconds: 25),
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  int _visibleChars = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  @override
  void didUpdateWidget(covariant TypewriterText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _timer?.cancel();
      _visibleChars = 0;
      _startTyping();
    }
  }

  void _startTyping() {
    _timer = Timer.periodic(widget.speed, (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_visibleChars >= widget.text.length) {
        timer.cancel();
      } else {
        setState(() {
          _visibleChars++;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textToShow =
    widget.text.substring(0, _visibleChars.clamp(0, widget.text.length));
    return Text(
      textToShow,
      style: widget.style,
    );
  }
}
