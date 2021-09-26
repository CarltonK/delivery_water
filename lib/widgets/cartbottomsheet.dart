import 'package:flutter/material.dart';

class NewerrWidget extends StatefulWidget {
  NewerrWidget({Key key}) : super(key: key);

  @override
  _NewerrWidgetState createState() => _NewerrWidgetState();
}

class _NewerrWidgetState extends State<NewerrWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: 
          Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / .9,
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment(-0.03, 0),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(
                  'Cart',
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment(-0.1, -0.5),
                              child: Text(
                                'Water Tanker',
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  color: Color(0xFF15212B),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment(2.64, 0.55),
                              child: Text(
                                'Ksh  2200',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF8B97A2),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment(1, 0),
                          child: Container(
                            width: 40,
                            height: 40,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              'https://picsum.photos/seed/913/400',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment(0.05, 0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 28,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment(-0.1, -0.5),
                              child: Text(
                                'Water Bottle....',
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  color: Color(0xFF15212B),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment(2.64, 0.55),
                              child: Text(
                                'Ksh 200',
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  color: Color(0xFF8B97A2),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment(1, 0),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(110, 0, 0, 0),
                            child: Container(
                              width: 40,
                              height: 40,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                'https://picsum.photos/seed/913/400',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment(0.05, 0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 28,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text(
                'Total',
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Align(
                        alignment: Alignment(0, -0.05),
                        child: Text(
                          'Ksh',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            color: Color(0xFFE6E6E6),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Align(
                        alignment: Alignment(0, -0.1),
                        child: Text(
                          'Checkout',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFFFBFBFB),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
