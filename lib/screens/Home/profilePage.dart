import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {

  final String url = 'https://images.unsplash.com/photo-1494959764136-6be9eb3c261e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80';
  final String urlUser = 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80';

  Widget _backButton(BuildContext context) {
    return Positioned(
      top: 30,
      left: 10,
      child: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,color: Colors.white,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _imageBackground(Size size) {
    return Container(
      height: size.height * 0.3,
      width: size.width,
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(Colors.grey[100], BlendMode.colorBurn),
        child: Image.network(url, fit: BoxFit.fill)
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
          elevation: 12,
          child: Container(
            height: size.height * 0.3,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: 5,),
                Text('Mark Carlton'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text('4.3'),
                        Text('Rating')
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text('2'),
                        Text('Reviews')
                      ],
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
            _pageBody(size),
            _cardUser(size),
            _userDp(size)
          ],
        ),
      ),
    );
  }
}
