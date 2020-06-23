import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:water_del/utilities/styles.dart';

class FinalCheckout extends StatelessWidget {
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

  Widget _checkoutBody(Size size) {
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
        child: ListView(
          children: <Widget>[
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Image.asset('assets/logos/mpesa_logo.png'),
                contentPadding: EdgeInsets.all(12),
                trailing: Radio(
                  value: null,
                  groupValue: null,
                  onChanged: (value) {},
                ),
              ),
            ),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Image.asset('assets/logos/cash.png'),
                contentPadding: EdgeInsets.all(12),
                trailing: Radio(
                  value: null,
                  groupValue: null,
                  onChanged: (value) {},
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            TextFormField(
                decoration: InputDecoration(labelText: 'Enter a coupon code')),
            SizedBox(
              height: 120,
            ),
            Row(
              children: <Widget>[
                Text(
                  'ITEMS(4)',
                  style: normalOutlineBlack,
                ),
                SizedBox(
                  width: 212,
                ),
                Text(
                  'ksh 68',
                  style: boldOutlineBlack,
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: <Widget>[
                Text(
                  'Delivery Services',
                  style: normalOutlineBlack,
                ),
                SizedBox(
                  width: 150,
                ),
                Text(
                  'ksh 100',
                  style: boldOutlineBlack,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Text(
                  'Total Price',
                  style: normalOutlineBlack,
                ),
                SizedBox(
                  width: 198,
                ),
                Text(
                  'ksh 168',
                  style: boldOutlineBlack,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _finalCheckoutDetails(Size size) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: size.width,
        padding: EdgeInsets.only(bottom: 5, top: 5),
        child: FlatButton(
          onPressed: () {},
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
          _finalCheckoutDetails(size),
          _checkoutBody(size),
        ],
      ),
    );
  }
}
