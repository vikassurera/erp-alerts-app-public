import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Screen imports
import 'package:erpalerts/screens/notice_alert.screen.dart';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // handle action
}

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        final data = notificationResponse.payload;

        if (data == null) return;

        if (data.startsWith('notice')) {
          final noticeId = data.split('_')[1];

          // Open a new screen using Get
          Get.to(() => NoticeAlertScreen(noticeId: noticeId));
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  static void createanddisplaynotification(RemoteMessage message) async {
    try {
      String? payload;

      final type = message.data['type'];
      if (type == "Notice") {
        // final noticeId = message.data['noticeId'];
        final id = message.data['id'];
        payload = 'notice_$id';
      }

      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "erpalerts",
          "erpalertschannel",
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        ),
      );

      await _notificationsPlugin.show(
        id,
        message.notification?.title,
        message.notification?.body,
        notificationDetails,
        payload: payload,
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}
