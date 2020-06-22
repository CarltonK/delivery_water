import 'package:flutter/material.dart';
import 'package:water_del/screens/Authentication/reset_password.dart';
import 'package:water_del/utilities/global/social_buttons.dart';
import 'package:water_del/utilities/styles.dart';

class LoginPage extends StatelessWidget {
  Widget _introText() {
    return Text(
      'Welcome',
      style: headerOutlineBlack,
    );
  }

  Widget _loginEmailField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please provide an email address';
        }
        if (!value.contains('@') || !value.contains('.')) {
          return 'Please provide a valid email address';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Email address'),
    );
  }

  Widget _loginPasswordField() {
    return TextFormField(
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please provide a password';
        }
        if (value.length < 7) {
          return 'Password is too short';
        }
        return null;
      },
      obscureText: true,
      decoration: InputDecoration(labelText: 'Password'),
    );
  }

  Widget _loginButton() {
    return Positioned(
        bottom: 20,
        right: 15,
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.blueAccent[200].withOpacity(0.7)),
          child: IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
            onPressed: () => print('I want to login now'),
          ),
        ));
  }

  Widget _forgotPasswordButton(BuildContext context) {
    return Positioned(
        bottom: 20,
        child: FlatButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ResetPassword())),
            child: Text(
              'Forgot Password ?',
              style: normalOutlineBlack,
            )));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            height: size.height,
            width: size.width,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 60,
                ),
                _introText(),
                SizedBox(
                  height: 50,
                ),
                _loginEmailField(),
                SizedBox(
                  height: 20,
                ),
                _loginPasswordField(),
                SocialButtons()
              ],
            ),
          ),
          _forgotPasswordButton(context),
          _loginButton()
        ],
      ),
    );
  }
}
