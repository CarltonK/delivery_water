import 'dart:async';

import 'package:location/location.dart';
import 'package:water_del/models/locationModel.dart';

class LocationProvider {
  StreamController<LocationModel> _locationController =
      StreamController<LocationModel>();
  Stream<LocationModel> get locationStream => _locationController.stream;

  LocationModel _currentLocation;
  Location location = Location();

  Future<LocationModel> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = LocationModel(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } on Exception catch (e) {
      print('getLocation ERROR -> ${e.toString()}');
    }
    return _currentLocation;
  }

  LocationProvider() {
    //Permission to use location
    location.requestPermission().then((granted) {
      if (granted == PermissionStatus.GRANTED) {
        //Check if GPS is on
        location.requestService().then((value) {
          if (value) {
            location
                .changeSettings(
                    accuracy: LocationAccuracy.BALANCED, interval: 100)
                .then((value) {
              //listen to location change stream
              location.onLocationChanged().listen((locationData) {
                if (locationData != null) {
                  _locationController.add(LocationModel(
                      latitude: locationData.latitude,
                      longitude: locationData.longitude));
                }
              });
            });
          }
        });
      }
    });
  }
}
