import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_del/models/merchantModel2.dart';
import 'package:water_del/models/models.dart';
import 'package:water_del/provider/MerchantProvider.dart';
import 'package:water_del/screens/Authentication/main_authentication.dart';
import 'package:water_del/screens/Home/home_main.dart';
import 'package:water_del/screens/screens.dart';
import 'package:water_del/widgets/widgets.dart';
import 'provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider.instance(),
        ),
        Provider(
          create: (context) => DatabaseProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderModel(
            grandtotal: 0,
            status: false,
            products: [],
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => MerchantNotifier()
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseAnalytics analytics = FirebaseAnalytics();


  final futureApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      title: 'Maji Mtaani',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.pink[200],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: 
      FutureBuilder(
        future: futureApp,
        builder: (_, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasData) {
                FirebaseCrashlytics.instance
                    .setCrashlyticsCollectionEnabled(true);
                FlutterError.onError =
                    FirebaseCrashlytics.instance.recordFlutterError;
                return Consumer(builder: (context, AuthProvider value, child) {
                  if (value.status == Status.Authenticated) return HomeMain();
                  return MainAuthentication();
                });
              }
              return LoadingPage();
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
