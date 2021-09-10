import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:water_del/models/locationModel.dart';
import 'package:water_del/provider/database_provider.dart';

class MapWidget extends StatefulWidget {
  final auth.User user;
  final List<LocationModel> coordinates;
  MapWidget({@required this.coordinates, @required this.user});

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  DatabaseProvider _databaseProvider = DatabaseProvider();
  Completer<GoogleMapController> _controller = Completer();
  final Map<String, Marker> _markers = {};
  LocationModel myLocation;
  BitmapDescriptor pinLocationIcon;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _markers.clear();
        for (var item in widget.coordinates) {
          String itemIndex = widget.coordinates.indexOf(item).toString();
          final marker = Marker(
              markerId: MarkerId(itemIndex),
              position: LatLng(item.latitude, item.longitude),
              infoWindow: InfoWindow(
                  title: 'You are here', snippet: widget.user.email ?? ''),
              icon: pinLocationIcon);
          _markers[itemIndex] = marker;
        }
      });
    });
  }
  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/map_marker.png');
  }

  @override
  void initState() {
    setCustomMapPin();
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
    myLocation = widget.coordinates[0];
    // double lat = myLocation.latitude;
    // double lon = myLocation.longitude;
      double lat =-1.2320662;
    double lon = 36.8780867;
    
    return GoogleMap(
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        markers: _markers.values.toSet(),
        myLocationButtonEnabled: true,
        initialCameraPosition:
            CameraPosition(target: LatLng(lat, lon), zoom: 13, bearing: 30)
            );
  }
}
