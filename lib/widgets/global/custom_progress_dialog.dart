import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomProgressDialog extends StatelessWidget {
  final String message;

  CustomProgressDialog({@required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            message,
            style: GoogleFonts.muli(
                textStyle: TextStyle(color: Colors.black, fontSize: 16)),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          SpinKitDualRing(
            color: Colors.greenAccent[700],
            size: 100,
          )
        ],
      ),
    );
  }
}
