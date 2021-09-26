import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class Recent extends StatefulWidget {
  const Recent({ Key  key }) : super(key: key);

  @override
  _RecentState createState() => _RecentState();
}

class _RecentState extends State<Recent> {
  @override
  Widget build(BuildContext context) {
    return Container(
    height: 100,
    width:  MediaQuery.of(context).size.width ,
      child: LottieBuilder.asset(
      "assets/lottie/no_records.json"
      ),
    );
  }
}