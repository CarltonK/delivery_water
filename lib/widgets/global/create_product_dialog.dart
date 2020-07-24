import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:water_del/models/product.dart';
import 'package:water_del/provider/auth_provider.dart';
import 'package:water_del/provider/database_provider.dart';
import 'package:water_del/utilities/global/dialogs.dart';
import 'package:water_del/utilities/styles.dart';

class CreateProduct extends StatefulWidget {
  @override
  _CreateProductState createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode focusTitle = FocusNode();
  final FocusNode focusDesc = FocusNode();

  String category;
  int quantity = 1;
  double price;
  String title;
  String description;
  String supplier;

  handlePrice(String value) {
    price = double.parse(value.trim());
    print('Price -> $price KES');
  }

  handleTitle(String value) {
    title = value.trim();
    print('Title -> $title');
  }

  handleDescription(String value) {
    description = value.trim();
    print('Description -> $description');
  }

  void _addProductPressed() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      Product product = Product(
          category: category,
          description: description,
          id: null,
          price: price,
          quantity: quantity,
          supplier: supplier,
          title: title);
      Provider.of<DatabaseProvider>(context, listen: false)
          .postProduct(supplier, product)
          .then((value) {
        Timer(
            Duration(seconds: 1),
            () => dialogInfo(
                context, 'Your product has been created successfully'));
      }).catchError((error) {
        Timer(
            Duration(seconds: 1), () => dialogInfo(context, error.toString()));
      });
    }
  }

  Widget _addProductButton() {
    return FlatButton(
        onPressed: _addProductPressed,
        child: Text(
          'ADD',
          style: boldOutlineGreen,
        ));
  }

  Widget _cancelProductButton() {
    return FlatButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(
          'CANCEL',
          style: boldOutlineRed,
        ));
  }

  String validatePrice(String value) {
    if (value.isEmpty) return 'Please enter a price';
    if (double.parse(value) < 1) return 'Price is too low';
    return null;
  }

  String validateTitle(String value) {
    if (value.isEmpty) return 'Please enter a title';
    return null;
  }

  String validateDesc(String value) {
    if (value.isEmpty) return 'Please enter a description';
    return null;
  }

  Widget priceField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      onFieldSubmitted: (value) =>
          FocusScope.of(context).requestFocus(focusTitle),
      onSaved: handlePrice,
      validator: validatePrice,
      decoration:
          InputDecoration(labelText: 'Price', labelStyle: normalOutlineBlack),
    );
  }

  Widget titleField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      focusNode: focusTitle,
      keyboardType: TextInputType.text,
      onFieldSubmitted: (value) =>
          FocusScope.of(context).requestFocus(focusDesc),
      onSaved: handleTitle,
      validator: validateTitle,
      decoration:
          InputDecoration(labelText: 'Title', labelStyle: normalOutlineBlack),
    );
  }

  Widget descField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      focusNode: focusDesc,
      validator: validateDesc,
      onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
      onSaved: handleDescription,
      decoration: InputDecoration(
          labelText: 'Description', labelStyle: normalOutlineBlack),
    );
  }

  List<DropdownMenuItem> items = [
    DropdownMenuItem<dynamic>(
        value: 'bottled',
        child: Text(
          'Bottled Water',
          style: normalOutlineBlack,
        )),
    DropdownMenuItem<dynamic>(
        value: 'tanker',
        child: Text(
          'Tanker',
          style: normalOutlineBlack,
        )),
    DropdownMenuItem<dynamic>(
        value: 'cart',
        child: Text(
          'Hand Cart',
          style: normalOutlineBlack,
        )),
    DropdownMenuItem<dynamic>(
        value: 'exhauster',
        child: Text(
          'Exhauster Services',
          style: normalOutlineBlack,
        ))
  ];

  categoryChanger(String value) {
    setState(() {
      category = value;
    });
  }

  Widget categoryDropDown() {
    return DropdownButton<dynamic>(
      items: items,
      isExpanded: true,
      hint: Text(
        'Category',
        style: normalOutlineBlack,
      ),
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: Colors.black,
      ),
      value: category,
      onChanged: (value) => categoryChanger(value),
    );
  }

  Widget quantitySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          'Quantity',
          style: normalOutlineBlack,
        ),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: quantity.toDouble(),
                max: 100,
                divisions: 100,
                min: 1,
                label: quantity.toString(),
                onChanged: (value) {
                  setState(() {
                    quantity = value.toInt();
                  });
                },
              ),
            ),
            Text(
              quantity.toString(),
              style: normalOutlineBlack,
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, AuthProvider user, child) {
        supplier = user.currentUser.uid;
        return Consumer<DatabaseProvider>(
          builder: (context, DatabaseProvider value, child) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            content: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      categoryDropDown(),
                      quantitySelector(),
                      priceField(),
                      titleField(),
                      descField()
                    ],
                  ),
                )),
            actions: [
              _addProductButton(),
              _cancelProductButton(),
            ],
          ),
        );
      },
    );
  }
}
