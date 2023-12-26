import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import 'package:reka/pages/audioplayer/audioplayer.dart';
import 'package:reka/services/service_locator.dart';

import 'package:permission_handler/permission_handler.dart';

//import firebase
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:reka/pages/settingspage/Pachtnotes/pachtnotespage.dart';
import 'package:reka/pages/settingspage/settingspage.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

//import Pages
import 'package:package_info_plus/package_info_plus.dart';
import 'package:reka/pages/home/home_page.dart';

import 'package:discord_rpc/discord_rpc.dart';
import 'news/model/news_model.dart';
import 'pages/settingspage/Pachtnotes/model/pacht_model.dart';
import 'package:go_router/go_router.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  requestLocationPermission();
  NewsData.updateDataPeriodically();
  PachtData.updateDataPeriodically();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (Platform.isWindows) {
    DiscordRPC.initialize();
    DiscordRPC rpc = DiscordRPC(
      applicationId: '1143900767569330308',
    );

    rpc.start(autoRegister: true);
    rpc.updatePresence(
      DiscordPresence(
        state: 'Discord Rich Presence from Dart. 🎯',
        details: 'github.com/alexmercerind/discord_rpc',
        startTimeStamp: DateTime.now().millisecondsSinceEpoch,
        largeImageKey: 'large_image',
        largeImageText: 'This text describes the large image.',
        smallImageKey: 'small_image',
        smallImageText: 'This text describes the small image.',
      ),
    );
  }

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  FirebaseAuth.instance.signInAnonymously();
  final notificationSettings =
      await FirebaseMessaging.instance.requestPermission(provisional: true);
  final fcmToken = await FirebaseMessaging.instance.getToken(
      vapidKey:
          "BB3brG1iqS7E2NZw5ItpWyAgeA-SC756OLi6RgEReq-xilrdjeV0D3HvRrLdx1D7D9Shkcs_6zTOsfXPVEPB0JM");
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: true,
    criticalAlert: true,
    provisional: true,
    sound: true,
  );
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.logAppOpen();

  runApp(Start());
}

final GoRouter _router = GoRouter(routes: <RouteBase>[
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return HomeScren();
      }),
  GoRoute(
      path: '/settings',
      builder: (BuildContext context, GoRouterState state) {
        return const SettingsPage();
      }),
  GoRoute(
      path: '/audioguid',
      builder: (BuildContext context, GoRouterState state) {
        return const MyApp();
      }),
  GoRoute(
      path: '/pachtnotes',
      builder: (BuildContext context, GoRouterState state) {
        return const Pachtnotes();
      }),
]);

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

Future<void> requestLocationPermission() async {
  if (await Permission.contacts.request().isGranted) {
    // Either the permission was already granted before or the user just granted it.
  }
  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
    Permission.locationAlways,
  ].request();
}
