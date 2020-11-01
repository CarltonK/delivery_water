import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_del/screens/Authentication/main_authentication.dart';
import 'package:water_del/screens/Home/home_main.dart';
import 'package:water_del/widgets/global/custome_info_dialog.dart';
import 'package:water_del/widgets/global/loading_page.dart';
import 'provider/auth_provider.dart';
import 'provider/database_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
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
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (_, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.done:
              FirebaseCrashlytics.instance
                  .setCrashlyticsCollectionEnabled(true);
              FlutterError.onError =
                  FirebaseCrashlytics.instance.recordFlutterError;
              return Consumer(builder: (context, AuthProvider value, child) {
                if (value.status == Status.Authenticated) return HomeMain();
                return MainAuthentication();
              });
            case ConnectionState.waiting:
              return LoadingPage();
            case ConnectionState.none:
              return InfoDialog(message: 'Firebase is not initialized');
            default:
              return Container();
          }
        },
      ),
    );
  }
}
