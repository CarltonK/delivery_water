import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:water_del/models/models.dart';
import 'package:water_del/provider/provider.dart';
import 'package:water_del/utilities/utilities.dart';
import 'package:water_del/widgets/widgets.dart';

class OrderHistory extends StatefulWidget {
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

String _uid;
DatabaseProvider databaseProvider = DatabaseProvider();
Future ordersFuture;

class _OrderHistoryState extends State<OrderHistory> {
  Widget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        'Orders',
        style: headerOutlineBlack,
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _uid = context.read<AuthProvider>().currentUser.uid;
    ordersFuture = databaseProvider.getOrdersClient(_uid);
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
                  return SingleClientOrder(order: singleOrder);
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

  Widget sorryText() {
    return Center(child: Text('This will contain a list of previous orders'));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(context),
      backgroundColor: Colors.white,
      body: ordersBodyBuilder(size),
    );
  }
}
