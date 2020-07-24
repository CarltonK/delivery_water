import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:water_del/models/locationModel.dart';
import 'package:water_del/models/product.dart';
import 'package:water_del/provider/database_provider.dart';

class ProductMapWidget extends StatefulWidget {
  final LocationModel location;
  final FirebaseUser user;
  final List<Product> products;
  ProductMapWidget(
      {@required this.products, @required this.user, @required this.location});

  @override
  _ProductMapWidgetState createState() => _ProductMapWidgetState();
}

class _ProductMapWidgetState extends State<ProductMapWidget> {
  DatabaseProvider _databaseProvider = DatabaseProvider();
  Completer<GoogleMapController> _controller = Completer();
  final Map<String, Marker> _markers = {};
  LocationModel myLocation;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _markers.clear();
        for (var item in widget.products) {
          print(item.details);
          double latitude = item.details['location']['latitude'];
          double longitude = item.details['location']['longitude'];
          String itemIndex = widget.products.indexOf(item).toString();
          final marker = Marker(
              markerId: MarkerId(itemIndex),
              position: LatLng(latitude, longitude),
              icon: BitmapDescriptor.defaultMarkerWithHue(0.8),
              infoWindow:
                  InfoWindow(title: item.title, snippet: item.description));
          _markers[itemIndex] = marker;
        }
      });
    });
  }

  @override
  void initState() {
    Future.delayed(
        Duration(seconds: 1),
        () => _databaseProvider
            .updateLocation(widget.user.uid, myLocation)
            .then((value) => print('We have updated the location of the user'))
            .catchError((error) =>
                print('updateLocation ERROR -> ${error.toString()}')));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    myLocation = widget.location;
    double lat = myLocation.latitude;
    double lon = myLocation.longitude;
    return GoogleMap(
        onMapCreated: _onMapCreated,
        zoomControlsEnabled: false,
        markers: _markers.values.toSet(),
        initialCameraPosition:
            CameraPosition(target: LatLng(lat, lon), zoom: 12));
  }
}
