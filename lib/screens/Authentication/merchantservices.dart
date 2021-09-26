import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:water_del/widgets/global/MerchTypes.dart';

class MarkersMap extends StatefulWidget {
  @override
  _MarkersMapState createState() => _MarkersMapState();
}

class _MarkersMapState extends State<MarkersMap> {
  GoogleMapController _mapcontroller;

  List<Marker> allMarkers = [];
  var currentLocation;
  PageController _pageController;
  var merchant ;
  var merchants ;
  var merchantslenghth ;
  int prevPage;
  

// New firebase maps
  bool mapToggle = false;

  void _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
      moveCamera();
    }
  }

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  initMarkers(specify, specifyID) async {
    var markerIdValue = specifyID;
    final MarkerId markerId = MarkerId(markerIdValue);
    final Marker marker = Marker(
      markerId: markerId,
      draggable: false,
      infoWindow:
          InfoWindow(title: specify['shopName'], snippet: specify['address']),
      position:
          LatLng(specify["location"].latitude, specify["location"].longitude),
    );
    setState(() {
      markers[markerId] = marker;

    });
  }

  populateMarkers() {
    FirebaseFirestore.instance.collection('merchants').get().then((value) {
      if (value.docs.isNotEmpty) {
        for (int i = 0; i < value.docs.length; i++) {
         
          initMarkers(value.docs[i].data(), value.docs[i].id);
        setState(() {
          
          merchants = value.docs[i].data();
          
        });

        
        }
      }
      else Fluttertoast.showToast(msg: "No shops found", toastLength: Toast.LENGTH_SHORT,);
    });
  }
  getMerchants() {
    FirebaseFirestore.instance.collection('merchants')
    .doc('merchtype').get().then((value) {
      if (value.exists) {
        setState(() {
          merchantslenghth = value.data().length;
        });
      }
    });
  
  }





  @override
  void initState() {
    // TODO: implement initState
    populateMarkers();
    super.initState();
    Geolocator.getCurrentPosition().then((value) {
      setState(() {
        value = currentLocation;
        mapToggle = true;
      });
    });

    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mapToggle == true
          ? Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height - 50.0,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMap(
                    markers: Set.from(markers.values),
                    onMapCreated: mapCreated,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(-1.2320662, 36.8780867), zoom: 12.0),
                  ),
                ),

                Positioned(
                  bottom: 20,
                                  child: Container(
                    height:70,
                    width: MediaQuery.of(context).size.width,
                    child: 
                    
                  MerchTypes(),

                  ),
                )
              ],
            )
          : Center(child: CircularProgressIndicator()),
      // Stack(
      //   children: <Widget>[
      //     Container(
      //       height: MediaQuery.of(context).size.height - 50.0,
      //       width: MediaQuery.of(context).size.width,
      //       child:
      //       GoogleMap(
      //         initialCameraPosition: CameraPosition(
      //             target: LatLng(-1.2320662, 36.8780867), zoom: 12.0),
      //         markers: Set.from(allMarkers),
      //         onMapCreated: mapCreated,
      //       ),
      //     ),
      //     Positioned(
      //       bottom: 20.0,
      //       child: Container(
      //         height: 200.0,
      //         width: MediaQuery.of(context).size.width,
      //         child: PageView.builder(
      //           controller: _pageController,
      //           itemCount: merchant.length,
      //           itemBuilder: (BuildContext context, int index) {
      //             return _coffeeShopList(index);
      //           },
      //         ),
      //       ),
      //     )
      //   ],
      // )
    );
  }

  void mapCreated(controller) {
    setState(() {
      _mapcontroller = controller;
    });
  }

  moveCamera() {
    _mapcontroller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: merchant[_pageController.page.toInt()].locationCoords,
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }
  // _coffeeShopList(index) {
  //   return AnimatedBuilder(
  //     animation: _pageController,
  //     builder: (BuildContext context, Widget widget) {
  //       double value = 1;
  //       if (_pageController.position.haveDimensions) {
  //         value = _pageController.page - index;
  //         value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
  //       }
  //       return Center(
  //         child: SizedBox(
  //           height: Curves.easeInOut.transform(value) * 125.0,
  //           width: Curves.easeInOut.transform(value) * 350.0,
  //           child: widget,
  //         ),
  //       );
  //     },
  //     child: InkWell(
  //         onTap: () {
  //           // moveCamera();
  //         },
  //         child: Stack(children: [
  //           Center(
  //               child: Container(
  //                   margin: EdgeInsets.symmetric(
  //                     horizontal: 10.0,
  //                     vertical: 20.0,
  //                   ),
  //                   height: 125.0,
  //                   width: 275.0,
  //                   decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(10.0),
  //                       boxShadow: [
  //                         BoxShadow(
  //                           color: Colors.black54,
  //                           offset: Offset(0.0, 4.0),
  //                           blurRadius: 10.0,
  //                         ),
  //                       ]),
  //                   child: Container(
  //                       decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(10.0),
  //                           color: Colors.white),
  //                       child: Row(children: [
  //                         Expanded(
  //                                                     child: Container(
  //                               height: 90.0,
  //                               width: 90.0,
  //                               decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.only(
  //                                       bottomLeft: Radius.circular(10.0),
  //                                       topLeft: Radius.circular(10.0)),
  //                                   image: DecorationImage(
  //                                       image: NetworkImage(
  //                                           merchant[index].thumbNail),
  //                                       fit: BoxFit.cover))),
  //                         ),
  //                         SizedBox(width: 5.0),
  //                         Column(
  //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Text(
  //                                 merchant[index].shopName,
  //                                 style: TextStyle(
  //                                     fontSize: 12.5,
  //                                     fontWeight: FontWeight.bold),
  //                               ),
  //                               Text(
  //                                 merchant[index].address,
  //                                 style: TextStyle(
  //                                     fontSize: 12.0,
  //                                     fontWeight: FontWeight.w600),
  //                               ),
  //                               Container(
  //                                 width: 170.0,
  //                                 child: Text(
  //                                   merchant[index].description,
  //                                   style: TextStyle(
  //                                       fontSize: 11.0,
  //                                       fontWeight: FontWeight.w300),
  //                                 ),
  //                               )
  //                             ])
  //                       ]))))
  //         ])),
  //   );

  // }

  // merchant.forEach((element) {
  //         allMarkers.add(Marker(
  //       markerId: MarkerId(element.shopName),
  //       draggable: false,
  //       infoWindow:
  //           InfoWindow(title: element.shopName, snippet: element.address),
  //       position: element.locationCoords));
  // });

}
