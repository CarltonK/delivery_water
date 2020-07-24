import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

enum ProductQuery { Uninitialized, Loading, Initialized, Error }

class ProductQueryProvider with ChangeNotifier {
  final Firestore db = Firestore.instance;

  ProductQuery _query = ProductQuery.Uninitialized;

  ProductQuery get query => _query;
}
