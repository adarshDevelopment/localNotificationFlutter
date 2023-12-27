import 'package:flutter/material.dart';
import 'package:flutter_local_notification_practise/home.dart';
import 'package:flutter_local_notification_practise/local_notifications.dart';

void main() async{
  WidgetsFlutterBinding
      .ensureInitialized(); // calls native code before executing whatever it sees. chanes in android buil.gradel files and all
  // await LocalNotifications.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
