import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:water_del/models/userModel.dart';
import 'package:water_del/provider/auth_provider.dart';
import 'package:water_del/utilities/global/dialogs.dart';
import 'package:water_del/utilities/styles.dart';

class ResetPassword extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  static String email;

  static dynamic result;

  void handleEmail(String value) {
    email = value.trim();
    print('Email -> $email');
  }

  Widget _resetEmailField(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        textInputAction: TextInputAction.done,
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
        onSaved: handleEmail,
        onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
      ),
    );
  }

  Future<bool> serverCall(UserModel user) async {
    result = await AuthProvider.instance().resetPass(user);
    print('This is the result: $result');

    if (result == "Please register first") {
      return false;
    } else if (result == "Invalid Email. Please enter the correct email") {
      return false;
    } else {
      return true;
    }
  }

  resetBtnPressed(BuildContext context) {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();

      UserModel user = new UserModel(email: email);
      serverCall(user).then((value) {
        if (value) {
          dialogInfo(context, 'Please check your inbox');
        } else {
          dialogInfo(context, result);
        }
      }).catchError((error) {
        dialogInfo(context, error.toString());
      });
    }
  }

  Widget _resetBtn(BuildContext context) {
    return Container(
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
        onPressed: () => resetBtnPressed(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => AuthProvider.instance(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black54,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          backgroundColor: Colors.white,
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Container(
              height: size.height,
              width: size.width,
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey[200]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Enter the email address associated with your account',
                      style: normalOutlineBlack,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    _resetEmailField(context),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: _resetBtn(context)),
    );
  }
}
