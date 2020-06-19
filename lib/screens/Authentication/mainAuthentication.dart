import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:water_del/screens/Authentication/SignUp.dart';
import 'package:water_del/screens/authentication/login.dart';
import 'package:water_del/utilities/styles.dart';

class MainAuthentication extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MainAuthentication> with TickerProviderStateMixin {
  TabController controller;
  PageController _pageController;
  int _selectedPage = 0;

  final List<Widget> tabs = [
    Text("Sign In", style: styleAuthButtons), 
    Text("Sign Up", style: styleAuthButtons)
  ];

  Widget _appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.pink[200],
          ),
          child: Center(
            child: Icon(Icons.person, color: Colors.white),
          ),
        ),
        Container(
          width: 200,
          height: 40,
          child: TabBar(
            controller: controller,
            onTap: (value) {
              setState(() {
                _selectedPage = value;
                 _pageController.animateToPage(_selectedPage, duration: Duration(milliseconds: 200), curve: Curves.ease);
              });
            }, 
            tabs: tabs,
          )
        )
      ],
    );
  }

  List<Widget> _pages = [
    LoginPage(),
    SignUpPage()
  ];

  Widget _pageSelection() {
    return Expanded(
      child: PageView(
        children: _pages,
        controller: _pageController,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, initialIndex: 0, vsync: this);
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
          child: Container(
            height: size.height,
            width: size.width,
            padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Column(
              children: <Widget>[
                _appBar(),
                _pageSelection()
              ],
            ),
          ),
          value: SystemUiOverlayStyle.light),
    );
  }
}
