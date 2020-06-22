import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:water_del/utilities/styles.dart';

class Supplier extends StatelessWidget {
  Widget _cartItems() {
    return Stack(
      alignment: Alignment.topRight,
      children: <Widget>[
        IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
            onPressed: null),
        Positioned(
          right: 3,
          child: Container(
            height: 20,
            width: 20,
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.8),
                shape: BoxShape.circle),
            child: Center(
                child: Text(
              '1',
              style: boldOutlineWhite,
            )),
          ),
        )
      ],
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: null),
      actions: <Widget>[
        _cartItems(),
      ],
    );
  }

  Widget _riderDetails(Size size) {
    return Container(
      height: 150,
      width: size.width,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.deepPurple.withOpacity(0.8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 75,
            width: 75,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[50]),
            child: FlutterLogo(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'YOUR RIDER',
                style: normalDescription,
                textAlign: TextAlign.center,
              ),
              Text(
                'Eric Kinyua',
                style: boldOutlineWhite,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Container(
            height: 75,
            child: Center(
              child: IconButton(
                  icon: Icon(Icons.phone, size: 50, color: Colors.white),
                  onPressed: null),
            ),
          )
        ],
      ),
    );
  }

  Widget _deliveryDetailsMid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              CupertinoIcons.clock_solid,
              size: 50,
              color: Colors.green,
            ),
            SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('YOUR DELIVERY TIME', style: normalOutlineBlack),
                Text('1 hour 30 minutes', style: boldOutlineBlack),
              ],
            ),
          ],
        ),
        Container(
          height: 16,
          width: 5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey[300]
          ),
        ),
        SizedBox(height: 3,),
        Container(
          height: 11,
          width: 5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey[400]
          ),
        ),
        Row(
          children: <Widget>[
            Icon(
              Icons.location_on,
              size: 50,
              color: Colors.green,
            ),
            SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('YOUR DELIVERY ADDRESS', style: normalOutlineBlack),
                Text('SECTION 9, THIKA', style: boldOutlineBlack),
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget _deliveryDetailsMap() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.blue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _riderDetails(size),
            SizedBox(
              height: 30,
            ),
            _deliveryDetailsMid(),
            SizedBox(
              height: 20,
            ),
            _deliveryDetailsMap()
          ],
        ),
      ),
    );
  }
}
