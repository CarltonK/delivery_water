import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Login> with TickerProviderStateMixin {
  TabController controller;
  final List<Widget> tabs=[
    Text("data"),
    Text("data")
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
            child: Icon(Icons.person, color:Colors.white),
          ),
        ),
        TabBar(
          controller: controller,
          tabs: tabs
        )
      ],
    );
  }
  @override
  void initState() {
    super.initState();
    controller=TabController(length: 2, initialIndex: 0, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
          child: Container(
            height: size.height,
            width: size.width,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: <Widget>[
                _appBar(),
              ],
            ),
          ),
          value: SystemUiOverlayStyle.light),
    );
  }
}
