import 'package:cloud_firestore/cloud_firestore.dart';

class SingleAddress {
  String region;
  String town;
  String address;
  String additionalinfo;
  String uid;
  bool defaultAddress;

  SingleAddress(
      {this.region,
      this.town,
      this.address,
      this.uid,
      this.additionalinfo,
      this.defaultAddress});

  factory SingleAddress.fromFirestore(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    return SingleAddress(
        additionalinfo: data['additionalinfo'],
        defaultAddress: data['defaultAddress'],
        uid: data['uid'],
        address: data['address'],
        region: data['region'],
        town: data['town']);
  }

  Map<String, dynamic> toFirestore() => {
        'additionalinfo': additionalinfo,
        'defaultAddress': defaultAddress,
        'uid': uid,
        'address': address,
        'region': region,
        'town': town
      };
}
