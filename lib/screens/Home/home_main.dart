import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:water_del/screens/home/profilePage.dart';
import 'package:water_del/services/location_file.dart';
import 'package:water_del/utilities/global/pageTransitions.dart';
import 'package:water_del/utilities/styles.dart';
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

  Widget popupTime() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12)),
      child: PopupMenuButton(
        tooltip: 'Time',
        itemBuilder: (context) {
          var list = List<PopupMenuEntry<Object>>();
          list.add(PopupMenuItem(
            child: Text('Delivery Time'),
            value: 1,
          ));
          list.add(
            PopupMenuDivider(
              height: 10,
            ),
          );
          list.add(
            CheckedPopupMenuItem(
              child: Text(
                "Now",
                style: normalOutlineBlack,
              ),
              value: 2,
              checked: true,
            ),
          );
          return list;
        },
        offset: Offset(0, 100),
        icon: Icon(CupertinoIcons.clock_solid),
      ),
    );
  }

  Widget popupPlace() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12)),
      child: PopupMenuButton(
        tooltip: 'Place',
        itemBuilder: (context) {
          var list = List<PopupMenuEntry<Object>>();
          list.add(PopupMenuItem(
            child: Text('Delivery Location'),
            value: 1,
          ));
          list.add(
            PopupMenuDivider(
              height: 10,
            ),
          );
          list.add(
            CheckedPopupMenuItem(
              child: Text(
                "Home",
                style: normalOutlineBlack,
              ),
              value: 2,
              checked: true,
            ),
          );
          return list;
        },
        offset: Offset(0, 100),
        icon: Icon(CupertinoIcons.location_solid),
      ),
    );
  }

  Widget _appBarItems() {
    return Positioned(
        top: 40,
        left: 10,
        child: Row(
          children: <Widget>[
            popupTime(),
            SizedBox(
              width: 5,
            ),
            popupPlace()
          ],
        ));
  }

  Widget _profilePage() {
    return Positioned(
      top: 40,
      right: 10,
      child: GestureDetector(
        onTap: () =>
            Navigator.of(context).push(SlideLeftTransition(page: ProfilePage())),
        child: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.5), shape: BoxShape.circle),
          padding: EdgeInsets.all(8),
          child: FlutterLogo(),
        ),
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
            _appBarItems(),
            _profilePage(),
          ],
        ),
      ),
    );
  }
}
