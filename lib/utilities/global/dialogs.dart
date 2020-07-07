import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:water_del/widgets/global/custome_info_dialog.dart';

Future dialogInfo(BuildContext context, String message) {
  return showCupertinoModalPopup(
    context: context,
    builder: (context) => AlertDialog(
      content: InfoDialog(message: message),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}
