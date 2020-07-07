import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:water_del/models/singleAddress.dart';

class UserModel {
  String fullName;
  String email;
  List<SingleAddress> addresses;
  final Timestamp registerDate = Timestamp.now();
  String uid;
  String password;

  UserModel(
      {this.fullName, this.email, this.addresses, this.uid, this.password});

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;
    return UserModel(
        fullName: data['fullName'] ?? 'null',
        email: data['email'] ?? 'null',
        addresses: data['addresses'],
        uid: data['uid'] ?? 'null');
  }

  Map<String, dynamic> toFirestore() => {
        'fullName': fullName,
        'email': email,
        'addresses': addresses,
        'registerDate': registerDate,
        'uid': uid
      };
}
