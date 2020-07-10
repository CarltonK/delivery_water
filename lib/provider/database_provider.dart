import 'package:cloud_firestore/cloud_firestore.dart';
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
}
