import 'dart:ui';

import 'package:bpjs_jkn_2025/app/modules/chatbot/controllers/chatbot_controller.dart';
import 'package:bpjs_jkn_2025/app/shared/colors.dart';
import 'package:bpjs_jkn_2025/app/shared/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
      case ScenarioType.renewBpjs:
        return _RenewBpjsWidget(isCompleted: isCompleted, onComplete: onComplete);
      case ScenarioType.familyDentalBatch:
        return _FamilyBatchDentalWidget(isCompleted: isCompleted, onComplete: onComplete);
      default:
        return const SizedBox.shrink();
    }
  }
}

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
        return 'Menganalisis intent periksa gigi dan waktu besok untuk pendaftaran antrean.';
      case ScenarioType.familyMode:
        return 'Menganalisis keluhan radang tenggorokan dan menentukan poli untuk Ayah.';
      case ScenarioType.voiceMode:
        return 'Memetakan keluhan diabetes rutin ke Poli Penyakit Dalam dengan input suara.';
      case ScenarioType.renewBpjs:
        return 'Mengecek status kepesertaan, tunggakan, dan menyusun simulasi pembayaran iuran BPJS.';
      case ScenarioType.familyDentalBatch:
        return 'Menganalisis permintaan cek gigi kolektif untuk seluruh anggota keluarga dan menyiapkan pendaftaran bersama.';
      default:
        return '';
    }
  }


  String get _fullLog {
    switch (widget.scenarioType) {
      case ScenarioType.selfBooking:
        return
          'SECTION 1: THINKING\n'
              'Input: "Saya mau periksa gigi besok"\n'
              '- Detected intent: Booking Registration\n'
              '- Entity service: "periksa gigi"\n'
              '- Entity time: "besok"\n'
              '- Channel: Hippo Chat (helper Mobile JKN)\n\n'
              'SECTION 2: REASONING\n'
              'Profile & Eligibility:\n'
              '- Load profil peserta JKN: Andi / No Kartu: ****1234\n'
              '- Status kepesertaan: AKTIF\n'
              '- Segmen: PBPU / Mandiri\n'
              '- Faskes Tingkat 1 terdaftar: Puskesmas Sukamaju\n'
              '- Riwayat iuran 3 bulan terakhir: LUNAS (tidak ada tunggakan)\n\n'
              'Location & Facility Mapping:\n'
              '- Ambil lokasi pengguna dari GPS terakhir (izin lokasi sudah diberikan)\n'
              '- Hitung jarak ke Faskes terdaftar (±3.2 km)\n'
              '- Faskes terdekat yang memenuhi syarat = Faskes terdaftar (FKTP)\n\n'
              'Schedule & Capacity:\n'
              '- "Besok" → 2025-11-21 (hari kerja, bukan hari libur nasional)\n'
              '- Ambil jadwal Poli Gigi di Puskesmas Sukamaju\n'
              '- Jam layanan Poli Gigi: 08.00–12.00\n'
              '- Cek kuota antrean online Mobile JKN untuk tanggal 2025-11-21\n'
              '- Sisa kuota: MASIH TERSEDIA (status: OPEN)\n\n'
              'Risk & Validation Check:\n'
              '- Pastikan tidak ada booking gigi aktif lain atas nama Andi di tanggal yang sama\n'
              '- Pastikan jenis kunjungan: Kunjungan rawat jalan FKTP (bukan IGD)\n'
              '- Pastikan durasi kunjungan masih dalam batas maksimal harian\n\n'
              'SECTION 3: ACTION\n'
              '- Menyusun generate_prefilled_form(\n'
              '    patient = Andi,\n'
              '    faskes  = Puskesmas Sukamaju,\n'
              '    service = Poli Gigi & Mulut,\n'
              '    date    = 2025-11-21,\n'
              '    slot    = rentang 08.00–12.00\n'
              ')\n'
              '- Menandai status form sebagai "Perlu konfirmasi pengguna" sebelum kirim ke sistem antrean Mobile JKN';
      case ScenarioType.familyMode:
        return
          'SECTION 1: THINKING\n'
              'Input: "Ayah saya radang tenggorokan, daftarkan ke poli"\n'
              '- Detected intent: Booking Registration (Family)\n'
              '- Entity symptom: "radang tenggorokan"\n'
              '- Entity target: Ayah / Budi Santoso\n'
              '- Channel: Hippo Chat (helper Mobile JKN)\n\n'
              'SECTION 2: REASONING\n'
              'Participant Validation:\n'
              '- Ambil data keluarga: Budi Santoso terdaftar sebagai anggota keluarga Andi\n'
              '- Status kepesertaan: AKTIF\n'
              '- Segmen: Pekerja / Non-PBI\n'
              '- Faskes Tingkat 1 terdaftar: Klinik Harapan Sehat\n'
              '- Riwayat iuran: LUNAS\n'
              '- Consent Token untuk mewakili Ayah: VALID (aktif 24 jam)\n\n'
              'Symptom → Service Mapping:\n'
              '- Keluhan: Radang tenggorokan\n'
              '- Klasifikasi: Infeksi saluran napas atas → layanan umum\n'
              '- Faskes tujuan: Poli Umum (FKTP)\n\n'
              'Location & Availability:\n'
              '- Cek lokasi pengguna (Andi) untuk validasi mewakili keluarga dalam radius yang wajar\n'
              '- Lokasi: dalam area FKTP terdaftar\n'
              '- Tanggal tidak disebut → gunakan jadwal terdekat (besok)\n'
              '- Besok = 2025-11-21\n'
              '- Jadwal Poli Umum: 08.00–14.00\n'
              '- Kuota antrean besok: TERSEDIA (slot 12–20 masih kosong)\n\n'
              'Risk & Safety Validation:\n'
              '- Cek apakah Budi sudah punya antrean aktif besok → TIDAK ADA\n'
              '- Kondisi tidak darurat → FKTP sesuai\n'
              '- Tidak perlu rujukan\n\n'
              'SECTION 3: ACTION\n'
              '- Menyusun generate_prefilled_form(\n'
              '    patient = Budi Santoso,\n'
              '    faskes  = Klinik Harapan Sehat,\n'
              '    service = Poli Umum,\n'
              '    date    = 2025-11-21,\n'
              '    slot    = 08.00–14.00 (rentang layanan)\n'
              ')\n'
              '- Form disiapkan dan menunggu konfirmasi pengguna sebelum dikirim ke sistem antrean Mobile JKN';
      case ScenarioType.familyDentalBatch:
        return
          'SECTION 1: THINKING\n'
              'Input: "Saya dan keluarga ingin cek gigi besok"\n'
              '- Detected intent: Batch Booking for Family\n'
              '- Entity service: "cek gigi"\n'
              '- Entity time: "besok"\n'
              '- Entity group: "seluruh anggota keluarga"\n'
              '- Channel: Hippo Chat (helper Mobile JKN)\n\n'
              'SECTION 2: REASONING\n'
              'Profile & Eligibility:\n'
              '- Load profil kepala keluarga: Andi / No Kartu: ****1234\n'
              '- Muat seluruh anggota keluarga yang masih AKTIF dalam satu KK\n'
              '- Pastikan segmen kepesertaan tiap anggota masih bisa dilayani di FKTP yang sama\n'
              '- Faskes Tingkat 1 terdaftar: Klinik Harapan Sehat\n'
              '- Riwayat iuran 3 bulan terakhir: LUNAS (tidak ada tunggakan)\n\n'
              'Location & Facility Mapping:\n'
              '- Ambil lokasi pengguna dari GPS terakhir\n'
              '- Hitung jarak ke Klinik Harapan Sehat (±2.5 km)\n'
              '- Pastikan Poli Gigi di FKTP tersebut menerima kunjungan keluarga (lebih dari 1 peserta dalam 1 hari)\n\n'
              'Schedule & Capacity:\n'
              '- "Besok" → 2025-11-21 (hari kerja, bukan hari libur nasional)\n'
              '- Jam layanan Poli Gigi: 08.00–12.00\n'
              '- Ambil slot dr. Rudi – 08.00–10.00 sebagai pilihan utama\n'
              '- Cek kuota antrean: masih tersedia minimal 4 slot untuk keluarga Andi\n\n'
              'Risk & Validation Check:\n'
              '- Pastikan tidak ada antrean gigi aktif sebelumnya untuk tiap anggota di tanggal yang sama\n'
              '- Validasi batas maksimum anggota keluarga dalam satu batch antrean\n\n'
              'SECTION 3: ACTION PLAN\n'
              '- Susun rencana pendaftaran:\n'
              '  • Peserta: Andi + seluruh anggota keluarga aktif\n'
              '  • Faskes: Klinik Harapan Sehat – Poli Gigi\n'
              '  • Jadwal: Besok (21-11-2025), dr. Rudi – 08.00–10.00\n'
              '- Tampilkan ringkasan rencana ke pengguna dan minta konfirmasi: sudah sesuai atau ingin diubah manual melalui form.';

      case ScenarioType.voiceMode:
        return
          'SECTION 1: THINKING\n'
              'Input datang sebagai audio kemudian diubah menjadi teks '
              '"Saya mau kontrol diabetes rutin besok".\n'
              '- Intent: kontrol rutin penyakit kronis\n\n'
              'SECTION 2: REASONING\n'
              '- "Diabetes" → Poli Penyakit Dalam\n'
              '- Input berasal dari suara → balasan dengan suara diaktifkan\n'
              '- "Besok" → 2025-11-21 dan dicek terhadap jadwal Poli Penyakit Dalam\n'
              '- Slot pagi tersedia dan dipilih untuk mengurangi waktu tunggu\n\n'
              'SECTION 3: ACTION\n'
              '- confirm_booking_voice(service=Poli Penyakit Dalam)\n'
              '- Menyiapkan kartu konfirmasi antrean yang dapat dibaca layar dan suara.';
      case ScenarioType.renewBpjs:
        return
          'SECTION 1: THINKING\n'
              'Input: "Perpanjang BPJS" atau permintaan sejenis.\n'
              '- Intent: pembayaran atau perpanjangan iuran JKN KIS\n\n'
              'SECTION 2: REASONING\n'
              'Profil kepesertaan:\n'
              '- Memuat profil keluarga yang terhubung dengan akun\n'
              '- Menentukan peserta yang akan dibayarkan\n'
              '- Mengecek segmen (PBPU, PPU, PBI) dan kelas perawatan\n\n'
              'Status iuran:\n'
              '- Mengambil riwayat pembayaran beberapa bulan terakhir\n'
              '- Menghitung tunggakan dan periode yang belum dibayar\n'
              '- Menghitung total tagihan berdasarkan kelas dan jumlah bulan\n\n'
              'Kanal pembayaran:\n'
              '- Menyusun opsi VA bank dan kanal lain yang masih aktif hari ini\n\n'
              'SECTION 3: ACTION\n'
              '- Menyusun instruksi pembayaran berupa nomor VA dan rincian tagihan\n'
              '- Ditampilkan sebagai form praisi agar mudah dikonfirmasi sebelum pembayaran.';
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
                width: 38.w,
                height: 38.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(6.w),
                child: Image.asset(
                  'assets/mobile_jkn_logo.png',
                  fit: BoxFit.contain,
                ),
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

class _DropdownFormField extends StatefulWidget {
  final String label;
  final List<String> options;
  final String initialValue;

  const _DropdownFormField({
    required this.label,
    required this.options,
    required this.initialValue,
  });

  @override
  State<_DropdownFormField> createState() => _DropdownFormFieldState();
}

class _DropdownFormFieldState extends State<_DropdownFormField> {
  late String _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: AppTextStyles.bodyLight,
          ),
          SizedBox(height: 4.h),
          DropdownButtonFormField<String>(
            value: _selected,
            items: widget.options
                .map(
                  (opt) => DropdownMenuItem<String>(
                value: opt,
                child: Text(
                  opt,
                  style: AppTextStyles.bodySmall,
                ),
              ),
            )
                .toList(),
            onChanged: (value) {
              if (value == null) return;
              setState(() {
                _selected = value;
              });
            },
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

class _ComplaintField extends StatelessWidget {
  final String initialText;

  const _ComplaintField({
    required this.initialText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Keluhan',
            style: AppTextStyles.bodyLight,
          ),
          SizedBox(height: 4.h),
          TextFormField(
            initialValue: initialText,
            maxLines: 3,
            style: AppTextStyles.bodySmall,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              isDense: true,
              hintText: 'Silakan isi keluhan...',
              hintStyle: AppTextStyles.bodyLight,
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
  final String facilityName;
  final String doctor;
  final String poli;
  final String tanggal;
  final String kodeBooking;
  final String nomorAntrean;
  final String estimasi;

  const _SuccessTicketCard({
    super.key,
    required this.facilityName,
    required this.doctor,
    required this.poli,
    required this.tanggal,
    required this.kodeBooking,
    required this.nomorAntrean,
    required this.estimasi,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.mainWhite,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              facilityName,
              style: AppTextStyles.labelBold.copyWith(
                fontSize: 18.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 4.h),
          Center(
            child: Text(
              doctor,
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 14.sp,
                color: AppColors.darkGrey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 12.h),
          Divider(),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Poli', style: AppTextStyles.bodySmallSemiBold),
              Text(poli, style: AppTextStyles.bodySmall),
            ],
          ),
          SizedBox(height: 6.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tanggal Rujukan',
                style: AppTextStyles.bodySmallSemiBold,
              ),
              SizedBox(height: 4),
              Text(
                tanggal,
                style: AppTextStyles.bodySmall,
                softWrap: true,
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Kode Booking', style: AppTextStyles.bodySmallSemiBold),
              Text(kodeBooking, style: AppTextStyles.bodySmall),
            ],
          ),
          SizedBox(height: 12.h),
          Divider(height: 1),
          SizedBox(height: 12.h),
          Center(
            child: Text(
              'Nomor Antrean Poliklinik',
              style: AppTextStyles.bodySmallSemiBold.copyWith(fontSize: 14.sp),
            ),
          ),
          SizedBox(height: 6.h),
          Center(
            child: Text(
              nomorAntrean,
              style: AppTextStyles.labelBold.copyWith(
                fontSize: 48.sp,
                color: AppColors.primaryBlue,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text('Sisa Antrean', style: AppTextStyles.bodySmallSemiBold),
                  SizedBox(height: 4.h),
                  Text('16', style: AppTextStyles.bodySmall),
                ],
              ),
              Column(
                children: [
                  Text('Peserta Dilayani', style: AppTextStyles.bodySmallSemiBold),
                  SizedBox(height: 4.h),
                  Text('0', style: AppTextStyles.bodySmall),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Center(
            child: Column(
              children: [
                Text(
                  'Estimasi Dilayani',
                  style: AppTextStyles.bodySmallSemiBold,
                ),
                SizedBox(height: 4.h),
                Text(
                  estimasi,
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 45.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryBlue,
                        AppColors.secondaryBlue,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Center(
                    child: Text(
                      'Check-In',
                      style: AppTextStyles.labelBold.copyWith(
                        color: AppColors.mainWhite,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 45.h,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFFF8C3B),
                        Color(0xFFFF6B00),
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Center(
                    child: Text(
                      'Batalkan',
                      style: AppTextStyles.labelBold.copyWith(
                        color: AppColors.mainWhite,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 18.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF4FAFF),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              'Harap datang 30 menit sebelum waktu pelayanan dan sudah berada di poli.',
              style: AppTextStyles.bodyLight.copyWith(fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentSuccessCard extends StatelessWidget {
  final String peserta;
  final String periode;
  final String nominal;
  final String channel;
  final String vaNumber;

  const _PaymentSuccessCard({
    super.key,
    required this.peserta,
    required this.periode,
    required this.nominal,
    required this.channel,
    required this.vaNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.mainWhite,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaksi Iuran Berhasil (Demo)',
            style: AppTextStyles.labelBold.copyWith(
              color: Colors.green,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Peserta',
            style: AppTextStyles.bodySmallSemiBold,
          ),
          Text(
            peserta,
            style: AppTextStyles.bodySmall,
          ),
          SizedBox(height: 8.h),
          Text(
            'Periode Iuran',
            style: AppTextStyles.bodySmallSemiBold,
          ),
          Text(
            periode,
            style: AppTextStyles.bodySmall,
          ),
          SizedBox(height: 8.h),
          Text(
            'Nominal',
            style: AppTextStyles.bodySmallSemiBold,
          ),
          Text(
            nominal,
            style: AppTextStyles.bodySmall,
          ),
          SizedBox(height: 8.h),
          Text(
            'Metode Pembayaran',
            style: AppTextStyles.bodySmallSemiBold,
          ),
          Text(
            channel,
            style: AppTextStyles.bodySmall,
          ),
          SizedBox(height: 8.h),
          Text(
            'Nomor Virtual Account',
            style: AppTextStyles.bodySmallSemiBold,
          ),
          Text(
            vaNumber,
            style: AppTextStyles.bodySmall.copyWith(
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF4FAFF),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              'Untuk keperluan demo, pembayaran dianggap sudah berhasil dan status kepesertaan tetap aktif.',
              style: AppTextStyles.bodyLight.copyWith(fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }
}

// ===================== Scenario 1: Self Booking =====================

class _SelfBookingWidget extends StatefulWidget {
  final bool isCompleted;
  final VoidCallback onComplete;

  const _SelfBookingWidget({
    required this.isCompleted,
    required this.onComplete,
  });

  @override
  State<_SelfBookingWidget> createState() => _SelfBookingWidgetState();
}

class _SelfBookingWidgetState extends State<_SelfBookingWidget> {
  bool _formSpoken = false;
  bool _successSpoken = false;

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<ChatbotController>();

    if (widget.isCompleted) {
      if (!_successSpoken) {
        _successSpoken = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ctrl.speakForFormOrSuccess(
            'Tiket antrean Poli Gigi dan Mulut berhasil dibuat. '
                'Nomor antrean enam belas di fasilitas kesehatan yang ditampilkan di layar.',
          );
        });
      }

      return const _SuccessTicketCard(
        facilityName: 'RS HERMINA ARCAMANIK',
        doctor: 'Justine Artwanti, dr, SpPD',
        poli: 'Penyakit Dalam',
        tanggal: '18-Sep-2025',
        kodeBooking: '54704828',
        nomorAntrean: '16',
        estimasi: '01-10-2025 13.30',
      );
    }

    if (!_formSpoken) {
      _formSpoken = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ctrl.speakForFormOrSuccess(
          'Berikut form pendaftaran Poli Gigi dan Mulut untuk Anda. '
              'Pilih peserta, Andi (0001234567890), Faskes tingkat pertama, Puskesmas Sukamaju, pilih poli, poli gigi dan mulut, tanggal, jadwal tenaga medis, lalu isi keluhan. '
              'Setelah selesai, tekan tombol Simpan di bagian bawah.',
        );
      });
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
            'Fasilitas Kesehatan Tingkat Pertama',
            style: AppTextStyles.bodySmallSemiBold,
          ),
          SizedBox(height: 8.h),
          const _DropdownFormField(
            label: 'Peserta',
            options: [
              'Andi (0001234567890)',
              'Siti (0009876543210)',
              'Rena (0005678901234)',
            ],
            initialValue: 'Andi (0001234567890)',
          ),
          const _DropdownFormField(
            label: 'Faskes Tingkat Pertama',
            options: [
              'PUSKESMAS SUKAMAJU',
              'KLINIK HARAPAN SEHAT',
              'RSIA MELATI',
            ],
            initialValue: 'PUSKESMAS SUKAMAJU',
          ),
          const _DropdownFormField(
            label: 'Pilih Poli',
            options: [
              'POLI GIGI dan MULUT',
              'POLI UMUM',
              'POLI ANAK',
            ],
            initialValue: 'POLI GIGI dan MULUT',
          ),
          const _DropdownFormField(
            label: 'Pilih Tanggal Daftar',
            options: [
              'Besok (21-11-2025)',
              'Lusa (22-11-2025)',
              'Minggu depan (28-11-2025)',
            ],
            initialValue: 'Besok (21-11-2025)',
          ),
          const _DropdownFormField(
            label: 'Pilih Jadwal',
            options: [
              'Pilih Tenaga Medis',
              'drg. Rani – 08.00–10.00',
              'drg. Fajar – 10.00–12.00',
            ],
            initialValue: 'Pilih Tenaga Medis',
          ),
          const _ComplaintField(
            initialText: 'Periksa gigi besok.',
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
              onPressed: widget.onComplete,
              child: Text(
                'Simpan',
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

// ===================== Scenario 2: Family Mode =====================

class _FamilyModeWidget extends StatefulWidget {
  final bool isCompleted;
  final VoidCallback onComplete;

  const _FamilyModeWidget({
    required this.isCompleted,
    required this.onComplete,
  });

  @override
  State<_FamilyModeWidget> createState() => _FamilyModeWidgetState();
}

class _FamilyModeWidgetState extends State<_FamilyModeWidget> {
  bool _formSpoken = false;
  bool _successSpoken = false;

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<ChatbotController>();

    if (widget.isCompleted) {
      if (!_successSpoken) {
        _successSpoken = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ctrl.speakForFormOrSuccess(
            'Tiket antrean Poli Umum untuk Bapak Budi berhasil dibuat. '
                'Nomor antrean dua belas di fasilitas kesehatan yang tertera pada layar.',
          );
        });
      }

      return const _SuccessTicketCard(
        facilityName: 'PUSKESMAS SUKAMAJU',
        doctor: 'dr. Rudi, SpTHT',
        poli: 'Poli Umum',
        tanggal: '21-Nov-2025',
        kodeBooking: 'A12BUDI',
        nomorAntrean: '12',
        estimasi: '21-11-2025 09.15',
      );
    }

    if (!_formSpoken) {
      _formSpoken = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ctrl.speakForFormOrSuccess(
          'Berikut form pendaftaran untuk Ayah Anda. '
              'Pilih peserta Bapak Budi, pastikan fasilitas kesehatan dan poli sudah sesuai, '
              'pilih tanggal kunjungan dan jadwal dokter, lalu isi keluhan radang tenggorokan. '
              'Akhiri dengan menekan tombol Simpan.',
        );
      });
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
            'Fasilitas Kesehatan Tingkat Pertama',
            style: AppTextStyles.bodySmallSemiBold,
          ),
          SizedBox(height: 8.h),
          const _DropdownFormField(
            label: 'Peserta',
            options: [
              'Bp. Budi Santoso (000111222333)',
              'Ibu Ani (000444555666)',
              'Andi (0001234567890)',
            ],
            initialValue: 'Bp. Budi Santoso (000111222333)',
          ),
          const _DropdownFormField(
            label: 'Faskes Tingkat Pertama',
            options: [
              'KLINIK HARAPAN SEHAT',
              'PUSKESMAS SUKAMAJU',
              'RSIA MELATI',
            ],
            initialValue: 'KLINIK HARAPAN SEHAT',
          ),
          const _DropdownFormField(
            label: 'Pilih Poli',
            options: [
              'POLI UMUM',
              'POLI GIGI dan MULUT',
              'POLI THT',
            ],
            initialValue: 'POLI UMUM',
          ),
          const _DropdownFormField(
            label: 'Pilih Tanggal Daftar',
            options: [
              'Besok (21-11-2025)',
              'Hari ini (20-11-2025)',
              'Lusa (22-11-2025)',
            ],
            initialValue: 'Besok (21-11-2025)',
          ),
          const _DropdownFormField(
            label: 'Pilih Jadwal',
            options: [
              'Pilih Tenaga Medis',
              'dr. Rudi – 08.00–10.00',
              'dr. Sari – 10.00–12.00',
            ],
            initialValue: 'Pilih Tenaga Medis',
          ),
          const _ComplaintField(
            initialText: 'Radang tenggorokan, nyeri saat menelan.',
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
              onPressed: widget.onComplete,
              child: Text(
                'Simpan',
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

// ===================== Scenario 3: Voice Mode =====================

class _VoiceModeWidget extends StatefulWidget {
  final bool isCompleted;
  final VoidCallback onComplete;

  const _VoiceModeWidget({
    required this.isCompleted,
    required this.onComplete,
  });

  @override
  State<_VoiceModeWidget> createState() => _VoiceModeWidgetState();
}

class _VoiceModeWidgetState extends State<_VoiceModeWidget> {
  bool _formSpoken = false;
  bool _successSpoken = false;

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<ChatbotController>();

    if (widget.isCompleted) {
      if (!_successSpoken) {
        _successSpoken = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ctrl.speakForFormOrSuccess(
            'Nomor antrean kontrol diabetes untuk Bapak Agus berhasil dibuat. '
                'Nomor antrean sepuluh, silakan datang sesuai estimasi waktu yang tertera.',
          );
        });
      }

      return const _SuccessTicketCard(
        facilityName: 'RS HERMINA ARCAMANIK',
        doctor: 'Justine Artwanti, dr, SpPD',
        poli: 'Penyakit Dalam',
        tanggal: '21-Nov-2025',
        kodeBooking: 'B10AGUS',
        nomorAntrean: '10',
        estimasi: '21-11-2025 08.00',
      );
    }

    if (!_formSpoken) {
      _formSpoken = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ctrl.speakForFormOrSuccess(
          'Berikut kartu konfirmasi kontrol diabetes Bapak Agus. '
              'Jika sudah sesuai dengan jadwal dan poli yang diinginkan, tekan tombol Ya ambil saja untuk membuat antrean.',
        );
      });
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
            'Audio bot: “Baik Pak Agus. Kontrol Diabetes di Poli Penyakit Dalam '
                'tersedia besok jam 08.00. Apakah mau diambil?”',
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
              onPressed: widget.onComplete,
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

// ===================== Scenario 4: Renew BPJS =====================

class _RenewBpjsWidget extends StatefulWidget {
  final bool isCompleted;
  final VoidCallback onComplete;

  const _RenewBpjsWidget({
    required this.isCompleted,
    required this.onComplete,
  });

  @override
  State<_RenewBpjsWidget> createState() => _RenewBpjsWidgetState();
}

class _RenewBpjsWidgetState extends State<_RenewBpjsWidget> {
  bool _formSpoken = false;
  bool _successSpoken = false;

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<ChatbotController>();

    if (widget.isCompleted) {
      if (!_successSpoken) {
        _successSpoken = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ctrl.speakForFormOrSuccess(
            'Simulasi pembayaran iuran BPJS berhasil. '
                'Status peserta dianggap sudah lunas untuk keperluan demo.',
          );
        });
      }

      return const _PaymentSuccessCard(
        peserta: 'Andi (0001234567890)',
        periode: 'Iuran November 2025 sampai Januari 2026',
        nominal: 'Rp 450.000',
        channel: 'Virtual Account BRI',
        vaNumber: '77777 1234 5678 901',
      );
    }

    if (!_formSpoken) {
      _formSpoken = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ctrl.speakForFormOrSuccess(
          'Berikut simulasi perpanjangan iuran BPJS. '
              'Pilih peserta, segmen kepesertaan, periode iuran, kelas perawatan, dan metode pembayaran. '
              'Nominal tagihan akan muncul, lalu tekan tombol Simpan untuk membuat instruksi pembayaran.',
        );
      });
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
            'Perpanjang Iuran BPJS',
            style: AppTextStyles.bodySmallSemiBold,
          ),
          SizedBox(height: 8.h),
          const _DropdownFormField(
            label: 'Peserta',
            options: [
              'Andi (0001234567890)',
              'Ibu Siti (0009876543210)',
              'Bp. Budi (000111222333)',
            ],
            initialValue: 'Andi (0001234567890)',
          ),
          const _DropdownFormField(
            label: 'Segmen Kepesertaan',
            options: [
              'PBPU Mandiri',
              'PPU Badan Usaha',
              'Penerima Bantuan Iuran (PBI)',
            ],
            initialValue: 'PBPU Mandiri',
          ),
          const _DropdownFormField(
            label: 'Periode Iuran',
            options: [
              '1 bulan ke depan (Nov 2025)',
              '2 bulan ke depan (Nov–Des 2025)',
              '3 bulan ke depan (Nov 2025–Jan 2026)',
            ],
            initialValue: '3 bulan ke depan (Nov 2025–Jan 2026)',
          ),
          const _DropdownFormField(
            label: 'Kelas Perawatan',
            options: [
              'Kelas 1',
              'Kelas 2',
              'Kelas 3',
            ],
            initialValue: 'Kelas 2',
          ),
          const _DropdownFormField(
            label: 'Metode Pembayaran',
            options: [
              'Virtual Account BRI',
              'Virtual Account BNI',
              'QRIS dan e-Wallet',
            ],
            initialValue: 'Virtual Account BRI',
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Perkiraan Tagihan',
                  style: AppTextStyles.bodyLight,
                ),
                SizedBox(height: 4.h),
                TextFormField(
                  initialValue: 'Rp 450.000',
                  readOnly: true,
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
              onPressed: widget.onComplete,
              child: Text(
                'Simpan',
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
// ===================== Scenario 2B: Family Dental Batch =====================

class _FamilyBatchDentalWidget extends StatefulWidget {
  final bool isCompleted;
  final VoidCallback onComplete;

  const _FamilyBatchDentalWidget({
    required this.isCompleted,
    required this.onComplete,
  });

  @override
  State<_FamilyBatchDentalWidget> createState() => _FamilyBatchDentalWidgetState();
}

class _FamilyBatchDentalWidgetState extends State<_FamilyBatchDentalWidget> {
  bool _formSpoken = false;
  bool _successSpoken = false;

  // opsi peserta keluarga
  final List<String> _familyOptions = [
    'Semua anggota keluarga di KK Andi',
    'Hanya Siti',
    'Hanya Andi',
    'Hanya Rena',
  ];

  String? _selectedParticipant = 'Semua anggota keluarga di KK Andi';

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<ChatbotController>();

    // jika skenario sudah selesai → tampilkan kartu sukses
    if (widget.isCompleted) {
      if (!_successSpoken) {
        _successSpoken = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ctrl.speakForFormOrSuccess(
            'Pendaftaran cek gigi untuk seluruh anggota keluarga di Klinik Harapan Sehat berhasil dibuat. '
                'Silakan cek detail antrean di layar.',
          );
        });
      }

      return const _SuccessTicketCard(
        facilityName: 'KLINIK HARAPAN SEHAT',
        poli: 'Poli Gigi dan Mulut',
        doctor: 'dr. Rudi',
        tanggal: 'Jumat, 21 November 2025 • 08.00–10.00',
        kodeBooking: 'JKN-1121-0045',
        nomorAntrean: 'A017–A020 (keluarga)',
        estimasi: '08.15–09.30 WIB',
      );
    }

    // talkback saat form pertama kali muncul
    if (!_formSpoken) {
      _formSpoken = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ctrl.speakForFormOrSuccess(
          'Ini adalah form pendaftaran cek gigi untuk keluarga. '
              'Pilih peserta dengan mengetuk salah satu nama, lalu sesuaikan jadwal sebelum menyimpan.',
        );
      });
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.mainWhite,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Form Pendaftaran Cek Gigi Keluarga',
            style: AppTextStyles.labelBold,
          ),
          SizedBox(height: 4.h),
          Text(
            'Sesuaikan peserta, faskes, dan jadwal jika diperlukan sebelum menyimpan.',
            style: AppTextStyles.bodyLight,
          ),
          SizedBox(height: 12.h),

          // PESERTA: PILIH SATU, TAMPIL SEBAGAI ROW DENGAN X
          Text(
            'Peserta',
            style: AppTextStyles.bodySmallSemiBold,
          ),
          SizedBox(height: 6.h),

          // deretan opsi peserta (single select)
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: _familyOptions.map((option) {
              final bool isSelected = _selectedParticipant == option;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedParticipant = option;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryBlue : AppColors.secondaryWhite,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: isSelected ? AppColors.primaryBlue : AppColors.lightGrey,
                    ),
                  ),
                  child: Text(
                    option,
                    style: isSelected
                        ? AppTextStyles.profileUnit.copyWith(
                      color: AppColors.mainWhite,
                    )
                        : AppTextStyles.profileLabel,
                  ),
                ),
              );
            }).toList(),
          ),

          SizedBox(height: 8.h),

          // row peserta yang terpilih dengan tombol silang di kanan
          if (_selectedParticipant != null)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              margin: EdgeInsets.only(top: 4.h),
              decoration: BoxDecoration(
                color: AppColors.secondaryWhite,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: AppColors.lightGrey),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedParticipant!,
                      style: AppTextStyles.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectedParticipant = null;
                      });
                    },
                    child: Icon(
                      Icons.close,
                      size: 18.sp,
                      color: AppColors.darkGrey,
                    ),
                  ),
                ],
              ),
            ),

          SizedBox(height: 14.h),

          Text(
            'Fasilitas Kesehatan',
            style: AppTextStyles.bodySmallSemiBold,
          ),
          SizedBox(height: 4.h),
          Text(
            'KLINIK HARAPAN SEHAT – Poli Gigi dan Mulut',
            style: AppTextStyles.bodySmall,
          ),
          SizedBox(height: 12.h),

          const _DropdownFormField(
            label: 'Tanggal Kunjungan',
            options: [
              'Besok (21-11-2025)',
              'Hari ini (20-11-2025)',
              'Lusa (22-11-2025)',
            ],
            initialValue: 'Besok (21-11-2025)',
          ),
          const _DropdownFormField(
            label: 'Pilih Jadwal',
            options: [
              'Pilih Tenaga Medis',
              'dr. Rudi – 08.00–10.00',
              'dr. Sari – 10.00–12.00',
            ],
            initialValue: 'dr. Rudi – 08.00–10.00',
          ),

          const _ComplaintField(
            initialText: 'Cek kesehatan gigi berkala seluruh anggota keluarga.',
          ),

          SizedBox(height: 10.h),
          SizedBox(
            width: double.infinity,
            height: 40.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              onPressed: widget.onComplete,
              child: Text(
                'Simpan',
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
