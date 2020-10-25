import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget spinner() {
      return SpinKitFoldingCube(
        color: Theme.of(context).primaryColor,
        size: 150,
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          spinner(),
        ],
      ),
    );
  }
}
