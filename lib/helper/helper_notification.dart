import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gampah_app/ui/pages/page_transaction.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class NotificationHelper {
  static NotificationHelper? _instance;
  NotificationHelper._internal() {
    _instance = this;
  }
  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('logo_gampah_2');

    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var _channelId = '1';
    var _channelName = 'gampah_01';
    var _channeldescription = "notification newest order of driver";
    var androidPlatformSpecifics = AndroidNotificationDetails(
        _channelId, _channelName,
        channelDescription: _channeldescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: DefaultStyleInformation(true, true));
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformSpecifics, iOS: iOSPlatformChannelSpecifics);
    var titleNotification = "<b>Hai Ada Sampah Baru Nih!";
    var titleOrder = "Ayo jemput sampahnya, dan raup hadiah dari Gampah!";

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleOrder, platformChannelSpecifics);
  }

  void configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) {
      navigatorKey.currentState!.pushNamed(TransactionPage.routeName);
    });
  }
}
