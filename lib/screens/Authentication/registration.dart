import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_del/models/userModel.dart';
import 'package:water_del/provider/auth_provider.dart';
import 'package:water_del/utilities/global/dialogs.dart';
import 'package:water_del/utilities/global/social_buttons.dart';
import 'package:water_del/utilities/styles.dart';

class SignUpPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _focusPassword = FocusNode();
  final FocusNode _focusPassword2 = FocusNode();

  static TextEditingController passwording = TextEditingController();
  static TextEditingController confirmPass = TextEditingController();

  static String email;
  static String password;
  static String password2;

  static dynamic result;

  static dynamic userProvider;

  void handleEmail(String value) {
    email = value.trim();
    print('Email -> $email');
  }

  void handlePassword(String value) {
    password = value.trim();
    print('Password -> $password');
  }

  void handlePassword2(String value) {
    password2 = value.trim();
    print('Password(2) -> $password2');
  }

  Widget _introText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Hello,',
          style: headerOutlineBlack,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Enter your information below\nor login with a social account',
          style: normalOutlineBlack,
        )
      ],
    );
  }

  Widget _registerEmailField(BuildContext context) {
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

  Widget _registerPasswordField(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
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
      focusNode: _focusPassword,
      controller: passwording,
      obscureText: true,
      onFieldSubmitted: (value) =>
          FocusScope.of(context).requestFocus(_focusPassword2),
      onSaved: handlePassword,
      decoration: InputDecoration(labelText: 'Password'),
    );
  }

  Widget _registerPasswordField2(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value != passwording.text) {
          return 'Passwords do not match';
        }
        return null;
      },
      focusNode: _focusPassword2,
      obscureText: true,
      controller: confirmPass,
      onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
      onSaved: handlePassword2,
      decoration: InputDecoration(labelText: 'Confirm Password'),
    );
  }

  Future<bool> serverCall(UserModel user) async {
    result = await userProvider.createUserEmailPass(user);
    print('This is the result: $result');

    if (result == 'Your password is weak. Please choose another') {
      return false;
    } else if (result == "The email format entered is invalid") {
      return false;
    } else if (result == "An account with the same email exists") {
      return false;
    } else if (result == null) {
      result = "Please check your internet connection";
      return false;
    } else {
      return true;
    }
  }

  void _registerBtnPressed(BuildContext context) async {
    // Navigator.of(context).push(SlideRightTransition(page: PreLogin()));
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
        dialogInfo(context, error.toString());
      });
    }
  }

  Widget _registerButton(BuildContext context) {
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
                  onPressed: () => _registerBtnPressed(context),
                ),
              ));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    userProvider = Provider.of<AuthProvider>(context);
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
                  _registerEmailField(context),
                  SizedBox(
                    height: 20,
                  ),
                  _registerPasswordField(context),
                  SizedBox(
                    height: 20,
                  ),
                  _registerPasswordField2(context),
                  SocialButtons()
                ],
              ),
            ),
          ),
          _registerButton(context)
        ],
      ),
    );
  }
}
