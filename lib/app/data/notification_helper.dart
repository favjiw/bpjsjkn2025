import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin _plugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings = InitializationSettings(
      android: android,
    );

    await _plugin.initialize(initSettings);
  }

  static Future<void> showRegistrationNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'bpjs_channel_id',
      'BPJS Notifications',
      channelDescription: 'Notifikasi JKN AI Agent',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notifDetails = NotificationDetails(
      android: androidDetails,
    );

    await _plugin.show(
      1,
      'Pendaftaran Layanan',
      'Andi mendaftarkan anda untuk KLINIK HARAPAN SEHAT POLI UMUM Besok (21-11-2025) dr. Rudi – 08.00–10.00',
      notifDetails,
    );
  }
}
