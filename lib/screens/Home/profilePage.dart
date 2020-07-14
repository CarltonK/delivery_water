import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:water_del/models/singleAddress.dart';
import 'package:water_del/models/userModel.dart';
import 'package:water_del/provider/database_provider.dart';
import 'package:water_del/screens/home/orderhistory.dart';
import 'package:water_del/utilities/global/dialogs.dart';
import 'package:water_del/utilities/global/pageTransitions.dart';
import 'package:water_del/utilities/styles.dart';
import 'package:water_del/widgets/setAddressWidget.dart';
import 'package:water_del/widgets/setPhoneWidget.dart';

class ProfilePage extends StatefulWidget {
  final FirebaseUser user;
  ProfilePage({@required this.user});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String url = 'assets/images/background.jpg';

  PageController _controller;
  DatabaseProvider _databaseProvider = DatabaseProvider();
  UserModel currentUser;

  Future addressFuture;

  Widget _backButton(BuildContext context) {
    return Positioned(
      top: 30,
      left: 10,
      child: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }



  Widget _exitButton(BuildContext context) {
    return Positioned(
      top: 30,
      right: 10,
      child: IconButton(
          tooltip: 'Logout',
          icon: Icon(
            Icons.exit_to_app,
            color: Colors.white,
          ),
          onPressed: () => logoutPopUp(context)),
    );
  }

  Widget _imageBackground(Size size) {
    return Container(
      height: size.height * 0.3,
      width: size.width,
      child: ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.grey[600], BlendMode.colorBurn),
          child: Image.asset(url, fit: BoxFit.fill)),
    );
  }

  Widget _singleAddress(SingleAddress add) {
    return Card(
      elevation: 3,
      child: ListTile(
        title: Text(
          add.region,
          style: boldOutlineBlack,
        ),
        dense: false,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              add.town,
              style: normalOutlineBlack,
            ),
            Text(
              add.address,
              style: normalOutlineBlack,
            ),
          ],
        ),
        isThreeLine: true,
        trailing: IconButton(
          icon: Icon(
            Icons.edit_location,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () => print('I want to edit this address'),
        ),
      ),
    );
  }

  Widget _addressSection(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Delivery Address',
              style: boldOutlineBlack,
            ),
            IconButton(
              icon: Icon(Icons.add_location),
              onPressed: () => showCupertinoModalPopup(
                context: context,
                builder: (context) => SetAddress(
                  user: widget.user,
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: size.height * 0.1,
          width: double.infinity,
          child: FutureBuilder<List<SingleAddress>>(
            future: addressFuture,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return PageView.builder(
                    controller: _controller,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      SingleAddress address = snapshot.data[index];
                      return _singleAddress(address);
                    },
                  );
                case ConnectionState.waiting:
                  return SpinKitChasingDots(
                    size: (size.height * 0.1) / 2,
                    color: Theme.of(context).primaryColor,
                  );
                case ConnectionState.active:
                case ConnectionState.none:
                  return Text(
                    'Press the button above to create an address',
                    style: normalOutlineBlack,
                  );
                default:
                  return SpinKitChasingDots(
                    size: (size.height * 0.1) / 2,
                    color: Theme.of(context).primaryColor,
                  );
              }
            },
          ),
        )
      ],
    );
  }

  Widget _pageBody(Size size) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        height: size.height * 0.7,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: size.height * 0.18,
            ),
            currentUser.clientStatus ? _addressSection(size) : Container()
          ],
        ),
      ),
    );
  }

  Widget _userPersonalInfo() {
    return Column(
      children: [
        Text(
          currentUser.fullName ?? '',
          style: headerOutlineBlack,
          textAlign: TextAlign.center,
        ),
        Text(
          currentUser.email,
          style: normalOutlineBlack,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          currentUser.phone ?? '',
          style: boldOutlineBlack,
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget _userImpactInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FlatButton(
          onPressed: () => print('I want to view my ratings'),
          padding: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              Text(
                currentUser.ratingCount.toStringAsFixed(1),
                style: boldOutlineBlack,
              ),
              Text(
                'Rating',
                style: normalOutlineBlack,
              )
            ],
          ),
        ),
        FlatButton(
          onPressed: () => currentUser.orderCount > 0
              ? Navigator.of(context)
                  .push(SlideLeftTransition(page: OrderHistory()))
              : dialogInfo(context, 'You have no previous orders'),
          padding: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              Text(
                currentUser.orderCount.toString(),
                style: boldOutlineBlack,
              ),
              Text(
                'Orders',
                style: normalOutlineBlack,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _cardUser(Size size) {
    return Positioned(
      top: size.height * 0.15,
      right: 20,
      left: 20,
      child: Align(
        alignment: Alignment.center,
        child: Card(
          elevation: 15,
          child: Container(
            height: size.height * 0.3,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                _userPersonalInfo(),
                _userImpactInfo()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _userDp(Size size) {
    String url = currentUser.photoUrl;
    return Positioned(
      top: size.height * 0.075,
      left: size.width * 0.35,
      right: size.width * 0.35,
      child: CircleAvatar(
        backgroundImage: url != null ? NetworkImage(url) : null,
        child: url == null
            ? IconButton(
                icon: Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: null)
            : Container(),
        radius: size.width * 0.14,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0, viewportFraction: 0.9);
    addressFuture = _databaseProvider.getAddresses(widget.user.uid);
    Future.delayed(Duration(seconds: 2), () {
      currentUser.phone == null ? promptAddPhone() : Container();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future promptAddPhone() {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) => SetPhoneWidget(user: widget.user),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          height: size.height,
          width: size.width,
          child: StreamBuilder<UserModel>(
            stream: _databaseProvider.streamUser(widget.user.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                currentUser = snapshot.data;
                // print(currentUser.toFirestore());
                return Stack(
                  children: <Widget>[
                    _imageBackground(size),
                    _backButton(context),
                    _exitButton(context),
                    _pageBody(size),
                    _cardUser(size),
                    _userDp(size)
                  ],
                );
              }
              return SpinKitDoubleBounce(
                color: Theme.of(context).primaryColor,
                size: 150,
              );
            },
          )),
    );
  }
}
