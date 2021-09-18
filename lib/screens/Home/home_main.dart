import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:water_del/models/models.dart';
import 'package:water_del/screens/screens.dart';
import 'package:water_del/utilities/utilities.dart';
import 'package:water_del/widgets/global/Recent_transactions.dart';


class HomeMain extends StatefulWidget {
  @override
  _HomeMainState createState() => _HomeMainState();
}

//  1a1f24
class _HomeMainState extends State<HomeMain> {

  PageController _controller;
  var userCurrent;
  UserModel userModel;
  DatabaseProvider _databaseProvider = DatabaseProvider();
  List<String> display = [];
  LocationModel myLocation;
  Future productFuture;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Widget yesExit(BuildContext context) {
    return FlatButton(
      onPressed: () {
        AuthProvider.instance().logout();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
      child: Text(
        'YES',
      ),
    );
  }

  Widget _profilePage() {
    return Positioned(
      top: 40,
      right: 10,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(SlideLeftTransition(
              page: ProfilePage(
            user: userCurrent,
          )));
        },
        child: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.4), shape: BoxShape.circle),
          child: Center(
            child: Icon(
              CupertinoIcons.person_solid,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }

  Widget _singleItem(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          listMainItems[index].selected = !listMainItems[index].selected;
          !listMainItems[index].selected
              ? display.add(listMainItems[index].category)
              : display.remove(listMainItems[index].category);
          productFuture = _databaseProvider.populateMap(display);
        });
      },
      child: Card(
        elevation: 8,
        shadowColor: Colors.grey[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: listMainItems[index].selected
                  ? Colors.grey[50]
                  : Colors.pink[200]),
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Image.asset(
                listMainItems[index].imgUrl,
                height: 105,
                fit: BoxFit.contain,
              ),
              Text(
                listMainItems[index].title,
                style: normalOutlineBlack,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomSelection() {
    return Positioned(
      bottom: 5,
      left: 5,
      right: 5,
      child: Container(
        height: 150,
        child: PageView.builder(
          controller: _controller,
          itemCount: listMainItems.length,
          itemBuilder: (context, index) => _singleItem(index),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    userCurrent = context.read<AuthProvider>().currentUser;
    _controller = PageController(initialPage: 0, viewportFraction: 0.5);
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('Message -> $message');
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget clientPage() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[900],

      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: 800,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // image
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 16, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: Colors.blue,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                          child: Container(
                            width: 60,
                            height: 60,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              'https://images.unsplash.com/photo-1522529599102-193c0d76b5b6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(2, 15, 5, 0),
                        child: InkWell(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                duration: Duration(milliseconds: 200),
                                reverseDuration: Duration(milliseconds: 200),
                                child:
                                // Search(),
                                 Container(),
                                // CartWidget(),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.shopping_bag,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                //  Good Morning
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          _databaseProvider.greetingMessage(),
                          style: TextStyle(
                              fontSize: 28,
                              fontFamily: 'Lexend Deca',
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
                //  Name
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          "Sang",
                          style: TextStyle(
                              fontSize: 28,
                              fontFamily: 'Lexend Deca',
                              color: Colors.blue,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Text(
                          "👋🏿",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
                //  Map
                  HomeMap(),
                //  Recent
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Recent",
                      style: TextStyle(
                          fontSize: 28,
                          fontFamily: 'Lexend Deca',
                          color: Colors.white,
                          fontWeight: FontWeight.w200),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 15, 6),
                  child: Recent(),
                ),

              //   No products 
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "No Recent transactions",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Lexend Deca',
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Provider.of<OrderModel>(context).client = userCurrent.uid;
    return clientPage();
  }
}
