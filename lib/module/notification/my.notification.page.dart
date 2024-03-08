import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hadith_notification/models/single.hadith.details.dart';
import 'package:hadith_notification/module/all.hadith/all.hadith.v.dart';

class MyNotificationPage extends StatefulWidget {
  const MyNotificationPage({super.key, required this.receivedAction});

  final ReceivedAction receivedAction;

  @override
  State<MyNotificationPage> createState() => _MyNotificationPageState();
}

class _MyNotificationPageState extends State<MyNotificationPage> {
  @override
  void initState() {
    super.initState();
    AwesomeNotifications()
        .getGlobalBadgeCounter()
        .then((value) => AwesomeNotifications().setGlobalBadgeCounter(value - 1));
    // final data = widget.receivedAction.payload ?? {};
    // if (data.isNotEmpty) {
    //   final hadith = SingleHadithDetailModel.fromJsonNotification(widget.receivedAction.payload ?? {});
      
    //   SharedPreferencesService().addSingleHadith(hadith);
    // }
  }

  @override
  Widget build(BuildContext context) {
    final hadith = SingleHadithDetailModel.fromJsonNotification(widget.receivedAction.payload ?? {});
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Page'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AllHadithView()));
              },
              icon: const Icon(Icons.list)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              hadith.bn ?? 'No Data',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
