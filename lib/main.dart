import 'dart:developer';

import 'package:hadith_notification/module/home/home.v.dart';
import 'package:flutter/material.dart';
import 'package:hadith_notification/services/app.starting.service.dart';
import 'package:hadith_notification/services/notification.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      log("Background task: $task");
      final hadith = await fetchHadith();
      log("Hadith: $hadith");
      await showNotification(hadith);
      return Future.value(true);
    } catch (e) {
      log("Workmanager Failed: $e");
      return Future.value(false);
    }
    // return fetchHadith().then((hadith) async {
    //   log("Native called background task: $task");
    //   log("Hadith: $hadith");
    //   await showNotification(hadith);
    //   return Future.value(true);
    // });
  });
}

void main() async {
  await appStaringServices();
  runApp(const MainApp());
}
