import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:water_del/models/locationModel.dart';

class OrderModel {
  String supplier;
  String client;
  LocationModel location;
  var status;
  final Timestamp date = Timestamp.now();
  List<dynamic> products;

  OrderModel(
      {this.supplier, this.client, this.location, this.status, this.products});

  factory OrderModel.fromFirestore(DocumentSnapshot snapshot) {
    Map data = snapshot.data;
    Map loc = data['location'];
    return OrderModel(
        supplier: data['supplier'],
        client: data['client'],
        location: LocationModel.fromFirestore(loc),
        status: data['status'],
        products: data['products']);
  }

  Map<String, dynamic> toFirestore() => {
        'supplier': supplier,
        'client': client,
        'location': location,
        'status': status,
        'date': date,
        'products': products
      };
}
