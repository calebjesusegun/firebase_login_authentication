import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_login_authentication/core/navigation/navigation.dart';
import 'package:firebase_login_authentication/core/navigation/observer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'core/app/app_locator.dart';
import 'core/app/providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupLocator();

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
