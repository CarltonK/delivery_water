import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:water_del/models/models.dart';
import 'package:water_del/provider/provider.dart';
import 'package:water_del/screens/Home/landing.dart';
import 'package:water_del/screens/screens.dart';
import 'package:water_del/utilities/utilities.dart';
import 'package:water_del/widgets/widgets.dart';
import 'package:water_del/widgets/cartbottomsheet.dart';

import '../merchant_screen.dart';

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

  Widget clientPage() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          'Hi Clinton',
          style: TextStyle(
              fontFamily: 'Ubuntu', fontSize: 17, color: Colors.black),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: InkWell(
              onTap: () async {
                await showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return // showModalBottomSheet(context: , builder: null)
                          NewerrWidget();
                    });
              },
              child: Icon(
                Icons.card_travel_rounded,
                color: Colors.black,
                size: 24,
              ),
            ),
          )
        ],
        centerTitle: true,
        elevation: 0,
      ),

      //Drawer
      drawer: Drawer(
        elevation: 16,
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0x023474E0),
                  ),
                  child: Container(
                    width: 120,
                    height: 120,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      'https://picsum.photos/seed/246/600',
                    ),
                  ),
                ),
              ),
              Text(
                'Abraham',
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Align(
                  alignment: Alignment(0, -0.15),
                  child: Container(
                    width: 350,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Color(0xFF4D4D4D),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text('Profile',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Align(
                  alignment: Alignment(0, -0.15),
                  child: Container(
                      width: 350,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Color(0xFF4D4D4D),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          // Icon(icon:Icons.)
                        ],
                      )),
                ),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: 800,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.topToBottom,
                            duration: Duration(milliseconds: 300),
                            reverseDuration: Duration(milliseconds: 300),
                            child: LandingWidget(),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                                width: 350,
                                height: 250,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                  shape: BoxShape.rectangle,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    'https://firebasestorage.googleapis.com/v0/b/wallpaper-f46f1.appspot.com/o/maps.jpg?alt=media&token=473e1061-1968-4035-a9f6-f82d49de7695' ??
                                        CircularProgressIndicator(),
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(150, 200, 0, 0),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 40,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    'Explore',
                                    style: TextStyle(
                                        fontFamily: 'Ubuntu',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment(-0.85, 0),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Text(
                          'Recent',
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Container(
                        width: 350,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Color(0xFFD3D3D3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  SlideLeftTransition(
                                    page: MerchantProfileWidget(),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment(0.05, -0.55),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 0, 0),
                                        child: Text(
                                          'Water Tanker',
                                          style: TextStyle(
                                            fontFamily: 'Ubuntu',
                                            fontSize: 25,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment(0, 0),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 0, 0),
                                        child: Text(
                                          '28th July',
                                          style: TextStyle(
                                            fontFamily: 'Ubuntu',
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment(1, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Color(0x9CF8F7F7),
                                  borderRadius: BorderRadius.circular(10),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(1),
                                    child: Image.network(
                                      'https://images.unsplash.com/photo-1596792598780-6777ec5b57ee?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Container(
                        width: 350,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Color(0xFFD3D3D3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment(0.05, -0.55),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: Text(
                                        'Bottled Water',
                                        style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 25,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment(0, 0),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: Text(
                                        '14th July',
                                        style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment(1, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Color(0x9CF8F7F7),
                                  borderRadius: BorderRadius.circular(10),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(1),
                                    child: Image.network(
                                      'https://images.unsplash.com/photo-1595994195534-d5219f02f99f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Container(
                        width: 350,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Color(0xFFD3D3D3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment(0.05, -0.55),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: Text(
                                        'Exhauster',
                                        style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 25,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment(0, 0),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: Text(
                                        '1st June',
                                        style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment(1, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Color(0x9CF8F7F7),
                                  borderRadius: BorderRadius.circular(10),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(1),
                                    child: Image.network(
                                      'https://images.unsplash.com/photo-1501700493788-fa1a4fc9fe62?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=681&q=80',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
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

  // Widget clientPage() {
  //   return Stack(
  //     children: [
  //       display.length == 0 ? baseMap() : productMap(),
  //       CartIcon(
  //         location: myLocation,
  //       ),
  //       _profilePage(),
  //       _bottomSelection()
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Provider.of<OrderModel>(context).client = userCurrent.uid;
    return clientPage();

    // Scaffold(
    //   body: AnnotatedRegion<SystemUiOverlayStyle>(
    //     value: SystemUiOverlayStyle.light,
    //     child: StreamBuilder<UserModel>(
    //       stream: _databaseProvider.streamUser(userCurrent.uid),
    //       builder: (context, snapshot) {
    //         if (snapshot.hasData) {
    //           return SingleChildScrollView(
    //             child: Column(
    //               children: [
    //                 if (snapshot.data.clientStatus) ...[
    //                   Container(
    //                     height: size.height,
    //                     width: size.width,
    //                     child: clientPage(),
    //                   )
    //                 ],
    //                 if (!snapshot.data.clientStatus) ...[
    //                   Container(
    //                     height: size.height,
    //                     width: size.width,
    //                     child: SupplierHome(
    //                       user: userCurrent,
    //                     ),
    //                   )
    //                 ]
    //               ],
    //             ),
    //           );
    //         }
    //         return Center(
    //           child: SpinKitFoldingCube(
    //             size: 150,
    //             color: Theme.of(context).primaryColor,
    //           ),
    //         );
    //       },
    //     ),
    //   ),
    // );
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
