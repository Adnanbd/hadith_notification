import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hadith_notification/controller/notification.controller.dart';
import 'package:hadith_notification/models/single.hadith.details.dart';
import 'package:hadith_notification/module/all.hadith/all.hadith.v.dart';
import 'package:hadith_notification/module/notification/my.notification.page.dart';
import 'package:hadith_notification/services/generate.number.dart';
import 'package:hadith_notification/services/hadith.service.dart';
import 'package:hadith_notification/services/shared.pref.service.dart';
import 'package:hadith_notification/utils/constants.dart';

class MainApp extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static const String name = 'Hadith Notification';
  static const Color mainColor = Colors.deepPurple;

  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  @override
  void initState() {
    permissionForNotification();
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod: NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod: NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod: NotificationController.onDismissActionReceivedMethod);

    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        // The navigator key is necessary to allow to navigate through static methods
        navigatorKey: MainApp.navigatorKey,

        title: MainApp.name,
        color: MainApp.mainColor,

        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (context) => const AllHadithView());

            case '/notification-page':
              return MaterialPageRoute(builder: (context) {
                final ReceivedAction receivedAction = settings.arguments as ReceivedAction;
                return MyNotificationPage(receivedAction: receivedAction);
              });

            default:
              assert(false, 'Page ${settings.name} not found');
              return null;
          }
        },

        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          fontFamily: GoogleFonts.hindSiliguri().fontFamily,
        ),
      ),
    );
  }
}

class HadithHome extends StatelessWidget {
  const HadithHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Workmanager Demo')),
        body: Center(
          child: FutureBuilder<SingleHadithDetailModel?>(
            future: fetchHadith(),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            AwesomeNotifications().createNotification(
                content: NotificationContent(
              id: 10,
              channelKey: 'basic_channel_1',
              actionType: ActionType.Default,
              title: 'Hello World!',
              body: 'This is my first notification!',
            ));
          },
          child: const Icon(Icons.notification_add),
        ),
      ),
    );
  }
}

Future<SingleHadithDetailModel?> fetchHadith() async {
  SharedPreferencesService sharedP = SharedPreferencesService();
  final exclude = await sharedP.getIntList(excludeHadithKey) ?? [];
  final hadithNo = GenerateNumber().generateRandomNumber(1, 5000, exclude);
  await sharedP.setIntList(excludeHadithKey, [...exclude, hadithNo]);
  final fetchedHadith = await HadithService().fetchSingleHadith(hadithNo);
  if (fetchedHadith != null) {
    fetchedHadith.timeStamp = DateTime.now();
    SharedPreferencesService().addSingleHadith(fetchedHadith);
  }
  return fetchedHadith;
}
