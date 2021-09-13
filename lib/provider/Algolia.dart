
import 'dart:convert';
// import 'package:algolia/algolia.dart';
import 'package:flutter/services.dart';

class AlgoliaAPI {

  static const platform = const MethodChannel('com.algolia/api');

  Future<dynamic> search(String query) async {
    try {
      var response = await platform.invokeMethod('search', ['instant_search', query]);
      return jsonDecode(response);
    } on PlatformException catch (_) {
      return null;
    }
  }

}
