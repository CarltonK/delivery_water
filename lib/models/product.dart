
class Product {
  var price;
  String id;
  String supplier;
  int quantity;
  String category;
  String title;
  String description;

  Product(
      {this.price,
      this.id,
      this.supplier,
      this.quantity,
      this.category,
      this.title,
      this.description});

  factory Product.fromJson(Map<String, dynamic> data) {
    return Product(
      category: data['category'],
      supplier: data['supplier'],
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
