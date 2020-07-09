import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:water_del/models/locationModel.dart';

class MapWidget extends StatefulWidget {
  final LocationModel coordinates;
  MapWidget({@required this.coordinates});
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        onMapCreated: _onMapCreated,
        zoomControlsEnabled: false,
        initialCameraPosition: CameraPosition(
            target: LatLng(
                widget.coordinates.latitude, widget.coordinates.longitude),
            zoom: 15));
  }
}
