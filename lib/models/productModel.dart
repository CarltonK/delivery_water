class ProductModel {
  String title;
  String imgUrl;
  bool selected;

  ProductModel({this.title, this.imgUrl, this.selected});
}

ProductModel bottledWater = ProductModel(
    title: 'Bottled Water',
    imgUrl: 'assets/images/bottledwater.png',
    selected: true);

ProductModel cartWater = ProductModel(
    title: 'Cart', imgUrl: 'assets/images/handcart.png', selected: true);

ProductModel tankedWater = ProductModel(
    title: 'Tanker', imgUrl: 'assets/images/tanker.png', selected: true);

ProductModel exhausterService = ProductModel(
    title: 'Exhauster', imgUrl: 'assets/images/tanker.png', selected: true);

List<ProductModel> listMainItems = [
  bottledWater,
  cartWater,
  tankedWater,
  exhausterService
];
