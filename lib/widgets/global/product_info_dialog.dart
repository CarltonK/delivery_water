import 'package:flutter/material.dart';
import 'package:water_del/models/product.dart';
import 'package:water_del/utilities/styles.dart';

class ProductInfoDialog extends StatelessWidget {
  final Product product;
  ProductInfoDialog({@required this.product});
  static Size size;

  Widget _cancelButton(BuildContext context) {
    return FlatButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Icon(
        Icons.cancel,
        color: Colors.red,
        size: 30,
      ),
    );
  }

  Widget _addButton(BuildContext context) {
    return FlatButton(
      onPressed: () {
        // orderModel.addProduct(product);
        // print(orderModel.products);
        // Navigate to CART Screen
        // orderModel.addProduct(product);
        // Navigator.of(context).push(
        //   SlideLeftTransition(
        //     page: CartScreen(
        //       orderModel: orderModel,
        //     ),
        //   ),
        // );
      },
      child: Icon(
        Icons.add_shopping_cart,
        color: Colors.green,
        size: 30,
      ),
    );
  }

  Widget sellerContainer() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      elevation: 3,
      child: Container(
        padding: EdgeInsets.all(12),
        width: size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Distributor -> ${product.details['fullName'] ?? 'Naqua'}',
              style: normalOutlineBlack,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    product.count = 0;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        product.title,
        style: headerOutlineBlack,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            'Description',
            style: boldOutlineBlack,
          ),
          Text(
            '${product.description ?? ''}',
            style: normalOutlineBlack,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Price',
            style: boldOutlineBlack,
          ),
          Text(
            '${product.price.toStringAsFixed(2) ?? ''} KES',
            style: normalOutlineBlack,
          ),
          SizedBox(
            height: 10,
          ),
          sellerContainer()
        ],
      ),
      actions: [_cancelButton(context), _addButton(context)],
    );
  }
}
