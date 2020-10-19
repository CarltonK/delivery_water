import 'package:flutter/material.dart';
import 'package:water_del/models/orderModel.dart';
import 'package:intl/intl.dart';
import 'package:water_del/utilities/styles.dart';

class SingleClientOrder extends StatelessWidget {
  final OrderModel order;
  SingleClientOrder({@required this.order});

  final RoundedRectangleBorder borderStyle =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));

  dateFormatter(var time) {
    //Date Parsing and Formatting
    var formatter = new DateFormat('d MMM y HH:MM');
    String date = formatter.format(time.toDate());
    return date ?? '';
  }

  Widget singleProductContainer(var product) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue.withOpacity(0.3))),
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            product['title'],
            style: normalOutlineBlack,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            product['count'].toString(),
            style: normalOutlineBlack,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '${product['price'] * product['count']} KES',
            style: normalOutlineBlack,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.5,
      shape: borderStyle,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 200,
              alignment: Alignment.center,
              child: Container(
                height: 100,
                margin: EdgeInsets.only(left: 8),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: order.products
                      .map((item) => singleProductContainer(item))
                      .toList(),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 3,
            right: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(dateFormatter(order.date), style: normalOutlineBlack),
            ),
          ),
          Positioned(
            bottom: 3,
            left: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Total: ${order.grandtotal} KES',
                  style: boldOutlineBlack),
            ),
          ),
          Positioned(
            top: 3,
            left: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Products', style: boldOutlineBlack),
            ),
          )
        ],
      ),
    );
  }
}
