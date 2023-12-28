import 'package:flutter/material.dart';
import 'package:flutter_local_notification_practise/another_page.dart';
import 'package:flutter_local_notification_practise/local_notifications.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    listenToNotification();
    super.initState();
  }

  // to listen to any notifictaion cliccked or not

  listenToNotification() {
    print('Listening to nofiticaion');
    LocalNotifications.onClickNotification.stream.listen((event) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnotherPage(payload: event),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Local Notifications'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                LocalNotifications.showSimpleNotification(
                    title: 'Simple Notification title',
                    body: 'Notification body',
                    payload: "This is simple payload");
              },
              icon: const Icon(Icons.notifications_outlined),
              label: const Text('Simple Notification'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                LocalNotifications.showPerodicNotifications(
                    title: 'Perodic Notification title',
                    body: 'Perodic Notification body',
                    payload: "This is Perodic payload");
              },
              icon: const Icon(Icons.timer_outlined),
              label: const Text('Perodic Notification'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                LocalNotifications.showScheduleNotification(
                    title: 'Schedule Notification title',
                    body: 'Schedule Notification body',
                    payload: "This is Schedule payload");
              },
              icon: const Icon(Icons.schedule),
              label: const Text('Schedule Notification'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                LocalNotifications.cancel(2);
              },
              icon: const Icon(Icons.close),
              label: const Text('Close Periodic Notifications'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                LocalNotifications.cancelAll();
              },
              icon: const Icon(Icons.cancel),
              label: const Text('Cancel all notifications'),
            ),
          ],
        ),
      ),
    );
  }
}
