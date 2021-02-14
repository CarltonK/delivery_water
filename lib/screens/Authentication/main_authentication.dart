import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:water_del/screens/screens.dart';
import 'package:water_del/utilities/utilities.dart';

class MainAuthentication extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MainAuthentication> with TickerProviderStateMixin {
  TabController controller;
  PageController _pageController;
  int _selectedPage = 0;

  final List<Widget> tabs = [
    Text(
      "Sign In",
      style: boldOutlineBlack,
    ),
    Text("Sign Up", style: boldOutlineBlack)
  ];

  Widget _appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: 200,
          height: 40,
          child: TabBar(
            controller: controller,
            indicatorColor: Theme.of(context).primaryColor,
            labelPadding: EdgeInsets.all(8),
            indicatorWeight: 2,
            onTap: (value) {
              setState(() {
                _selectedPage = value;
                _pageController.animateToPage(
                  _selectedPage,
                  duration: Duration(milliseconds: 100),
                  curve: Curves.ease,
                );
              });
            },
            tabs: tabs,
          ),
        ),
      ],
    );
  }

  List<Widget> _pages = [LoginPage(), SignUpPage()];

  Widget _pageSelection() {
    return Expanded(
      child: PageView(
        children: _pages,
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
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
  void dispose() {
    controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Home(
      size: size,
      bar: _appBar(),
      body: _pageSelection(),
    );
  }
}

class Home extends StatelessWidget {
  final Size size;
  final Widget bar;
  final Widget body;
  Home({@required this.size, @required this.bar, @required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.fromLTRB(20, 40, 10, 0),
          child: Column(
            children: <Widget>[bar, body],
          ),
        ),
      ),
    );
  }
}
