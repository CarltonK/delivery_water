import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:water_del/screens/authentication/main_authentication.dart';

void main() {
  runApp(MyApp());
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
        home: MainAuthentication());
  }
}
