import 'dart:developer';

// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:hadith_notification/models/single.hadith.details.dart';
import 'package:hadith_notification/services/generate.number.dart';
import 'package:hadith_notification/services/hadith.service.dart';
import 'package:hadith_notification/services/shared.pref.service.dart';
import 'package:hadith_notification/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    return await Future.delayed(const Duration(seconds: 10), () {
      log("Native called background task: $task"); //simpleTask will be emitted here.
      return true;
    });
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager().initialize(callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
  await Workmanager().registerOneOffTask("task-identifier", "simpleTask");
  // await AwesomeNotifications().initialize(
  //     // set the icon to null if you want to use the default app icon
  //     null,
  //     [
  //       NotificationChannel(
  //           channelGroupKey: 'basic_channel_group',
  //           channelKey: 'basic_channel_1',
  //           channelName: 'Basic notifications',
  //           channelDescription: 'Notification channel for basic tests',
  //           defaultColor: const Color(0xFF9D50DD),
  //           ledColor: Colors.white)
  //     ],
  //     // Channel groups are only visual and are not required
  //     channelGroups: [
  //       NotificationChannelGroup(channelGroupKey: 'basic_channel_group', channelGroupName: 'Basic group')
  //     ],
  //     debug: true);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Workmanager Demo')),
        body: Center(
          child: FutureBuilder<SingleHadithDetailModel?>(
            future: showHadith(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  snapshot.data?.bn ?? 'No Hadith',
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

Future<SingleHadithDetailModel?> showHadith() async {
  SharedPreferencesService sharedP = SharedPreferencesService();
  final exclude = await sharedP.getIntList(excludeHadithKey) ?? [];
  final hadithNo = GenerateNumber().generateRandomNumber(1, 5000, exclude);
  await sharedP.setIntList(excludeHadithKey, [...exclude, hadithNo]);
  final fetchedHadith = await HadithService().fetchSingleHadith(hadithNo);
  return fetchedHadith;
}
