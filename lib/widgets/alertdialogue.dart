import 'package:flutter/material.dart';

class AlertdialogueeWidget extends StatefulWidget {
  AlertdialogueeWidget({Key key}) : super(key: key);

  @override
  _AlertdialogueeWidgetState createState() => _AlertdialogueeWidgetState();
}

class _AlertdialogueeWidgetState extends State<AlertdialogueeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Color(0xFF020203),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Icon(
              Icons.info,
              color: Colors.white,
              size: 24,
            ),
          ),
          Text(
            'Saved Successfully',
            style: TextStyle(
              fontFamily: 'Ubuntu',
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
