import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  final PermissionHandler _permissionHandler = PermissionHandler();

  Future<bool> requestPermission(PermissionGroup permissionGroup) async {
    var result = await _permissionHandler.requestPermissions([permissionGroup]);
    print('result: $result');
    if (result[permissionGroup] == PermissionStatus.granted) {
      return true;
    }
    //Call the permission request window
    await _permissionHandler
        .shouldShowRequestPermissionRationale(permissionGroup);
    return false;
  }

  Future<bool> requestLocationPermission() async {
    PermissionGroup _permission = PermissionGroup.location;
    var result = await _permissionHandler.requestPermissions([_permission]);
    if (result[_permission] == PermissionStatus.granted) {
      return true;
    } else if (result[_permission] == PermissionStatus.disabled) {
      var location = loc.Location();
      bool status = await location.requestService();
      if (status) {
        requestLocationPermission();
      }
      requestLocationPermission();
    }
    //Call the permission request window
    await _permissionHandler.shouldShowRequestPermissionRationale(_permission);
    return false;
  }
}
