import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_del/main.dart';
import 'package:water_del/models/orderModel.dart';
import 'package:water_del/provider/database_provider.dart';
import 'package:water_del/utilities/global/dialogs.dart';
import 'package:water_del/utilities/global/pageTransitions.dart';
import 'package:water_del/utilities/styles.dart';

class FinalCheckout extends StatelessWidget {
  final DatabaseProvider databaseProvider = DatabaseProvider();

  Widget _checkoutAppBar(BuildContext context) {
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
        'Checkout',
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

  Widget _paymentMethodCard(String asset) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Image.asset(asset),
        contentPadding: EdgeInsets.all(12),
        trailing: Radio(
          value: null,
          groupValue: null,
          onChanged: (value) {},
        ),
      ),
    );
  }

  Widget _infoRow(String title, var sub) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: normalOutlineBlack,
        ),
        Text(
          sub,
          style: boldOutlineBlack,
        )
      ],
    );
  }

  Widget _checkoutBody(Size size, BuildContext context) {
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
            bottomRight: Radius.circular(36),
          ),
        ),
        child: Column(
          children: <Widget>[
            _paymentMethodCard('assets/logos/mpesa_logo.png'),
            Expanded(
              child: Container(),
            ),
            _infoRow('Total Price',
                '${Provider.of<OrderModel>(context).grandtotal.toStringAsFixed(2)} KES'),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget _finalCheckoutDetails(BuildContext context, Size size) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: size.width,
        padding: EdgeInsets.only(bottom: 5, top: 5),
        child: FlatButton(
          onPressed: () {
            databaseProvider
                .createOrder(Provider.of<OrderModel>(context, listen: false))
                .then((value) {
              dialogInfo(
                context,
                "We have received your order. Enter your MPESA PIN to process your transaction",
              );
              Provider.of<OrderModel>(context, listen: false).products = [];
              Provider.of<OrderModel>(context, listen: false).grandtotal = 0;
              Timer(Duration(seconds: 2), () {
                Navigator.of(context).pushReplacement(
                  SlideRightTransition(
                    page: MyApp(),
                  ),
                );
              });
            }).catchError(
              (error) => dialogInfo(
                context,
                error.toString(),
              ),
            );
          },
          color: Colors.transparent,
          padding: EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Confirm Order',
            style: headerOutlineWhite,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _checkoutAppBar(context),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _backgroundColor(),
          _finalCheckoutDetails(context, size),
          _checkoutBody(size, context),
        ],
      ),
    );
  }
}
