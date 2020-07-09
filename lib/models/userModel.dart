import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:water_del/models/singleAddress.dart';

class UserModel {
  String fullName;
  String email;
  List<SingleAddress> addresses;
  final Timestamp registerDate = Timestamp.now();
  String uid;
  String password;
  String token;
  String phone;

  UserModel(
      {this.fullName,
      this.email,
      this.addresses,
      this.uid,
      this.password,
      this.phone,
      this.token});

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;
    return UserModel(
        fullName: data['fullName'] ?? null,
        email: data['email'] ?? null,
        addresses: data['addresses'],
        token: data['token'] ?? null,
        phone: data['phone'] ?? null,
        uid: data['uid'] ?? null);
  }

  Map<String, dynamic> toFirestore() => {
        'fullName': fullName,
        'email': email,
        'addresses': addresses,
        'phone': phone,
        'registerDate': registerDate,
        'uid': uid,
        'token': token
      };
}
