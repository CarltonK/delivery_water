import 'package:flutter/material.dart';
import 'package:water_del/screens/checkout/cart.dart';
import 'package:water_del/screens/home/home_main.dart';
import 'package:water_del/screens/home/supplier.dart';
import 'package:water_del/screens/authentication/main_authentication.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Naqua',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CartScreen(),
    );
  }
}
