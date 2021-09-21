import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MerchantModel {

  String id;
  String shopName;
  String address;
  String description;
  String thumbNail;
  LatLng locationCoords;


MerchantModel(this.id,this.shopName, this.address, this.description, this.thumbNail, this.locationCoords);
  

  MerchantModel.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    shopName = data['shopName'];
    address = data['address'];
    description = data['description'];
    thumbNail = data['thumbNail'];
    locationCoords = data['locationCoords'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shopName': shopName,
      'address': address,
      'description': description,
      'thumbNail': thumbNail,
      'locationCoords': locationCoords,
    };
  }
}