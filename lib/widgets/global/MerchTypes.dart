import 'package:flutter/material.dart';
class MerchTypes extends StatefulWidget {
  const MerchTypes({ Key key, bool hasTapped }) : super(key: key);

  @override
  _MerchTypesState createState() => _MerchTypesState();
}

class _MerchTypesState extends State<MerchTypes> {
  bool  hasTapped = false;
  
  @override
  Widget build(BuildContext context) {
    return         // define row of 3  texts called Water, Electricity, and Gas
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        // Water
                        GestureDetector(
                          onTap: () {
                                                   showModalBottomSheet(
                                                  
                                                      context: context,
                                                      builder: (context) {
                                                        return Container(
                                                          height: 750,
                                                          child: 
                                                          Scaffold(),
                                                       
                                                        );
                                                      },);
                                                      setState(() {
                                                        hasTapped = true;
                                                      });
                          },
                          child: Expanded(
                                                      child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width / 3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 1.0), //(x,y)
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: Center(

                                child: Text(
                                  'Water \nDelivery',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Electricity
                        Expanded(
                                                  child: GestureDetector(
                            onTap: () {
                            },
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width / 3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 1.0), //(x,y)
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Bottled \nWater',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                              ),
                            ),
                          ),
                        ),
                                                GestureDetector(
                          onTap: () {
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Exhauster Services',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                            ),
                          ),
                        ),
                      ]
                    );
  }
}