import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:water_del/models/models.dart';

class DatabaseProvider {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging fcm = FirebaseMessaging();
  final Timestamp now = Timestamp.now();

  DatabaseProvider() {
    print('Firestore has been initialized');
  }

  Future saveUser(UserModel user, String uid) async {
    user.location = null;
    user.uid = uid;
    try {
      user.token = await fcm.getToken();
      await _db.collection("users").doc(uid).set(user.toFirestore());
    } catch (e) {
      print("saveUser ERROR -> ${e.toString()}");
    }
  }

  Future<void> setLastLogin(String uid, Timestamp now) async {
    try {
      await _db.collection('users').doc(uid).update(
        {'lastLogin': now},
      );
    } catch (e) {
      print("setLastLogin ERROR -> ${e.toString()}");
    }
  }

  Future<UserModel> getUser(String uid) async {
    var snap = await _db.collection('users').doc(uid).get();
    return UserModel.fromFirestore(snap);
  }

  Stream<UserModel> streamUser(String uid) {
    return _db
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((event) => UserModel.fromFirestore(event));
  }

  Future<void> setAddress(String uid, SingleAddress address) async {
    try {
      await _db
          .collection('users')
          .doc(uid)
          .collection('addresses')
          .doc()
          .set(address.toFirestore());
    } catch (e) {
      print("setAddress ERROR -> ${e.toString()}");
      return null;
    }
  }

  Future<List<SingleAddress>> getAddresses(String uid) async {
    try {
      QuerySnapshot snapshotAddresses = await _db
          .collection('users')
          .doc(uid)
          .collection('addresses')
          .orderBy('defaultAddress', descending: true)
          .get();
      List<SingleAddress> addresses = [];
      snapshotAddresses.docs.forEach((element) {
        SingleAddress address = SingleAddress.fromFirestore(element);
        addresses.add(address);
      });
      return addresses;
    } catch (e) {
      print('getAddresses ERROR -> ${e.toString()}');
      return null;
    }
  }

  Future<void> updateLocation(String uid, LocationModel model) async {
    try {
      await _db
          .collection('users')
          .doc(uid)
          .update({'location': model.toFirestore()});
    } catch (e) {
      print('updateLocation ERROR -> ${e.toString()}');
      return null;
    }
  }

  Future<void> updatePhoneandStatus(
      String uid, String phone, String natId, bool status) async {
    try {
      await _db
          .collection('users')
          .doc(uid)
          .update({'phone': phone, 'clientStatus': status, 'natID': natId});
    } catch (e) {
      print('updatePhoneandStatus ERROR -> ${e.toString()}');
      return null;
    }
  }

  Future<void> postProduct(String uid, Product product) async {
    try {
      await _db
          .collection('users')
          .doc(uid)
          .collection('products')
          .doc()
          .set(product.toJson());
    } catch (e) {
      print('postProduct ERROR -> ${e.toString()}');
      return null;
    }
  }

  Future<List<Product>> getProducts(String uid) async {
    try {
      List<Product> queryData = [];
      QuerySnapshot snapshot = await _db
          .collectionGroup('products')
          .where('supplier', isEqualTo: uid)
          .orderBy('price', descending: true)
          .get();
      snapshot.docs.forEach((element) {
        Product product = Product.fromJson(element.data());
        queryData.add(product);
      });
      return Future.value(queryData);
    } catch (e) {
      print('getProducts ERROR -> ${e.toString()}');
      return null;
    }
  }

  Future<List<ReviewModel>> getReviews(String uid) async {
    try {
      List<ReviewModel> reviews = [];
      QuerySnapshot snapshot = await _db
          .collection('reviews')
          .where('supplier', isEqualTo: uid)
          .orderBy('time', descending: true)
          .get();
      snapshot.docs.forEach((element) {
        ReviewModel review = ReviewModel.fromFirestore(element);
        reviews.add(review);
      });
      return Future.value(reviews);
    } catch (e) {
      print('getReviews ERROR -> ${e.toString()}');
      return null;
    }
  }

  Future<List<Product>> populateMap(List<String> categories) async {
    List<Product> products = [];
    if (categories != null && categories.length > 0) {
      try {
        QuerySnapshot snapshot = await _db
            .collectionGroup('products')
            .where('category', whereIn: categories)
            .orderBy('price', descending: true)
            .get();
        snapshot.docs.forEach((element) {
          Product product = Product.fromJson(element.data());
          products.add(product);
        });
        return products;
      } catch (e) {
        print('populateMap ERROR -> ${e.toString()}');
      }
    }
    return null;
  }

  Future<void> uploadDP(String uid, String dp) async {
    try {
      await _db.collection('users').doc(uid).update({'photoUrl': dp});
    } catch (e) {
      print('uploadDP ERROR -> ${e.toString()}');
    }
  }

  Future createOrder(OrderModel order) async {
    print(order);
    List<dynamic> products = order.products;
    products.forEach((element) {
      int index = products.indexOf(element);
      products.removeAt(index);
      products.insert(index, element.toJson());
    });
    try {
      await _db.collection('orders').doc().set(order.toFirestore());
    } catch (e) {
      print('createOrder ERROR -> ${e.toString()}');
      return null;
    }
  }

  Future<List<OrderModel>> getOrdersSupplier(String uid) async {
    List<OrderModel> orders = [];
    try {
      QuerySnapshot query = await _db
          .collection('orders')
          .where('suppliers', arrayContains: uid)
          .orderBy('date', descending: true)
          .get();
      query.docs.forEach((element) {
        OrderModel order = OrderModel.fromFirestore(element);
        orders.add(order);
      });
      return orders;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<OrderModel>> getOrdersClient(String uid) async {
    List<OrderModel> orders = [];
    try {
      QuerySnapshot query = await _db
          .collection('orders')
          .where('client', isEqualTo: uid)
          .orderBy('date', descending: true)
          .get();
      query.docs.forEach((element) {
        OrderModel order = OrderModel.fromFirestore(element);
        orders.add(order);
      });
      return orders;
    } catch (e) {
      throw e.toString();
    }
  }
}
