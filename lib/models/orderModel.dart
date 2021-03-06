import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:water_del/models/models.dart';

class OrderModel with ChangeNotifier {
  String id;
  String client;
  LocationModel location;
  var status;
  List<dynamic> suppliers;
  final Timestamp date = Timestamp.now();
  List<dynamic> products;
  var grandtotal;

  List<dynamic> get _products => products;

  OrderModel({
    this.id,
    this.client,
    this.location,
    this.suppliers,
    this.status,
    this.products,
    this.grandtotal,
  });

  addProduct(element) {
    // print('Added product: ${element.toJson()}');
    if (_products.contains(element)) {
      int index = _products.indexOf(element);
      _products[index].count++;
    } else {
      element.count = 1;
      _products.add(element);
    }
    calculateTotal();
  }

  removeProduct(int index) {
    print('Removed product: ${_products[index].toJson()}');
    if (_products[index].count <= 1) {
      _products.removeAt(index);
    } else {
      _products[index].count--;
    }
    calculateTotal();
  }

  calculateTotal() {
    for (var item in _products) {
      grandtotal = (item.price * item.count);
    }
    notifyListeners();
    // print('Total: $grandtotal');
    // print('All Products: $_products');
  }

  factory OrderModel.fromFirestore(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    Map loc = data['location'];
    return OrderModel(
      id: snapshot.id,
      grandtotal: data['grandtotal'],
      suppliers: data['suppliers'],
      client: data['client'],
      location: LocationModel.fromFirestore(loc),
      status: data['status'],
      products: data['products'],
    );
  }

  Map<String, dynamic> toFirestore() => {
        'client': client,
        'grandtotal': grandtotal,
        'location': location.toFirestore(),
        'status': status,
        'date': date,
        'products': products,
      };
}
