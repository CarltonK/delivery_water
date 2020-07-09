import 'package:location/location.dart';
import 'package:water_del/models/locationModel.dart';

class LocationService {
  LocationModel _currentLocation;
  var location = Location();
  Future<LocationModel> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = LocationModel(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }
    return _currentLocation;
  }
}