// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// class Merchant {
//   String shopName;
//   String address;
//   String description;
//   String thumbNail;
//   LatLng locationCoords;

//   Merchant( 
//       {this.shopName,
//       this.address,
//       this.description,
//       this.thumbNail,
//       this.locationCoords});

//   //       populateClients() {
//   //  List clients = [];
//   //   FirebaseFirestore.instance.collection('markers').get().then((thisdoc) {
//   //     if (thisdoc.docs.isNotEmpty) {
//   //       setState(() {
//   //         clientsToggle = true;
//   //       });
//   //       for (int i = 0; i < thisdoc.documents.length; ++i) {
//   //         clients.add(thisdoc.documents[i].data);
//   //         initMarker(thisdoc.documents[i].data);
//   //       }
//   //     }
//   //   });
//   // }
// }

// final List<Merchant> merchant = [
//   Merchant(
//       shopName: 'Stumptown Merchant Roasters',
//       address: '18 W 29th St',
//       description:
//           'Merchant bar chain offering house-roasted direct-trade Merchant, along with brewing gear & whole beans',
//       locationCoords: LatLng(-1.2031673, 36.9173212),
//       thumbNail: 'https://lh5.googleusercontent.com/p/AF1QipNNzoa4RVMeOisc0vQ5m3Z7aKet5353lu0Aah0a=w90-h90-n-k-no'
//       ),
//   Merchant(
//       shopName: 'Andrews Merchant Shop',
//       address: '463 7th Ave',
//       description:
//           'All-day American comfort eats in a basic diner-style setting',
//       locationCoords: LatLng(-1.19167318, 36.91020012),
//       thumbNail: 'https://lh5.googleusercontent.com/p/AF1QipOfv3DSTkjsgvwCsUe_flDr4DBXneEVR1hWQCvR=w90-h90-n-k-no'
//       ),
//   Merchant(
//       shopName: 'Third Rail Merchant',
//       address: '240 Sullivan St',
//       description:
//           'Small spot draws serious caffeine lovers with wide selection of brews & baked goods.',
//       locationCoords: LatLng(-1.20969367, 36.91088676),
//       thumbNail: 'https://lh5.googleusercontent.com/p/AF1QipPGoxAP7eK6C44vSIx4SdhXdp78qiZz2qKp8-o1=w90-h90-n-k-no'
//       ),
//   // Merchant(
//   //     shopName: 'Hi-Collar',
//   //     address: '214 E 10th St',
//   //     description:
//   //         'Snazzy, compact Japanese cafe showcasing high-end Merchant & sandwiches, plus sake & beer at night.',
//   //     locationCoords: LatLng(40.729515, -73.985927),
//   //     thumbNail: 'https://lh5.googleusercontent.com/p/AF1QipNhygtMc1wNzN4n6txZLzIhgJ-QZ044R4axyFZX=w90-h90-n-k-no'
//   //     ),
//   // Merchant(
//   //     shopName: 'Everyman Espresso',
//   //     address: '301 W Broadway',
//   //     description:
//   //         'Compact Merchant & espresso bar turning out drinks made from direct-trade beans in a low-key setting.',
//   //     locationCoords: LatLng(40.721622, -74.004308),
//   //     thumbNail: 'https://lh5.googleusercontent.com/p/AF1QipOMNvnrTlesBJwUcVVFBqVF-KnMVlJMi7_uU6lZ=w90-h90-n-k-no'
//   //     )
// ];
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Merchant {
  String shopName;
  String address;
  String description;
  String thumbNail;
  LatLng locationCoords;

  Merchant( 
      {this.shopName,
      this.address,
      this.description,
      this.thumbNail,
      this.locationCoords});
}

final List<Merchant> merchant = [
  Merchant(
      shopName: 'Water Delivery',
      address: 'Kahawa',
      description:
          'Ksh 40',
      locationCoords: LatLng(-1.2031673, 36.9173212),
      thumbNail: 'https://firebasestorage.googleapis.com/v0/b/naqua-1b2bb.appspot.com/o/assets%2Fbottledwater.png?alt=media&token=b98e398b-ddab-4465-9499-2589255375e3'
      ),
  Merchant(
      shopName: 'Bottled Water',
      address: 'Kahawa West',
      description:
          'Ksh 380',
      locationCoords: LatLng(-1.19167318, 36.91020012),
      thumbNail: 'https://firebasestorage.googleapis.com/v0/b/naqua-1b2bb.appspot.com/o/assets%2Fbottled.png?alt=media&token=270e08f6-ef64-4ebc-ac18-f88dbf8d6e0c'
      ),
  Merchant(
      shopName: 'Exhauster Services',
      address: 'Roysambu',
      description:
          'Ksh 5000',
      locationCoords: LatLng(-1.20969367, 36.91088676),
      thumbNail: 'https://firebasestorage.googleapis.com/v0/b/naqua-1b2bb.appspot.com/o/assets%2Fexhauster.png?alt=media&token=cd1eac55-600f-4076-b9a7-c487b4f57474'
      ),
  // Merchant(
  //     shopName: 'Hi-Collar',
  //     address: '214 E 10th St',
  //     description:
  //         'Snazzy, compact Japanese cafe showcasing high-end Merchant & sandwiches, plus sake & beer at night.',
  //     locationCoords: LatLng(40.729515, -73.985927),
  //     thumbNail: 'https://lh5.googleusercontent.com/p/AF1QipNhygtMc1wNzN4n6txZLzIhgJ-QZ044R4axyFZX=w90-h90-n-k-no'
  //     ),
  // Merchant(
  //     shopName: 'Everyman Espresso',
  //     address: '301 W Broadway',
  //     description:
  //         'Compact Merchant & espresso bar turning out drinks made from direct-trade beans in a low-key setting.',
  //     locationCoords: LatLng(40.721622, -74.004308),
  //     thumbNail: 'https://lh5.googleusercontent.com/p/AF1QipOMNvnrTlesBJwUcVVFBqVF-KnMVlJMi7_uU6lZ=w90-h90-n-k-no'
  //     )
];