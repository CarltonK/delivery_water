import 'package:water_del/models/userModel.dart';

class Product {
  var price;
  String id;
  String supplier;
  int quantity;
  Map<String, dynamic> details;
  String category;
  String title;
  String description;

  Product(
      {this.price,
      this.id,
      this.details,
      this.supplier,
      this.quantity,
      this.category,
      this.title,
      this.description});

  factory Product.fromJson(Map<String, dynamic> data) {
    return Product(
      category: data['category'],
      supplier: data['supplier'],
      details: data['details'],
      quantity: data['quantity'],
      description: data['description'],
      id: data['id'],
      price: data['price'],
      title: data['title'],
    );
  }

  Map<String, dynamic> toJson() => {
        'category': category,
        'supplier': supplier,
        'quantity': quantity,
        'description': description,
        'id': id,
        'price': price,
        'title': title
      };
}
