import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hadith_notification/module/home/home.v.dart';

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    // Your code goes here
    debugPrint('Notification Opened');
    // Navigate into pages, avoiding to open the notification details page over another details page already opened
    // MainApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
    //     '/notification-page', (route) => (route.settings.name != '/notification-page') || route.isFirst,
    //     arguments: receivedAction);

    //MainApp.navigatorKey.currentState?.push(MyNotificationPage)
  }
}

Future<bool> displayNotificationRationale() async {
  bool userAuthorized = false;
  BuildContext context = MainApp.navigatorKey.currentContext!;
  await showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text('এলাউ করুন!', style: Theme.of(context).textTheme.titleLarge),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('প্রতিদিন হাদিসের আপডেট পেতে এলাউ করুন'),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text(
                  'না',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.red),
                )),
            TextButton(
                onPressed: () async {
                  userAuthorized = true;
                  Navigator.of(ctx).pop();
                },
                child: Text(
                  'হ্যাঁ',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.deepPurple),
                )),
          ],
        );
      });
  return userAuthorized && await AwesomeNotifications().requestPermissionToSendNotifications();
}

Future<bool?> permissionForNotification() async {
  bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowed) isAllowed = await displayNotificationRationale();
  if (!isAllowed) return null;
  return isAllowed;
}
