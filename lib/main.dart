import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_del/provider/auth_provider.dart';
import 'package:water_del/provider/database_provider.dart';
import 'package:water_del/screens/authentication/main_authentication.dart';
import 'package:water_del/screens/home/home_main.dart';

void main() {
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => AuthProvider.instance(),
        ),
        Provider(
          create: (context) => DatabaseProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final FirebaseAnalytics analytics = FirebaseAnalytics();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      title: 'Naqua',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.pink[200],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider(
        create: (context) => AuthProvider.instance(),
        child: Consumer(builder: (context, AuthProvider value, child) {
          if (value.status == Status.Authenticated) {
            return HomeMain();
          } else {
            return MainAuthentication();
          }
        }),
      ),
    );
  }
}
