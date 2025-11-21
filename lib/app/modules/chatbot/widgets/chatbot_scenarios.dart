import 'package:bpjs_jkn_2025/app/modules/chatbot/controllers/chatbot_controller.dart';
import 'package:bpjs_jkn_2025/app/shared/colors.dart';
import 'package:bpjs_jkn_2025/app/shared/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScenarioPanel extends StatelessWidget {
  final ScenarioType scenarioType;
  final bool isCompleted;
  final VoidCallback onComplete;

  const ScenarioPanel({
    super.key,
    required this.scenarioType,
    required this.isCompleted,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    if (scenarioType == ScenarioType.none) {
      return const SizedBox.shrink();
    }

    switch (scenarioType) {
      case ScenarioType.selfBooking:
        return _SelfBookingWidget(isCompleted: isCompleted, onComplete: onComplete);
      case ScenarioType.familyMode:
        return _FamilyModeWidget(isCompleted: isCompleted, onComplete: onComplete);
      case ScenarioType.voiceMode:
        return _VoiceModeWidget(isCompleted: isCompleted, onComplete: onComplete);
      default:
        return const SizedBox.shrink();
    }
  }
}

/// Row agentic (avatar + log) yang selalu tampil.
/// Ketika [isLoading] true, lingkaran di luar avatar berupa CircularProgressIndicator.
/// Ketika [isLoading] false, hanya menampilkan avatar bot saja (tanpa loading).
class LoadingAgenticRow extends StatefulWidget {
  final ScenarioType scenarioType;
  final bool isLoading;

  const LoadingAgenticRow({
    super.key,
    required this.scenarioType,
    required this.isLoading,
  });

  @override
  State<LoadingAgenticRow> createState() => _LoadingAgenticRowState();
}

class _LoadingAgenticRowState extends State<LoadingAgenticRow> {
  bool _expanded = false;

  String get _summary {
    switch (widget.scenarioType) {
      case ScenarioType.selfBooking:
        return 'Menganalisis intent "periksa gigi" dan waktu "besok" untuk pendaftaran antrean.';
      case ScenarioType.familyMode:
        return 'Menganalisis keluhan radang tenggorokan dan menentukan poli untuk Ayah.';
      case ScenarioType.voiceMode:
        return 'Memetakan keluhan diabetes rutin ke Poli Penyakit Dalam (mode suara).';
      default:
        return '';
    }
  }

