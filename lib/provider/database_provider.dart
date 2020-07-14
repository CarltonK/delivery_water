import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:water_del/models/locationModel.dart';
import 'package:water_del/models/singleAddress.dart';
import 'package:water_del/models/userModel.dart';

class DatabaseProvider {
  final Firestore _db = Firestore.instance;

  DatabaseProvider() {
    print('Firestore has been initialized');
  }

  //Returning data as a future
  Future<UserModel> getUser(String uid) async {
    var snap = await _db.collection('users').document(uid).get();
    return UserModel.fromFirestore(snap);
  }

  //Returning document data as a stream
  Stream<UserModel> streamUser(String uid) {
    return _db
        .collection('users')
        .document(uid)
        .snapshots()
        .map((event) => UserModel.fromFirestore(event));
  }

  //Set an address
  Future<void> setAddress(String uid, SingleAddress address) async {
    await _db
        .collection('users')
        .document(uid)
        .collection('addresses')
        .document()
        .setData(address.toFirestore());
  }

  //Get an address
  Future<List<SingleAddress>> getAddresses(String uid) async {
    try {
      QuerySnapshot snapshotAddresses = await _db
          .collection('users')
          .document(uid)
          .collection('addresses')
          .orderBy('defaultAddress', descending: true)
          .getDocuments();
      List<SingleAddress> addresses = [];
      snapshotAddresses.documents.forEach((element) {
        SingleAddress address = SingleAddress.fromFirestore(element);
        addresses.add(address);
      });
      return addresses;
    } catch (e) {
      print('getAddresses ERROR -> ${e.toString()}');
      return null;
    }
  }

  Future<void> updateLocation(String uid, LocationModel model) async {
    await _db
        .collection('users')
        .document(uid)
        .updateData({'location': model.toFirestore()});
  }

  Future<void> updatePhoneandStatus(
      String uid, String phone, bool status) async {
    await _db
        .collection('users')
        .document(uid)
        .updateData({'phone': phone, 'clientStatus': status});
  }
}
