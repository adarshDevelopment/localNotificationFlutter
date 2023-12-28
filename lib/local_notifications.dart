import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static FlutterLocalNotificationsPlugin get flutterLocalNotificationsPlugin =>
      _flutterLocalNotificationsPlugin;

  static final onClickNotification = BehaviorSubject();

  // on tap on any notification
  static void onNotificationTap(NotificationResponse notificationResponse) {
    print('inside onNotificationTap');
    // print('inside onNotificationTap: id: ${notificationResponse.id}, title: ${notificationResponse.}, body: $body, payLoad: $payload');
    onClickNotification.add(notificationResponse.payload);
  }

  // schedule local notification
  static Future showScheduleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    tz.initializeTimeZones();
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        3,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'channel 3', 'your channel name',
                channelDescription: 'your channel description',
                importance: Importance.max,
                priority: Priority.high,
                ticker: 'ticker')),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload);
  }

  // initialize the local notifications
  static Future init() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project

    //android initialization settings
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings(
            '@mipmap/ic_launcher'); // default icon from ANdroidManifest.xml. android/app/src/main/..

    // ios android initialization settings
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            // onDidReceiveLocalNotification: onNotificationTap,
            // onDidReceiveBackGroundLocalNotification missing!!
            );

    // linux android initialization settings
    LinuxInitializationSettings initializationSettingsLinux =
        const LinuxInitializationSettings(
            defaultActionName: 'Open notification');

    // android initialization settings
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);

    // initialize method from FlutterLocalNotificationsPlugin
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  }

  //show a simple notification
  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('channelId', 'channelName',
            channelDescription: 'Channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: null,
    );

    await _flutterLocalNotificationsPlugin
        .show(1, title, body, notificationDetails, payload: payload);
  }

  // show peroidc notifiation at regular interval
  static Future showPerodicNotifications({
    required String title,
    required String body,
    required String payload,
  }) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'channelId perodic',
      'channelName perodic',
      importance: Importance.max,
      priority: Priority.max,
      ticker: 'ticker',
    );
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.periodicallyShow(
        2, title, body, RepeatInterval.everyMinute, notificationDetails,
        payload: payload);
  }

  // close a specific channel notification
  static Future cancel(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  //close all set notifications
  static Future cancelAll() async {
    print('onClickNotification dataType: ${onClickNotification.runtimeType}');
    print('onClickNotification: $onClickNotification');

    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
