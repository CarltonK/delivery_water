import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:water_del/utilities/styles.dart';

class Supplier extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,
        color: Colors.black,), onPressed: null),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.shopping_cart,
          color: Colors.black,), onPressed: null),
        ],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 150,
              width: size.width,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.purple[200]
              ) ,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 75,
                    width: 75,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[50]
                    ),
                    child: FlutterLogo(),
                  ),
                  
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('YOUR RIDER',
                      style:normalDescription
                      ),
                      Text('Eric Kinyua',
                      style:boldOutlineWhite
                      ),                      
                    ],
                  ),

                  IconButton(icon: Icon(Icons.phone,
                  size: 40, color: Colors.white
                  ), onPressed: null)
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: <Widget>[
                Icon(Icons.timer,
                size: 30, color: Colors.green,),
                SizedBox(
                  width:20 
                ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('YOUR DELIVERY TIME',
                      style:normalOutlineBlack
                      ),
                      Text('1 hour 30 minutes',
                      style:boldOutlineBlack
                      ),                      
                    ],
                  ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: <Widget>[
                Icon(Icons.location_on,
                size: 30, color: Colors.green,),
                SizedBox(
                  width:20 
                ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('YOUR DELIVERY ADDRESS',
                      style:normalOutlineBlack
                      ),
                      Text('SECTION 9, THIKA',
                      style:boldOutlineBlack
                      ),                      
                    ],
                  ),
              ],
            ),
            SizedBox(
              height: 20,
            ), 
            Expanded(
                          child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.blue
                ),
              ),
            )           
          ],
        ),
      ),
    );
  }
}