import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:water_del/utilities/utilities.dart';

class InfoDialog extends StatelessWidget {
  final String message;
  InfoDialog({@required this.message});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            CupertinoIcons.info,
            size: 100,
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            message,
            style: subheaderOutlineBlack,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
