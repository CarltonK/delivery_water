import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  String orderId;
  String supplier;
  String client;
  String title;
  String description;
  final Timestamp time = Timestamp.now();

  ReviewModel(
      {this.orderId, this.supplier, this.client, this.title, this.description});

  factory ReviewModel.fromFirestore(DocumentSnapshot snapshot) {
    Map data = snapshot.data;
    return ReviewModel(
        orderId: data['orderId'],
        supplier: data['supplier'],
        client: data['client'],
        title: data['title'],
        description: data['description']);
  }

  Map<String, dynamic> toFirestore() => {
    'orderId': orderId,
    'supplier': supplier,
    'client': client,
    'title': title,
    'description': description,
    'time': time
  };
}
