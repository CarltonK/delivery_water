import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  //Instantiate permission handler
  final PermissionHandler _permissionHandler = PermissionHandler();

  Future<bool> requestPermission(PermissionGroup permissionGroup) async {
    //Request permissions in a permission group
    var result = await _permissionHandler.requestPermissions([permissionGroup]);
    print('result: $result');
    //result is a Map. To request the value of a single entry, pass the key,
    //which is an entry in the permissiongroup
    if (result[permissionGroup]  == PermissionStatus.granted) {
      //If permission is granted return true
      return true;
    }
    //Call the permission request window
    await _permissionHandler.shouldShowRequestPermissionRationale(permissionGroup);
    return false;
    //Otherwise return false by default
  }

  Future<bool> requestLocationPermission() async {
    PermissionGroup _permission = PermissionGroup.location;
    var result = await _permissionHandler.requestPermissions([_permission]);
    if (result[_permission] == PermissionStatus.granted) {
      return true;
    }
    else if(result[_permission] == PermissionStatus.disabled) {
      //call the function to open the desired Android menu
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
    //Otherwise return false by default
  }
}