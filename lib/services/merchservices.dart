    // collection reference
  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:water_del/models/MerchantModel.dart';


class DatabaseService {

final CollectionReference collectionReference = FirebaseFirestore.instance.collection('merchants');


  Merchant _merchantfromSnapshot(DocumentSnapshot snapshot) {
    return
    Merchant(
      shopName: snapshot['shopName'],
      address: snapshot['address'],
      description: snapshot['description'],
      thumbNail: snapshot['thumbNail'],
      locationCoords: snapshot['locationCoords'],

    );
  }

    
  // get merch doc stream
  Stream<Merchant> get merchantData {
    return collectionReference.doc().snapshots()
      .map(_merchantfromSnapshot);
  }


}