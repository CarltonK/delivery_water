import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:water_del/models/locationModel.dart';
import 'package:water_del/models/orderModel.dart';
import 'package:water_del/models/product.dart';
import 'package:water_del/models/userModel.dart';
import 'package:water_del/provider/database_provider.dart';
import 'package:water_del/provider/loc_provider.dart';
import 'package:water_del/widgets/bottomdialigue.dart';
import 'package:water_del/widgets/mapWidget.dart';
import 'package:water_del/widgets/productMapWidget.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_main.dart';

class LandingWidget extends StatefulWidget {
  LandingWidget({Key key}) : super(key: key);

  @override
  _LandingWidgetState createState() => _LandingWidgetState();
}

class _LandingWidgetState extends State<LandingWidget> {
  var userCurrent;
  UserModel userModel;
  DatabaseProvider _databaseProvider = DatabaseProvider();
  List<String> display = [];
  LocationModel myLocation;
  Future productFuture;
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
              ),
            );
          case ConnectionState.active:
          case ConnectionState.none:
            return Center(
              child: Text(
                'There are no products',
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

        // _profilePage(),
        // _bottomSelection()
      ],
    );
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            clientPage(),
            Align(
              alignment: Alignment(0.25, 0),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 500, 0, 0),
                child: Container(
                  width: 350,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  child: BottomdialogueWidget(),
                                );
                              });
                        },
                        child: Container(
                          child: Padding(
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
                                        color: Colors.white,
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
                                      'Available',
                                      style: TextStyle(
                                        fontFamily: 'Ubuntu',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  child: BottomdialogueWidget(),
                                );
                              });
                        },
                        child: Align(
                          alignment: Alignment(1, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(0.25, 0),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 300, 0, 0),
                child: Container(
                  width: 350,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  child: BottomdialogueWidget(),
                                );
                              });
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
                                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Text(
                                    'Exhauster',
                                    style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      color: Color(0xFFFBF7F7),
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
                                    'Available',
                                    style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      color: Color(0xFFF2EFEF),
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
                            color: Color(0xD6FFFFFF),
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment(0, -1),
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xBFA5A5A5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.search_sharp,
                          color: Colors.white,
                          size: 24,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
