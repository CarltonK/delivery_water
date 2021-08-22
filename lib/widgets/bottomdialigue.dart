import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomdialogueWidget extends StatefulWidget {
  BottomdialogueWidget({Key key}) : super(key: key);

  @override
  _BottomdialogueWidgetState createState() => _BottomdialogueWidgetState();
}

class _BottomdialogueWidgetState extends State<BottomdialogueWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            Align(
              alignment: Alignment(0, 0),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
                child: Container(
                  width: 120,
                  height: 120,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1570840934347-4dc56c98b8ef?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80',
                  ),
                ),
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment(0, 0),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Container(
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                color: Color(0xFFC9C9C9),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment(0, 0),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Container(
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                color: Color(0xFFC9C9C9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text('Name: James Suppliers'),
              ),
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Align(
                  alignment: Alignment(0, -0.05),
                  child: Text(
                    'Ksh 2500',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      color: Color(0xFFE6E6E6),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Align(
                  alignment: Alignment(0, -0.1),
                  child: Text(
                    'Order',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xFFFBFBFB),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
