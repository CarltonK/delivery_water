import 'package:water_del/screens/itemsLIst.dart';
import 'package:water_del/screens/transactions.dart';
import 'package:water_del/widgets/profile_widget.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class MerchantProfileWidget extends StatefulWidget {
  MerchantProfileWidget({Key key}) : super(key: key);

  @override
  _MerchantProfileWidgetState createState() => _MerchantProfileWidgetState();
}

class _MerchantProfileWidgetState extends State<MerchantProfileWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
          ),
          child: SingleChildScrollView(
                      child: Container(
              child: Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment(-0.1, -1),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFF020203),
                    ),
                  ),
                ),
                SafeArea(
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Color(0xFF020203),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Align(
                                alignment: Alignment(-0.8, -0.55),
                                child: InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.scale,
                                        alignment: Alignment.bottomCenter,
                                        duration: Duration(milliseconds: 10),
                                        reverseDuration:
                                            Duration(milliseconds: 10),
                                        child: ProfileWidget(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      'https://picsum.photos/seed/246/600',
                                    ),
                                  ),
                                ),
                              ),
                              AutoSizeText(
                                'MM Suppliers',
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Text(
                                  'Ksh 2000',
                                  style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    color: Color(0xFFFEFEFE),
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment(0.2, 0),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  child: Text(
                                    ' Sales',
                                    style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      color: Color(0xFFEEEEEE),
                                      fontWeight: FontWeight.w300,
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
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
              child: InkWell(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemsLIstWidget(),
                    ),
                  );
                },
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Color(0xFFF5F5F5),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.network(
                        'https://images.unsplash.com/photo-1593998066526-65fcab3021a2?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1498&q=80',
                        width: double.infinity,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 25),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'All Products',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                              child: Text(
                                'Update products',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
            //   child: InkWell(
            //     onTap: () async {
            //       await Navigator.push(
            //         context,
            //         PageTransition(
            //           type: PageTransitionType.bottomToTop,
            //           duration: Duration(milliseconds: 300),
            //           reverseDuration: Duration(milliseconds: 300),
            //           child: TransacctionsWidget(),
            //         ),
            //       );
            //     },
            //     child: Card(
            //       clipBehavior: Clip.antiAliasWithSaveLayer,
            //       color: Color(0xFFF5F5F5),
            //       elevation: 3,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(20),
            //       ),
            //       child: Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           Image.network(
            //             'https://picsum.photos/seed/789/300',
            //             width: double.infinity,
            //             height: 120,
            //             fit: BoxFit.cover,
            //           ),
            //           Padding(
            //             padding: EdgeInsets.fromLTRB(15, 15, 15, 25),
            //             child: Column(
            //               mainAxisSize: MainAxisSize.max,
            //               children: [
            //                 Padding(
            //                   padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            //                   child: Row(
            //                     mainAxisSize: MainAxisSize.max,
            //                     mainAxisAlignment:
            //                         MainAxisAlignment.spaceBetween,
            //                     children: [
            //                       Text(
            //                         'Transactions',
            //                         style: TextStyle(
            //                           fontFamily: 'Poppins',
            //                           fontSize: 15,
            //                           fontWeight: FontWeight.w600,
            //                         ),
            //                       )
            //                     ],
            //                   ),
            //                 ),
            //                 Padding(
            //                   padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
            //                   child: Text(
            //                     'VIew all transactions',
            //                     style: TextStyle(
            //                       fontFamily: 'Poppins',
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // )
        ],
      ),
              ),
            ),
          ),
        ),
    );
  }
}
