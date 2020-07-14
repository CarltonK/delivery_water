import 'package:flutter/material.dart';
import 'package:water_del/provider/auth_provider.dart';
import 'package:water_del/utilities/styles.dart';

class ExitDialog extends StatelessWidget {
  Widget noExit(BuildContext context) {
    return FlatButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(
          'NO',
          style: boldOutlineRed,
        ));
  }

  Widget yesExit(BuildContext context) {
    return FlatButton(
        onPressed: () {
          AuthProvider.instance().logout();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        child: Text(
          'YES',
          style: boldOutlineGreen,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'EXIT',
        style: headerOutlineBlack,
        textAlign: TextAlign.center,
      ),
      content: Text(
        'Are you sure ?',
        style: headerOutlineBlack,
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      actions: [noExit(context), yesExit(context)],
    );
  }
}
