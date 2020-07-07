import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_del/provider/auth_provider.dart';
import 'package:water_del/screens/home/orderhistory.dart';
import 'package:water_del/utilities/global/pageTransitions.dart';
import 'package:water_del/utilities/styles.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String url =
      'https://images.unsplash.com/photo-1494959764136-6be9eb3c261e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80';

  final String urlUser =
      'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80';

  PageController _controller;

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
        onPressed: () {
          AuthProvider.instance().logout();
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget _imageBackground(Size size) {
    return Container(
      height: size.height * 0.3,
      width: size.width,
      child: ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.grey[100], BlendMode.colorBurn),
          child: Image.network(url, fit: BoxFit.fill)),
    );
  }

  Widget _singleAddress(int index) {
    return Card(
      elevation: 3,
      child: ListTile(
        title: Text('Address'),
        dense: false,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('More details'),
            Text('Even more details'),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Delivery Address',
                  style: boldOutlineBlack,
                ),
                IconButton(
                  icon: Icon(Icons.add_location),
                  onPressed: () => print('I want to add an address'),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: size.height * 0.2,
              width: double.infinity,
              child: PageView.builder(
                controller: _controller,
                itemBuilder: (context, index) => _singleAddress(index),
              ),
            )
          ],
        ),
      ),
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
                  height: 5,
                ),
                Text(
                  'Mark Carlton',
                  style: headerOutlineBlack,
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () => print('I want to view my ratings'),
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: <Widget>[
                          Text(
                            '4.3',
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
                      onPressed: () => Navigator.of(context)
                          .push(SlideLeftTransition(page: OrderHistory())),
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: <Widget>[
                          Text(
                            '2',
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _userDp(Size size) {
    return Positioned(
      top: size.height * 0.075,
      left: size.width * 0.35,
      right: size.width * 0.35,
      child: CircleAvatar(
        backgroundImage: NetworkImage(urlUser),
        radius: size.width * 0.14,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0, viewportFraction: 0.9);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(
          children: <Widget>[
            _imageBackground(size),
            _backButton(context),
            _exitButton(context),
            _pageBody(size),
            _cardUser(size),
            _userDp(size)
          ],
        ),
      ),
    );
  }
}
