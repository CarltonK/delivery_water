import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:water_del/models/orderModel.dart';
import 'package:water_del/provider/auth_provider.dart';
import 'package:water_del/provider/database_provider.dart';
import 'package:water_del/utilities/global/dialogs.dart';
import 'package:water_del/utilities/styles.dart';
import 'package:water_del/widgets/view_client_snippet.dart';

class SingleSupplierOrder extends StatelessWidget {
  final OrderModel order;
  SingleSupplierOrder({@required this.order});

  final RoundedRectangleBorder borderStyle =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));

  Future showClientSnippet(BuildContext context) async {
    DatabaseProvider databaseProvider = DatabaseProvider();
    databaseProvider.getUser(order.client).then((value) {
      return showCupertinoModalPopup(
        context: context,
        builder: (context) => AlertDialog(
          shape: borderStyle,
          title: Text(
            'Customer',
            style: normalOutlineBlack,
          ),
          content: ClientSnippet(
            user: value,
          ),
        ),
      );
    }).catchError((error) => dialogInfo(context, error.toString()));
  }

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
    String uid = context.watch<AuthProvider>().currentUser.uid;
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
                      .where((element) => element['supplier'] == uid)
                      .map((item) => singleProductContainer(item))
                      .toList(),
                ),
              ),
            ),
          ),
          Positioned(
            top: 3,
            right: 3,
            child: IconButton(
              icon: Icon(
                CupertinoIcons.person,
              ),
              onPressed: () => showClientSnippet(context),
              tooltip: 'Client',
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
