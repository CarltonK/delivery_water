import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:water_del/models/merchantModel2.dart';

class MerchantNotifier extends ChangeNotifier {
  List<MerchantModel> merchantList = [];
  MerchantModel _currentmerchant;

  UnmodifiableListView<MerchantModel> get merchant => UnmodifiableListView(merchantList);

  MerchantModel get currentmerchant => _currentmerchant;

  set merchant(List<MerchantModel> merchant) {
    merchantList = merchant;
    notifyListeners();
  }

  set currentmerchant(MerchantModel merchant) {
    _currentmerchant = merchant;
    notifyListeners();
  }

  addmerchant(MerchantModel merchant) {
    merchantList.insert(0, merchant);
    notifyListeners();
  }

  // deletemerchant(MerchantModel merchant) {
  //   merchantList.removeWhere((_merchant) => _merchant == merchant.id);
  //   notifyListeners();
  // }
}