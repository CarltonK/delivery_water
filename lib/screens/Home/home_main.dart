import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:water_del/services/location_file.dart';
import 'package:water_del/widgets/mapWidget.dart';

class HomeMain extends StatefulWidget {
  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  Future coord;
  Locate _locate = new Locate();

  @override
  void initState() {
    super.initState();
    coord = _locate.getCoordinates();
  }

  Widget _pageView(Size size) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: FutureBuilder<Map<String, dynamic>>(
        future: coord,
        builder: (context, snapshot) {
          print(snapshot.data);
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.none:
              return Text('None');
            case ConnectionState.waiting:
              return SpinKitWave(
                color: Colors.blue[800].withOpacity(0.6),
                size: size.height * 0.25,
                type: SpinKitWaveType.center,
              );
            case ConnectionState.done:
              return MapWidget(coordinates: snapshot.data);
            default:
              return SpinKitWave(
                color: Colors.blue[800].withOpacity(0.6),
                size: size.height * 0.25,
                type: SpinKitWaveType.center,
              );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: <Widget>[
            _pageView(size),
            Positioned(
                top: 40,
                left: 10,
                child: Row(
                  children: <Widget>[
                    FlatButton(
                        onPressed: () {
                          print('I want to change the delivery time');
                        },
                        color: Colors.blue.withOpacity(0.2),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text('Now'),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.keyboard_arrow_down)
                          ],
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    FlatButton(
                        onPressed: () =>
                            print('I want to change the delivery location'),
                        color: Colors.blue.withOpacity(0.2),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text('Home'),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.keyboard_arrow_down)
                          ],
                        ))
                  ],
                )),
            Positioned(
              top: 40,
              right: 10,
              child: Container(
                height: 36,
                width: 36,
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
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
