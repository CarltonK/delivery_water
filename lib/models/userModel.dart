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
  var ratingCount;
  int orderCount;
  String photoUrl;

  UserModel(
      {this.fullName,
      this.email,
      this.addresses,
      this.uid,
      this.password,
      this.phone,
      this.ratingCount = 0,
      this.orderCount = 0,
      this.photoUrl,
      this.token});

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;
    return UserModel(
        fullName: data['fullName'] ?? null,
        photoUrl: data['photoUrl'],
        email: data['email'] ?? null,
        addresses: data['addresses'],
        token: data['token'] ?? null,
        orderCount: data['orderCount'] ?? 0,
        ratingCount: data['ratingCount'] ?? 0,
        phone: data['phone'] ?? null,
        uid: data['uid'] ?? null);
  }

  Map<String, dynamic> toFirestore() => {
        'fullName': fullName,
        'email': email,
        'addresses': addresses,
        'photoUrl': photoUrl,
        'phone': phone,
        'registerDate': registerDate,
        'ratingCount': ratingCount,
        'orderCount': orderCount,
        'uid': uid,
        'token': token
      };
}
