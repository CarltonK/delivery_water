import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:water_del/screens/Authentication/merchantservices.dart';
import 'landing.dart';

class HomeMap extends StatefulWidget {
  const HomeMap({ Key key }) : super(key: key);

  @override
  _HomeMapState createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
    static final CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(-1.2320662, 36.8780867),
    zoom: 14.4746,
  );
  
  @override
  Widget build(BuildContext context) {
    return                 Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Row(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Material(
                            color: Colors.transparent,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 250,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GoogleMap(
                                      initialCameraPosition: _cameraPosition,
                                      buildingsEnabled: true,
                                      // mapType: MapType.normal,
                                      zoomControlsEnabled: false,

                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    await showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      context: context,
                                                      builder: (context) {
                                                        return Container(
                                                          height: 750,
                                                          child: 
                                                          // Landing();
                                                          MarkersMap(),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(20, 0, 0, 0),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.circular(15),
                                                          child: Image.asset(
                                                            'assets/images/location.png',
                                                            width: 60,
                                                            height: 60,
                                                            color: Colors.black,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding: EdgeInsets.fromLTRB(
                                                              12, 20, 12, 0),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment.center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Find Suppliers in your area',
                                                                textAlign: TextAlign.start,
                                                                style: TextStyle(
                                                                  fontFamily: 'Lexend Deca',
                                                                  fontWeight: FontWeight.w700,
                                                                  color: Colors.blue,
                                                                  fontSize: 16
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets.fromLTRB(
                                                                          0, 15, 0, 8),
                                                                  child: Text(
                                                                    "",// 'Get delivery services at a go',
                                                                    style: TextStyle(
                                                                      fontFamily:
                                                                          'Lexend Deca',
                                                                  fontWeight: FontWeight.w400,
                                                                  color: Colors.black,
                                                                  // fontSize: 16,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.fromLTRB(
                                                                    60, 0, 5, 10),
                                                                child: InkWell(
                                                                  onTap: () async {
                                                                    await showModalBottomSheet(
                                                                      isScrollControlled:
                                                                          true,
                                                                      context: context,
                                                                      builder: (context) {
                                                                        return 
                                                                        MarkersMap();
                                                                        // LandingWidget();
                                                                      },
                                                                    );
                                                                  },
                                                                  child: Container(
                                                                    width: 150,
                                                                    height: 50,
                                                                    decoration: BoxDecoration(
                                                                      color:
                                                                          Color(0xFF4D3BF2),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(15),
                                                                    ),
                                                                    child: Padding(
                                                                      padding:
                                                                          EdgeInsets.fromLTRB(
                                                                              0, 15, 0, 0),
                                                                      child: Text(
                                                                        'View Map',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                          fontFamily:
                                                                              'Lexend Deca',
                                                                          color: Color(
                                                                              0xFFEFEFEF),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
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
                                      ],
                                    )
                                  ],
                                ),
                              );
              
                }
              }
              
