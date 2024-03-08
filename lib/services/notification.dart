import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:hadith_notification/models/single.hadith.details.dart';

Future<void> showNotification(SingleHadithDetailModel? hadith) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel_1',
        actionType: ActionType.Default,
        title: '${Emojis.flower_blossom} আজকের হাদিস ${Emojis.flower_blossom}',
        body: hadith?.bn ?? 'DUMMY TEXXTYTTTTT',
        category: NotificationCategory.Reminder,
        wakeUpScreen: true,
        bigPicture: 'asset://assets/notification-big-img.jpg',
        notificationLayout: NotificationLayout.BigPicture,
        payload: hadith?.toJsonNotification() ?? {},
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'READ',
          label: 'পুরোটা পড়ুন',
          actionType: ActionType.Default,
        ),
      ]);
}
