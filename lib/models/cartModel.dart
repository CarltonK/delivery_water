class CartModel {
  var price;
  String imgUrl;
  String title;
  var quantity;

  CartModel({this.price, this.imgUrl, this.title, this.quantity});
}

CartModel bottledWater1 = CartModel(
    imgUrl:
        'https://images.unsplash.com/photo-1563340605-4b8bfa223b32?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80',
    price: 100,
    quantity: 4,
    title: 'Bottled Water 1');

CartModel bottledWater2 = CartModel(
    imgUrl:
        'https://images.unsplash.com/photo-1563340605-4b8bfa223b32?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80',
    price: 80,
    quantity: 2,
    title: 'Bottled Water 2');

List<CartModel> itemsCart = [
  bottledWater1,
  bottledWater2,
];
