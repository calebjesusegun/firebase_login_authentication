import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_login_authentication/core/navigation/navigation.dart';
import 'package:firebase_login_authentication/core/navigation/observer.dart';
import 'package:firebase_login_authentication/core/services/push_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'core/app/app_locator.dart';
import 'core/app/providers.dart';

final _pushMessagingNotification = locator<PushNotificationService>();

Future myBackgroundMessageHandler(RemoteMessage message) async {
  debugPrint("onBackgroundMessage: ${message.notification?.title}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupLocator();

  await FirebaseMessaging.instance.getInitialMessage();

  await _pushMessagingNotification.initialize();

  //Handle Push Notification when app is in background and when app is terminated
  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

  runApp(
    MultiProvider(
      providers: appProviders,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Login Authentication',
      theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(),
      ),
      navigatorKey: AppNavigator.key,
      onGenerateRoute: AppRouter().onGenerateRoute,
      routes: AppRouter().routes,
      navigatorObservers: [NavigationHistoryObserver()],
    );
  }
}
