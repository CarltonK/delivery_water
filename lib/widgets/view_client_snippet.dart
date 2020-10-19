import 'package:flutter/material.dart';
import 'package:water_del/models/userModel.dart';
import 'package:water_del/utilities/styles.dart';

class ClientSnippet extends StatelessWidget {
  final UserModel user;
  ClientSnippet({@required this.user});

  Widget _userDp() {
    String url = user.photoUrl;
    return CircleAvatar(
      backgroundImage: url != null ? NetworkImage(url) : null,
      radius: 60,
    );
  }

  Widget _userPersonalInfo() {
    return Column(
      children: [
        SizedBox(
          height: 8,
        ),
        Text(
          user.fullName ?? '',
          style: headerOutlineBlack,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 5,
        ),
        // Text(
        //   user.phone ?? '',
        //   style: boldOutlineBlack,
        //   textAlign: TextAlign.center,
        // )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _userDp(),
          SizedBox(
            height: 10,
          ),
          _userPersonalInfo()
        ],
      ),
    );
  }
}
