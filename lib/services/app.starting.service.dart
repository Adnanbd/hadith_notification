import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import 'package:hadith_notification/main.dart';

Future<void> appStaringServices() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  Duration calculateInitialDelay() {
    final now = DateTime.now();
    final desiredTime = DateTime(now.year, now.month, now.day, 22, 45); // Example: 10 AM
    return desiredTime.difference(now);
  }

  Workmanager().registerPeriodicTask(
    "periodic-task-identifier",
    "simplePeriodicTask",
    // When no frequency is provided the default 15 minutes is set.
    // Minimum frequency is 15 min. Android will automatically change your frequency to 15 min if you have configured a lower frequency.
    frequency: const Duration(days: 1),
    initialDelay: calculateInitialDelay(),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );

  await AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/guest_book_icon',
      [
        NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel_1',
          channelName: 'Daily Hadith Channel',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color.fromARGB(255, 7, 244, 145),
          ledColor: Colors.white,
          playSound: true,
          importance: NotificationImportance.High,
          enableVibration: true,
          enableLights: true,
          channelShowBadge: true,
        )
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(channelGroupKey: 'basic_channel_group', channelGroupName: 'Daily Hadith Group')
      ],
      debug: true);
}
