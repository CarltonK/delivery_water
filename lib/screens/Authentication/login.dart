import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_del/models/userModel.dart';
import 'package:water_del/provider/auth_provider.dart';
import 'package:water_del/screens/authentication/reset_password.dart';
import 'package:water_del/utilities/global/dialogs.dart';
import 'package:water_del/utilities/global/pageTransitions.dart';
import 'package:water_del/utilities/global/social_buttons.dart';
import 'package:water_del/utilities/styles.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _focusPassword = FocusNode();

  static String email;
  static String password;

  static dynamic result;
  static dynamic resultReset;

  static dynamic userProvider;

  void handleEmail(String value) {
    email = value.trim();
    print('Email -> $email');
  }

  void handlePassword(String value) {
    password = value.trim();
    print('Password -> $password');
  }

  Widget _introText() {
    return Text(
      'Welcome',
      style: headerOutlineBlack,
    );
  }

  Widget _loginEmailField(BuildContext context) {
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
      onFieldSubmitted: (value) =>
          FocusScope.of(context).requestFocus(_focusPassword),
      onSaved: handleEmail,
    );
  }

  Widget _loginPasswordField(BuildContext context) {
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
      onSaved: handlePassword,
      focusNode: _focusPassword,
      obscureText: true,
      onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(labelText: 'Password'),
    );
  }

  Future<bool> serverCall(UserModel user) async {
    result = await userProvider.signInEmailPass(user);
    print('This is the result: $result');

    if (result == 'Invalid credentials. Please try again') {
      return false;
    } else if (result == "The email format entered is invalid") {
      return false;
    } else if (result == "Please register first") {
      return false;
    } else if (result == "Your account has been disabled") {
      return false;
    } else if (result == "Too many requests. Please try again in 2 minutes") {
      return false;
    } else if (result ==
        "Please verify your email. We sent you an email earlier") {
      return false;
    } else {
      return true;
    }
  }

  void _loginBtnPressed(BuildContext context) {
    // Navigator.of(context).push(SlideRightTransition(page: HomeMain()));
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();

      UserModel user = new UserModel(email: email, password: password);
      serverCall(user).then((value) {
        if (value) {
          print(value);
        } else {
          dialogInfo(context, result);
        }
      }).catchError((error) {
        print(error);
        dialogInfo(context, error.toString());
      });
    }
  }

  Widget _loginButton(BuildContext context) {
    return Positioned(
        bottom: 20,
        right: 15,
        child: userProvider.status == Status.Authenticating
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ))
            : Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).primaryColor),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  onPressed: () => _loginBtnPressed(context),
                ),
              ));
  }

  Future<bool> serverCallReset(UserModel user) async {
    resultReset = await userProvider.resetPass(user);
    print('This is the result: $resultReset');

    if (resultReset == "Please register first") {
      return false;
    } else if (resultReset == "Invalid Email. Please enter the correct email") {
      return false;
    } else {
      return true;
    }
  }

  Widget _forgotPasswordButton(BuildContext context) {
    return Positioned(
        bottom: 20,
        child: FlatButton(
            onPressed: () {
              Navigator.of(context)
                  .push(SlideRightTransition(page: ResetPassword()));
            },
            child: Text(
              'Forgot Password ?',
              style: normalOutlineBlack,
            )));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<AuthProvider>(
      builder: (context, AuthProvider value, child) {
        userProvider = value;
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                height: size.height,
                width: size.width,
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      SizedBox(
                        height: 60,
                      ),
                      _introText(),
                      SizedBox(
                        height: 50,
                      ),
                      _loginEmailField(context),
                      SizedBox(
                        height: 20,
                      ),
                      _loginPasswordField(context),
                      SocialButtons()
                    ],
                  ),
                ),
              ),
              _forgotPasswordButton(context),
              _loginButton(context)
            ],
          ),
        );
      },
    );
  }
}
