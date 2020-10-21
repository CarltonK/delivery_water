import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:water_del/models/singleAddress.dart';
import 'package:water_del/provider/database_provider.dart';
import 'package:water_del/utilities/global/dialogs.dart';
import 'package:water_del/utilities/styles.dart';

class SetAddress extends StatefulWidget {
  final auth.User user;
  SetAddress({@required this.user});
  @override
  _SetAddressState createState() => _SetAddressState();
}

class _SetAddressState extends State<SetAddress> {
  final FocusNode _focusInfo = FocusNode();

  final _formKey = GlobalKey<FormState>();

  static String _region;
  static String _town;
  static String _address;
  static String _addInfo;

  bool _isdefault = false;

  final DatabaseProvider _db = DatabaseProvider();

  handleAddress(String value) {
    _address = value.trim();
    print('Address -> $_address');
  }

  handleInfo(String value) {
    _addInfo = value.trim();
    print('Additional Information -> $_addInfo');
  }

  String validateAddress(String value) {
    if (value.isEmpty) {
      return 'Please provide an address';
    }
    return null;
  }

  Widget _cancelButton() {
    return FlatButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(
          'CANCEL',
          style: boldOutlineRed,
        ));
  }

  void setAddressBtnPressed() {
    final FormState form = _formKey.currentState;
    if (_region == null) {
      dialogInfo(context, 'Please select a region');
    }
    if (_town == null) {
      dialogInfo(context, 'Please select a town');
    }
    if (form.validate()) {
      form.save();

      SingleAddress singleAddress = new SingleAddress(
          additionalinfo: _addInfo,
          address: _address,
          uid: widget.user.uid,
          defaultAddress: _isdefault,
          town: _town,
          region: _region);

      _db.setAddress(widget.user.uid, singleAddress).then((value) {
        Navigator.of(context).pop();
        dialogInfo(context, 'Your address has been set successfully');
      }).catchError((error) {
        Navigator.of(context).pop();
        dialogInfo(context, error.toString());
      });
    }
  }

  Widget _addButton() {
    return FlatButton(
        onPressed: setAddressBtnPressed,
        child: Text(
          'SET',
          style: boldOutlineGreen,
        ));
  }

  Widget _regionDropdown() {
    return DropdownButton(
      isExpanded: true,
      value: _region,
      icon: Icon(
        Icons.arrow_downward,
        size: 18,
      ),
      hint: Text(
        'Region',
        style: normalOutlineBlack,
      ),
      items: [
        DropdownMenuItem(
            value: 'Nairobi',
            child: Text(
              'Nairobi',
              style: normalOutlineBlack,
            ))
      ],
      onChanged: (value) {
        setState(() {
          _region = value;
        });
      },
    );
  }

  Widget _townDropdown() {
    return DropdownButton(
      isExpanded: true,
      value: _town,
      icon: Icon(
        Icons.arrow_downward,
        size: 18,
      ),
      hint: Text(
        'Town',
        style: normalOutlineBlack,
      ),
      items: [
        DropdownMenuItem(
            value: 'Westlands',
            child: Text(
              'Westlands',
              style: normalOutlineBlack,
            ))
      ],
      onChanged: (value) {
        setState(() {
          _town = value;
        });
      },
    );
  }

  Widget _addressField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      validator: validateAddress,
      onSaved: handleAddress,
      onFieldSubmitted: (value) =>
          FocusScope.of(context).requestFocus(_focusInfo),
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Address',
          labelStyle: normalOutlineBlack),
    );
  }

  Widget _infoField() {
    return TextFormField(
      focusNode: _focusInfo,
      onSaved: handleInfo,
      onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Additional Information',
          labelStyle: normalOutlineBlack),
    );
  }

  Widget _setDefaultAddress() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Default',
          style: normalOutlineBlack,
        ),
        Checkbox(
          value: _isdefault,
          onChanged: (value) {
            setState(() {
              _isdefault = value;
            });
          },
        )
      ],
    );
  }

  @override
  void dispose() {
    _focusInfo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _regionDropdown(),
              SizedBox(
                height: 10,
              ),
              _townDropdown(),
              SizedBox(
                height: 10,
              ),
              _addressField(),
              SizedBox(
                height: 10,
              ),
              _infoField(),
              SizedBox(
                height: 10,
              ),
              _setDefaultAddress()
            ],
          ),
        ),
      ),
      actions: [
        _cancelButton(),
        _addButton(),
      ],
    );
  }
}
