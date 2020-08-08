import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:water_del/models/locationModel.dart';
import 'package:water_del/models/product.dart';
import 'package:water_del/models/reviewModel.dart';
import 'package:water_del/models/singleAddress.dart';
import 'package:water_del/models/userModel.dart';

class DatabaseProvider {
  final Firestore _db = Firestore.instance;
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
      await _db.collection("users").document(uid).setData(user.toFirestore());
    } catch (e) {
      print("saveUser ERROR -> ${e.toString()}");
    }
  }

  Future<void> setLastLogin(String uid, Timestamp now) async {
    await _db.collection('users').document(uid).updateData(
      {'lastLogin': now},
    );
  }

  Future<UserModel> getUser(String uid) async {
    var snap = await _db.collection('users').document(uid).get();
    return UserModel.fromFirestore(snap);
  }

  Stream<UserModel> streamUser(String uid) {
    return _db
        .collection('users')
        .document(uid)
        .snapshots()
        .map((event) => UserModel.fromFirestore(event));
  }

  Future<void> setAddress(String uid, SingleAddress address) async {
    await _db
        .collection('users')
        .document(uid)
        .collection('addresses')
        .document()
        .setData(address.toFirestore());
  }

  Future<List<SingleAddress>> getAddresses(String uid) async {
    try {
      QuerySnapshot snapshotAddresses = await _db
          .collection('users')
          .document(uid)
          .collection('addresses')
          .orderBy('defaultAddress', descending: true)
          .getDocuments();
      List<SingleAddress> addresses = [];
      snapshotAddresses.documents.forEach((element) {
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
    await _db
        .collection('users')
        .document(uid)
        .updateData({'location': model.toFirestore()});
  }

  Future<void> updatePhoneandStatus(
      String uid, String phone, String natId, bool status) async {
    await _db
        .collection('users')
        .document(uid)
        .updateData({'phone': phone, 'clientStatus': status, 'natID': natId});
  }

  Future<void> postProduct(String uid, Product product) async {
    try {
      await _db
          .collection('users')
          .document(uid)
          .collection('products')
          .document()
          .setData(product.toJson());
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Product>> getProducts(String uid) async {
    try {
      List<Product> queryData = [];
      QuerySnapshot snapshot = await _db
          .collectionGroup('products')
          .where('supplier', isEqualTo: uid)
          .orderBy('price', descending: true)
          .getDocuments();
      snapshot.documents.forEach((element) {
        Product product = Product.fromJson(element.data);
        queryData.add(product);
      });
      return Future.value(queryData);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<ReviewModel>> getReviews(String uid) async {
    try {
      List<ReviewModel> reviews = [];
      QuerySnapshot snapshot = await _db
          .collection('reviews')
          .where('supplier', isEqualTo: uid)
          .orderBy('time', descending: true)
          .getDocuments();
      snapshot.documents.forEach((element) {
        ReviewModel review = ReviewModel.fromFirestore(element);
        reviews.add(review);
      });
      return Future.value(reviews);
    } catch (e) {
      throw e.toString();
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
            .getDocuments();
        snapshot.documents.forEach((element) {
          Product product = Product.fromJson(element.data);
          products.add(product);
        });
        return products;
      } catch (e) {
        throw e.toString();
      }
    }
    return null;
  }

  Future<void> uploadDP(String uid, String dp) async {
    try {
      await _db.collection('users').document(uid).updateData({'photoUrl': dp});
    } catch (e) {
      throw e.toString();
    }
  }
}
