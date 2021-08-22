import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water_del/widgets/alertdialogue.dart';

class AddproductWidget extends StatefulWidget {
  AddproductWidget({Key key}) : super(key: key);

  @override
  _AddproductWidgetState createState() => _AddproductWidgetState();
}

class _AddproductWidgetState extends State<AddproductWidget> {
  String dropDownValue = 'Available';
  TextEditingController textController1;
  TextEditingController textController2;
  TextEditingController textController3;

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController(text: 'Ksh');
    textController3 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: Alignment(0, 0),
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Text(
                'Update Products',
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: Alignment(-0.95, 0),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                  child: Text(
                    'Name',
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
              ),
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Color(0xFFCFCFCF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: TextFormField(
                    onChanged: (_) => setState(() {}),
                    controller: textController1,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Product name',
                      labelStyle: TextStyle(
                        fontFamily: 'Ubuntu',
                      ),
                      hintText: 'e.g water bottle',
                      hintStyle: TextStyle(
                        fontFamily: 'Ubuntu',
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      suffixIcon: textController1.text.isNotEmpty
                          ? InkWell(
                              onTap: () => setState(
                                () => textController1.clear(),
                              ),
                              child: Icon(
                                Icons.clear,
                                color: Color(0xFF757575),
                                size: 22,
                              ),
                            )
                          : null,
                    ),
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
              )
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: Alignment(-0.95, 0),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                  child: Text(
                    'Price',
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
              ),
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Color(0xFFCFCFCF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: TextFormField(
                    onChanged: (_) => setState(() {}),
                    controller: textController2,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Product Price',
                      labelStyle: TextStyle(
                        fontFamily: 'Ubuntu',
                      ),
                      hintText: 'e.g water bottle',
                      hintStyle: TextStyle(
                        fontFamily: 'Ubuntu',
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      suffixIcon: textController2.text.isNotEmpty
                          ? InkWell(
                              onTap: () => setState(
                                () => textController2.clear(),
                              ),
                              child: Icon(
                                Icons.clear,
                                color: Color(0xFF757575),
                                size: 22,
                              ),
                            )
                          : null,
                    ),
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
              )
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: Alignment(-0.95, 0),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                  child: Text(
                    'Description',
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
              ),
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Color(0xFFCFCFCF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: TextFormField(
                    onChanged: (_) => setState(() {}),
                    controller: textController3,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(
                        fontFamily: 'Ubuntu',
                      ),
                      hintText: 'e.g Mineral water',
                      hintStyle: TextStyle(
                        fontFamily: 'Ubuntu',
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      suffixIcon: textController3.text.isNotEmpty
                          ? InkWell(
                              onTap: () => setState(
                                () => textController3.clear(),
                              ),
                              child: Icon(
                                Icons.clear,
                                color: Color(0xFF757575),
                                size: 22,
                              ),
                            )
                          : null,
                    ),
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
              )
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: Alignment(-0.95, 0),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                  child: Text(
                    'Availability',
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xA7D9D9D9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Availability',
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                    DropdownButton<String>(
                      value: dropDownValue,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropDownValue = newValue;
                        });
                      },
                      items: <String>['Available', 'Not Available']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                    // FlutterFlowDropDown(
                    //   options: ['Available', 'Not Available'],
                    //   onChanged: (value) {
                    //     setState(() => dropDownValue = value);
                    //   },
                    //   width: 130,
                    //   height: 40,
                    //   textStyle: TextStyle(
                    //     fontFamily: 'Ubuntu',
                    //     color: Colors.black,
                    //   ),
                    //   fillColor: Colors.white,
                    //   elevation: 2,
                    //   borderColor: Colors.transparent,
                    //   borderWidth: 0,
                    //   borderRadius: 0,
                    //   margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
                    // )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
            child: InkWell(
              onTap: () async {
                await showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: AlertdialogueeWidget(),
                    );
                  },
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Align(
                  alignment: Alignment(0, 0),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