  String get _fullLog {
    switch (widget.scenarioType) {
      case ScenarioType.selfBooking:
        return
          'SECTION 1: THINKING\n'
              '- Intent: Booking Registration\n'
              '- Input: "periksa gigi", "besok"\n\n'
              'SECTION 2: REASONING\n'
              '- "Gigi" → Poli Gigi & Mulut\n'
              '- "Besok" → 2025-11-21\n'
              '- Profile: Active\n'
              '- Slot: 08.00 - 12.00\n\n'
              'SECTION 3: ACTION\n'
              '- generate_prefilled_form(patient=Andi, service=Poli Gigi & Mulut)';
      case ScenarioType.familyMode:
        return
          'SECTION 1: THINKING\n'
              '- Intent: Booking Registration\n'
              '- Complaint: "Radang tenggorokan"\n'
              '- Target: Father (Budi)\n\n'
              'SECTION 2: REASONING\n'
              '- Consent Token: VALID\n'
              '- Mapping: Keluhan → Poli Umum (FKTP)\n'
              '- Time: Default besok (next available)\n\n'
              'SECTION 3: ACTION\n'
              '- generate_prefilled_form(patient=Budi, service=Poli Umum)';
      case ScenarioType.voiceMode:
        return
          'SECTION 1: THINKING\n'
              '- Input Type: Voice\n'
              '- Transcript: "Saya mau kontrol diabetes rutin besok"\n\n'
              'SECTION 2: REASONING\n'
              '- Keyword: Diabetes → Poli Penyakit Dalam\n'
              '- Modality: Voice + TTS Enabled\n'
              '- Time: Besok → 2025-11-21\n\n'
              'SECTION 3: ACTION\n'
              '- confirm_booking_voice(service=Poli Penyakit Dalam)';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.scenarioType == ScenarioType.none) {
      return const SizedBox.shrink();
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 60.w,
          height: 60.w,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (widget.isLoading)
                SizedBox(
                  width: 52.w,
                  height: 52.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primaryBlue,
                    ),
                  ),
                )
              else
                Container(
                  width: 52.w,
                  height: 52.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primaryBlue,
                      width: 2,
                    ),
                  ),
                ),
              Container(
                width: 35.w,
                height: 35.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(6.w),
                child: Image.asset('assets/bot_ic.png', fit: BoxFit.cover,),
              ),
            ],
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: AppColors.mainWhite,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Hippo (Log)',
                          style: AppTextStyles.bodySmallSemiBold,
                        ),
                      ),
                      Icon(
                        _expanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: AppColors.darkGrey,
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    _summary,
                    style: AppTextStyles.bodySmall,
                  ),
                  if (_expanded) ...[
                    SizedBox(height: 8.h),
                    Divider(height: 1, color: AppColors.lightGrey),
                    SizedBox(height: 8.h),
                    Text(
                      _fullLog,
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PrefilledFormField extends StatelessWidget {
  final String label;
  final String value;

  const _PrefilledFormField({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.bodyLight,
          ),
          SizedBox(height: 4.h),
          TextFormField(
            initialValue: value,
            style: AppTextStyles.bodySmall,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 8.h,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: AppColors.primaryBlue,
                  width: 1.2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: AppColors.secondaryBlue,
                  width: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SuccessTicketCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SuccessTicketCard({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.mainWhite,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tiket Antrean Sukses',
            style: AppTextStyles.bodySmallSemiBold.copyWith(
              color: Colors.green,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            title,
            style: AppTextStyles.bodySmallSemiBold,
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }
}

// ========== Scenario 1: Self Booking ==========

class _SelfBookingWidget extends StatelessWidget {
  final bool isCompleted;
  final VoidCallback onComplete;

  const _SelfBookingWidget({
    required this.isCompleted,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    if (isCompleted) {
      return _SuccessTicketCard(
        title: 'Antrean Poli Gigi & Mulut',
        subtitle: 'Nomor antrean: G-07\nTanggal: 2025-11-21\nPasien: Andi',
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.mainWhite,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Form Pendaftaran (Pre-filled)',
            style: AppTextStyles.bodySmallSemiBold,
          ),
          SizedBox(height: 8.h),
          const _PrefilledFormField(
            label: 'Pasien',
            value: 'Andi',
          ),
          const _PrefilledFormField(
            label: 'Poli',
            value: 'Poli Gigi & Mulut',
          ),
          const _PrefilledFormField(
            label: 'Tanggal',
            value: '21-11-2025',
          ),
          const _PrefilledFormField(
            label: 'Jam',
            value: 'Antara 08.00 - 12.00',
          ),
          SizedBox(height: 10.h),
          SizedBox(
            width: double.infinity,
            height: 40.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              onPressed: onComplete,
              child: Text(
                'SIMPAN',
                style: AppTextStyles.labelBold.copyWith(
                  color: AppColors.mainWhite,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ========== Scenario 2: Family Mode ==========

class _FamilyModeWidget extends StatelessWidget {
  final bool isCompleted;
  final VoidCallback onComplete;

  const _FamilyModeWidget({
    required this.isCompleted,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    if (isCompleted) {
      return _SuccessTicketCard(
        title: 'Antrean Poli Umum',
        subtitle: 'Nomor antrean: A-12\nTanggal: 2025-11-21\nPasien: Bp. Budi Santoso',
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.mainWhite,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Form Pendaftaran (Pre-filled)',
            style: AppTextStyles.bodySmallSemiBold,
          ),
          SizedBox(height: 8.h),
          const _PrefilledFormField(
            label: 'Pasien',
            value: 'Bp. Budi Santoso',
          ),
          const _PrefilledFormField(
            label: 'Poli',
            value: 'Poli Umum',
          ),
          const _PrefilledFormField(
            label: 'Tanggal',
            value: '21-11-2025',
          ),
          const _PrefilledFormField(
            label: 'Jam',
            value: 'Next available slot',
          ),
          SizedBox(height: 10.h),
          SizedBox(
            width: double.infinity,
            height: 40.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              onPressed: onComplete,
              child: Text(
                'SIMPAN',
                style: AppTextStyles.labelBold.copyWith(
                  color: AppColors.mainWhite,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ========== Scenario 3: Voice Mode ==========

class _VoiceModeWidget extends StatelessWidget {
  final bool isCompleted;
  final VoidCallback onComplete;

  const _VoiceModeWidget({
    required this.isCompleted,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    if (isCompleted) {
      return _SuccessTicketCard(
        title: 'Antrean Poli Penyakit Dalam',
        subtitle:
        'Nomor antrean: B-10\nTanggal: 2025-11-21\nPasien: Pak Agus\nReminder: 2 jam sebelum jadwal.',
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.mainWhite,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Konfirmasi (Voice Mode)',
            style: AppTextStyles.bodySmallSemiBold,
          ),
          SizedBox(height: 8.h),
          Text(
            'Audio (Bot): "Baik Pak Agus. Kontrol Diabetes di Poli Penyakit Dalam '
                'tersedia besok jam 08.00. Apakah mau diambil?"',
            style: AppTextStyles.bodySmall,
          ),
          SizedBox(height: 10.h),
          SizedBox(
            width: double.infinity,
            height: 40.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              onPressed: onComplete,
              child: Text(
                'Ya, ambil saja',
                style: AppTextStyles.labelBold.copyWith(
                  color: AppColors.mainWhite,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
