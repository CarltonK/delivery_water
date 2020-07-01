import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:water_del/models/cartModel.dart';
import 'package:water_del/screens/checkout/finalCheckout.dart';
import 'package:water_del/screens/checkout/singleCartItem.dart';
import 'package:water_del/utilities/global/pageTransitions.dart';
import 'package:water_del/utilities/styles.dart';

class CartScreen extends StatefulWidget {
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
          onPressed: null),
      centerTitle: true,
      title: Text(
        'Cart',
        style: headerOutlineBlack,
      ),
      actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.cancel,
              color: Colors.black,
            ),
            onPressed: null)
      ],
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
        height: size.height * 0.8,
        width: size.height,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36))),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: ListView.builder(
            itemCount: itemsCart.length,
            itemBuilder: (context, index) {
              CartModel singleItem = itemsCart[index];
              return Dismissible(
                  key: Key(itemsCart[index].title),
                  background: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(
                          CupertinoIcons.delete_solid,
                          color: Colors.white,
                        ),
                        Icon(
                          CupertinoIcons.delete_solid,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      itemsCart.removeAt(index);
                    });
                  },
                  child: SingleCartItem(model: singleItem));
            },
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
        padding: EdgeInsets.only(bottom: 5, top: 5),
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
                  '1000 KES',
                  style: headerOutlineWhite,
                )
              ],
            ),
            RaisedButton(
              onPressed: () =>
                  Navigator.of(context).push(ScaleRoute(page: FinalCheckout())),
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
