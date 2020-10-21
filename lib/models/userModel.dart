import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String fullName;
  String email;
  final Timestamp registerDate = Timestamp.now();
  Timestamp lastLogin;
  String uid;
  String natID;
  bool clientStatus;
  String password;
  String token;
  String phone;
  var ratingCount;
  int orderCount;
  String photoUrl;
  Map<String, dynamic> location;

  UserModel(
      {this.fullName,
      this.email,
      this.uid,
      this.natID,
      this.password,
      this.lastLogin,
      this.clientStatus = true,
      this.phone,
      this.ratingCount = 0,
      this.orderCount = 0,
      this.location,
      this.photoUrl,
      this.token});

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return UserModel(
        fullName: data['fullName'] ?? '',
        natID: data['natID'],
        photoUrl: data['photoUrl'],
        location: data['location'] ?? null,
        clientStatus: data['clientStatus'],
        email: data['email'] ?? null,
        token: data['token'] ?? null,
        orderCount: data['orderCount'] ?? 0,
        ratingCount: data['ratingCount'] ?? 0,
        phone: data['phone'] ?? null,
        uid: data['uid'] ?? null);
  }

  Map<String, dynamic> toFirestore() => {
        'fullName': fullName,
        'email': email,
        'natID': natID,
        'photoUrl': photoUrl,
        'location': location,
        'lastLogin': lastLogin,
        'phone': phone,
        'registerDate': registerDate,
        'clientStatus': clientStatus,
        'ratingCount': ratingCount,
        'orderCount': orderCount,
        'uid': uid,
        'token': token
      };
}
