class ProductModel {
  String title;
  String category;
  String imgUrl;
  bool selected;

  ProductModel({this.title, this.imgUrl, this.selected, this.category});
}

ProductModel bottledWater = ProductModel(
    title: 'Bottled Water',
    category: 'bottled',
    imgUrl: 'assets/images/bottledwater.png',
    selected: true);

ProductModel cartWater = ProductModel(
    title: 'Jerrycan',
    imgUrl: 'assets/images/handcart.png',
    selected: true,
    category: 'cart');

ProductModel tankedWater = ProductModel(
    title: 'Tanker',
    imgUrl: 'assets/images/tanker.png',
    selected: true,
    category: 'tanker');

ProductModel exhausterService = ProductModel(
    title: 'Exhauster',
    imgUrl: 'assets/images/tanker.png',
    selected: true,
    category: 'exhauster');

List<ProductModel> listMainItems = [
  bottledWater,
  cartWater,
  tankedWater,
  exhausterService
];
