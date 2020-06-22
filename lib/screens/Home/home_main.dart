import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeMain extends StatefulWidget {
  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              height: size.height,
              width: size.width,
              color: Colors.red,
            ),
            Positioned(
              top: 40,
              left: 10,
              child: Row(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      print('I want to change the delivery time');
                    }, 
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Now'),
                        SizedBox(width: 5,),
                        Icon(Icons.keyboard_arrow_down)
                      ],
                    )
                  ),
                  SizedBox(width: 5,),
                  FlatButton(
                    onPressed: () => print('I want to change the delivery location'), 
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Home'),
                        SizedBox(width: 5,),
                        Icon(Icons.keyboard_arrow_down)
                      ],
                    )
                  )
                ],
              )
            ),
            Positioned(
              top: 40,
              right: 10,
              child: Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle
                ),
                padding: EdgeInsets.all(8),
                child: FlutterLogo(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}