import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:water_del/models/models.dart';
import 'package:water_del/provider/provider.dart';
import 'package:water_del/utilities/utilities.dart';
import 'package:water_del/widgets/widgets.dart';
import 'package:lottie/lottie.dart';
class ProductPage extends StatefulWidget {
  final auth.User user;
  ProductPage({@required this.user});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  DatabaseProvider database = DatabaseProvider();
  Future productsFuture;

  Widget _addProductButton() {
    return FloatingActionButton(
      onPressed: () => _addProductDialog(),
      child: Icon(
        Icons.add,
        color: Colors.black,
      ),
    );
  }

  Future _addProductDialog() {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) => CreateProduct(),
    );
  }

  @override
  void initState() {
    productsFuture = database.getProducts(widget.user.uid);
    super.initState();
  }

  Widget listItem(Product product) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 1,
      child: ListTile(
        leading: Icon(Icons.sort),
        title: Text(
          product.title,
          style: boldOutlineBlack,
        ),
        isThreeLine: true,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              product.description,
              style: normalOutlineBlack,
            ),
            Text(
              'Quantity -> ' + product.quantity.toString(),
              style: normalOutlineBlack,
            ),
          ],
        ),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'KES',
              style: normalOutlineBlack,
            ),
            Text(
              product.price.toString(),
              style: boldOutlineBlack,
            ),
          ],
        ),
      ),
    );
  }

  Widget productsBodyBuilder(Size size) {
    return FutureBuilder<List<Product>>(
      future: productsFuture,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return SpinKitFadingCircle(
              color: Theme.of(context).primaryColor,
              size: size.height / 5,
            );
          case ConnectionState.none:
            return Center(
                child: Text(
              'You have not created any product(s)',
              style: headerOutlineBlack,
              textAlign: TextAlign.center,
            ));
          case ConnectionState.done:
            if (snapshot.data.length == 0)
              return Center(
                  child: Text(
                'You have not created any product(s)',
                style: headerOutlineBlack,
                textAlign: TextAlign.center,
              ));
            return ListView.builder(
              itemCount: snapshot.data.length,
              addAutomaticKeepAlives: false,
              itemBuilder: (context, index) {
                return listItem(snapshot.data[index]);
              },
            );
          default:
            return Center(
          child: Container(
            height: 80,
            width: 120,
            child: LottieBuilder.asset('assets/lottie/fluid_loader.json'),
          ),
        );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: productsBodyBuilder(size),
      floatingActionButton: _addProductButton(),
    );
  }
}
