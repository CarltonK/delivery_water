import 'package:flutter/material.dart';

class SocialButtons extends StatelessWidget {
  //Social Buttons
  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      child: Row(
        children: <Widget>[
          _buildSocialBtn(
            () {},
            AssetImage(
              'assets/logos/facebook.jpg',
            ),
          ),
          SizedBox(
            width: 10,
          ),
          _buildSocialBtn(
            () {},
            AssetImage(
              'assets/logos/google.png',
            ),
          ),
        ],
      ),
    );
  }
}
