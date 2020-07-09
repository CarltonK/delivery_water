import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:water_del/models/locationModel.dart';
import 'package:water_del/provider/auth_provider.dart';
import 'package:water_del/provider/loc_provider.dart';
import 'package:water_del/screens/home/profilePage.dart';
import 'package:water_del/services/location_file.dart';
import 'package:water_del/utilities/global/pageTransitions.dart';
import 'package:water_del/utilities/styles.dart';
import 'package:water_del/models/productModel.dart';
import 'package:water_del/widgets/mapWidget.dart';

class HomeMain extends StatefulWidget {
  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  PageController _controller;

  // Widget _pageView(Size size) {
  //   return Container(
  //     height: size.height,
  //     width: size.width,
  //     child: FutureBuilder<Map<String, dynamic>>(
  //       future: coord,
  //       builder: (context, snapshot) {
  //         // print(snapshot.data);
  //         switch (snapshot.connectionState) {
  //           case ConnectionState.active:
  //           case ConnectionState.none:
  //             return Text('None');
  //           case ConnectionState.waiting:
  //             return SpinKitWave(
  //               color: Colors.blue[800].withOpacity(0.6),
  //               size: size.height * 0.25,
  //               type: SpinKitWaveType.center,
  //             );
  //           case ConnectionState.done:
  //             return MapWidget(coordinates: snapshot.data);
  //           default:
  //             return SpinKitWave(
  //               color: Colors.blue[800].withOpacity(0.6),
  //               size: size.height * 0.25,
  //               type: SpinKitWaveType.center,
  //             );
  //         }
  //       },
  //     ),
  //   );
  // }

  Widget popupPlace() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.4),
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
          children: <Widget>[popupPlace()],
        ));
  }

  Widget _profilePage() {
    return Positioned(
      top: 40,
      right: 10,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(SlideLeftTransition(page: ProfilePage()));
        },
        child: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.4), shape: BoxShape.circle),
          child: Center(
            child: Icon(
              CupertinoIcons.person_solid,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }

  Widget _singleItem(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          listMainItems[index].selected = !listMainItems[index].selected;
        });
        showCupertinoModalPopup(
          context: context,
          builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            content: Text(
                'When you click an item, the map updates to show the suppliers and the bottom list showcases prices'),
          ),
        );
      },
      child: Card(
        elevation: 8,
        shadowColor: Colors.grey[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: listMainItems[index].selected
                  ? Colors.grey[50]
                  : Colors.pink[200]),
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Image.asset(
                listMainItems[index].imgUrl,
                height: 105,
                fit: BoxFit.contain,
              ),
              Text(
                listMainItems[index].title,
                style: normalOutlineBlack,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomSelection() {
    return Positioned(
      bottom: 5,
      left: 5,
      right: 5,
      child: Container(
        height: 140,
        child: PageView.builder(
          controller: _controller,
          itemCount: listMainItems.length,
          itemBuilder: (context, index) => _singleItem(index),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0, viewportFraction: 0.5);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var userLocation = Provider.of<LocationModel>(context);
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Container(
            height: size.height,
            width: size.width,
            child: Stack(
              children: <Widget>[
                MapWidget(),
                _appBarItems(),
                _profilePage(),
                _bottomSelection()
              ],
            ),
          ),
        ),
      );
  }
}
