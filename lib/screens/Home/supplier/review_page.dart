import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:water_del/models/models.dart';
import 'package:water_del/provider/provider.dart';
import 'package:water_del/utilities/utilities.dart';

class ReviewPage extends StatefulWidget {
  final auth.User user;
  ReviewPage({@required this.user});

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  DatabaseProvider database = DatabaseProvider();
  Future reviewsFuture;

  Widget listItem(ReviewModel review) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 1,
      child: ListTile(
        leading: Icon(Icons.sort),
        title: Text(
          review.title,
          style: boldOutlineBlack,
        ),
        isThreeLine: true,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              review.description,
              style: normalOutlineBlack,
            ),
            Text(
              'Time goes here',
              style: normalOutlineBlack,
            ),
          ],
        ),
      ),
    );
  }

  Widget reviewsBodyBuilder(Size size) {
    return FutureBuilder<List<ReviewModel>>(
      future: reviewsFuture,
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
              'You have not received any review(s)',
              style: normalOutlineBlack,
              textAlign: TextAlign.center,
            ));
          case ConnectionState.done:
            if (snapshot.data.length == 0)
              return Center(
                  child: Text(
                'You have not received any review(s)',
                style: normalOutlineBlack,
                textAlign: TextAlign.center,
              ));
            return ListView.separated(
              itemCount: snapshot.data.length,
              addAutomaticKeepAlives: false,
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              itemBuilder: (context, index) {
                return listItem(snapshot.data[index]);
              },
            );
          default:
            return SpinKitFadingCircle(
              color: Theme.of(context).primaryColor,
              size: size.height / 4,
            );
        }
      },
    );
  }

  @override
  void initState() {
    reviewsFuture = database.getReviews(widget.user.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: reviewsBodyBuilder(size),
    );
  }
}
