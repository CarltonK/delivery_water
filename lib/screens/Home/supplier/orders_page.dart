import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:water_del/models/orderModel.dart';
import 'package:water_del/provider/database_provider.dart';
import 'package:water_del/utilities/styles.dart';
import 'package:water_del/widgets/singleSupplierOrder.dart';

class OrdersPage extends StatefulWidget {
  final FirebaseUser user;
  OrdersPage({@required this.user});

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  DatabaseProvider database = DatabaseProvider();
  Future ordersFuture;

  Widget sorryText() {
    return Center(
        child: Text(
      'You have not received any order(s)',
      style: normalOutlineBlack,
      textAlign: TextAlign.center,
    ));
  }

  Widget ordersBodyBuilder(Size size) {
    return FutureBuilder<List<OrderModel>>(
      future: ordersFuture,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return SpinKitFadingCircle(
              color: Theme.of(context).primaryColor,
              size: size.height / 5,
            );
          case ConnectionState.none:
            return sorryText();
          case ConnectionState.done:
            if (snapshot.data.length == 0) return sorryText();
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListView.builder(
                itemCount: snapshot.data.length,
                addAutomaticKeepAlives: false,
                itemBuilder: (context, index) {
                  OrderModel singleOrder = snapshot.data[index];
                  return SingleSupplierOrder(order: singleOrder);
                },
              ),
            );
            break;
          default:
            return SpinKitFadingCircle(
              color: Theme.of(context).primaryColor,
              size: size.height / 4,
            );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    ordersFuture = database.getOrdersSupplier(widget.user.uid);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ordersBodyBuilder(size),
    );
  }
}