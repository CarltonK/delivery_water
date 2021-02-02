import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:water_del/models/models.dart';
import 'package:water_del/provider/provider.dart';
import 'package:water_del/screens/screens.dart';
import 'package:water_del/utilities/utilities.dart';
import 'package:water_del/widgets/widgets.dart';

class HomeMain extends StatefulWidget {
  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  PageController _controller;
  var userCurrent;
  UserModel userModel;
  DatabaseProvider _databaseProvider = DatabaseProvider();
  List<String> display = [];
  LocationModel myLocation;
  Future productFuture;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  // Widget popupPlace() {
  //   return Container(
  //     decoration: BoxDecoration(
  //         color: Colors.blue.withOpacity(0.4),
  //         borderRadius: BorderRadius.circular(12)),
  //     child: PopupMenuButton(
  //       tooltip: 'Place',
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //       itemBuilder: (context) {
  //         var list = List<PopupMenuEntry<Object>>();
  //         list.add(
  //           PopupMenuItem(
  //             child: Text('Delivery Location'),
  //             value: 1,
  //           ),
  //         );
  //         list.add(
  //           PopupMenuDivider(
  //             height: 5,
  //           ),
  //         );
  //         list.add(
  //           CheckedPopupMenuItem(
  //             child: Text(
  //               "Home",
  //               style: normalOutlineBlack,
  //             ),
  //             value: 2,
  //             checked: true,
  //           ),
  //         );
  //         return list;
  //       },
  //       offset: Offset(0, 100),
  //       icon: Icon(CupertinoIcons.location_solid),
  //     ),
  //   );
  // }

  Widget _profilePage() {
    return Positioned(
      top: 40,
      right: 10,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(SlideLeftTransition(
              page: ProfilePage(
            user: userCurrent,
          )));
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
          !listMainItems[index].selected
              ? display.add(listMainItems[index].category)
              : display.remove(listMainItems[index].category);
          productFuture = _databaseProvider.populateMap(display);
        });
      },
      child: Card(
        elevation: 8,
        shadowColor: Colors.grey[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
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
        height: 150,
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
    userCurrent = context.read<AuthProvider>().currentUser;
    _controller = PageController(initialPage: 0, viewportFraction: 0.5);
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('Message -> $message');
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget baseMap() {
    return StreamBuilder<LocationModel>(
      stream: LocationProvider().locationStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Provider.of<OrderModel>(context).location = snapshot.data;
          List<LocationModel> locations = [];
          locations.insert(0, snapshot.data);
          myLocation = snapshot.data;
          return MapWidget(
            coordinates: locations,
            user: userCurrent,
          );
        }
        return Center(
          child: SpinKitFoldingCube(
            size: 150,
            color: Theme.of(context).primaryColor,
          ),
        );
      },
    );
  }

  Widget productMap() {
    return FutureBuilder<List<Product>>(
      future: productFuture,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasData && snapshot.data.length > 0) {
              return ProductMapWidget(
                products: snapshot.data,
                user: userCurrent,
                location: myLocation,
              );
            }
            return Center(
              child: Text(
                'There are no products',
                style: normalOutlineBlack,
              ),
            );
          case ConnectionState.active:
          case ConnectionState.none:
            return Center(
              child: Text(
                'There are no products',
                style: normalOutlineBlack,
              ),
            );
          case ConnectionState.waiting:
            return Center(
              child: SpinKitFoldingCube(
                size: 150,
                color: Theme.of(context).primaryColor,
              ),
            );
        }
        return Center(
          child: SpinKitFoldingCube(
            size: 150,
            color: Theme.of(context).primaryColor,
          ),
        );
      },
    );
  }

  Widget clientPage() {
    return Stack(
      children: [
        display.length == 0 ? baseMap() : productMap(),
        CartIcon(
          location: myLocation,
        ),
        _profilePage(),
        _bottomSelection()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Provider.of<OrderModel>(context).client = userCurrent.uid;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: StreamBuilder<UserModel>(
          stream: _databaseProvider.streamUser(userCurrent.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    if (snapshot.data.clientStatus) ...[
                      Container(
                        height: size.height,
                        width: size.width,
                        child: clientPage(),
                      )
                    ],
                    if (!snapshot.data.clientStatus) ...[
                      Container(
                        height: size.height,
                        width: size.width,
                        child: SupplierHome(
                          user: userCurrent,
                        ),
                      )
                    ]
                  ],
                ),
              );
            }
            return Center(
              child: SpinKitFoldingCube(
                size: 150,
                color: Theme.of(context).primaryColor,
              ),
            );
          },
        ),
      ),
    );
  }
}

class CartIcon extends StatelessWidget {
  static OrderModel model;
  final LocationModel location;
  CartIcon({@required this.location});
  @override
  Widget build(BuildContext context) {
    model = context.watch<OrderModel>();
    model.location = location;
    int items = model.products.length;
    return Positioned(
      top: 40,
      left: 10,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            SlideLeftTransition(
              page: CartScreen(),
            ),
          );
        },
        child: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.4),
            shape: BoxShape.circle,
          ),
          child: Stack(
            clipBehavior: Clip.antiAlias,
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: 5,
                child: Icon(Icons.shopping_cart),
              ),
              Positioned(
                top: 8,
                child: Text(
                  items.toString() ?? '0',
                  style: boldOutlineWhite,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
