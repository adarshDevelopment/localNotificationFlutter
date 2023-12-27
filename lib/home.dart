import 'package:flutter/material.dart';
import 'package:flutter_local_notification_practise/local_notifications.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            )
          ],
        ),
      ),
    );
  }
}
