import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:water_del/widgets/global/custom_progress_dialog.dart';
import 'package:water_del/widgets/global/custome_info_dialog.dart';
import 'package:water_del/widgets/global/exit_dialog.dart';

Future dialogInfo(BuildContext context, String message) {
  return showCupertinoModalPopup(
    context: context,
    builder: (context) => AlertDialog(
      content: InfoDialog(message: message),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}

Future dialogLoading(BuildContext context, String message) {
  return showCupertinoModalPopup(
    context: context,
    builder: (context) => AlertDialog(
      content: CustomProgressDialog(message: message),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}

Future logoutPopUp(BuildContext context) {
  return showCupertinoModalPopup(
    context: context,
    builder: (context) => ExitDialog(),
  );
}
