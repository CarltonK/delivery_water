import 'package:flutter/material.dart';
import 'package:water_del/models/orderModel.dart';
import 'package:water_del/models/product.dart';
import 'package:water_del/utilities/styles.dart';

class ProductInfoDialog extends StatelessWidget {
  final Product product;
  final OrderModel orderModel;
  ProductInfoDialog({@required this.product, @required this.orderModel});
  static Size size;

  Widget _cancelButton(BuildContext context) {
    return FlatButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Icon(
          Icons.cancel,
          color: Colors.red,
          size: 30,
        ));
  }

  Widget _addButton(BuildContext context) {
    return FlatButton(
        onPressed: () {
          orderModel.addProduct(product);
          print(orderModel.toFirestore());
        },
        child: Icon(
          Icons.add_shopping_cart,
          color: Colors.green,
          size: 30,
        ));
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
    print(orderModel.toFirestore());
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
            'Description\n${product.description ?? ''}',
            style: normalOutlineBlack,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Price\n'
            '${product.price.toStringAsFixed(2) ?? ''} KES',
            style: boldOutlineBlack,
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
