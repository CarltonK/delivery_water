import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:water_del/screens/checkout/finalCheckout.dart';
import 'package:water_del/screens/checkout/singleCartItem.dart';
import 'package:water_del/utilities/global/dialogs.dart';
import 'package:water_del/utilities/global/pageTransitions.dart';
import 'package:water_del/utilities/styles.dart';
import 'package:water_del/models/orderModel.dart';

class CartScreen extends StatefulWidget {
  final OrderModel orderModel;
  CartScreen({@required this.orderModel});
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Widget _cartAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      centerTitle: true,
      title: Text(
        'Cart',
        style: headerOutlineBlack,
      ),
    );
  }

  Widget _backgroundColor() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.black.withOpacity(0.93),
    );
  }

  Widget _cartBody(Size size) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: size.height * 0.75,
        width: size.height,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(36),
            bottomRight: Radius.circular(36),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: widget.orderModel.products.length > 0
              ? ListView(
                  children: widget.orderModel.products
                      .map((e) => SingleCartItem(model: e))
                      .toList(),
                )
              : Center(
                  child: Text(
                    'There are no items in your cart',
                    style: subheaderOutlineBlack,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _finalCartDetails(Size size) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: size.width,
        padding: EdgeInsets.only(bottom: 25, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  'Total Price',
                  style: normalDescription,
                ),
                Text(
                  '${widget.orderModel.grandtotal.toStringAsFixed(2)} KES',
                  style: headerOutlineWhite,
                )
              ],
            ),
            RaisedButton(
              onPressed: () => widget.orderModel.products.length == 0
                  ? dialogInfo(context, 'There are no items in your cart')
                  : Navigator.of(context).push(
                      ScaleRoute(
                        page: FinalCheckout(
                          order: widget.orderModel,
                        ),
                      ),
                    ),
              color: Colors.blue,
              padding: EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Buy Now',
                style: buttonWhite,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _cartAppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _backgroundColor(),
          _finalCartDetails(size),
          _cartBody(size),
        ],
      ),
    );
  }
}
