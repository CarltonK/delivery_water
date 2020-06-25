import 'package:flutter/material.dart';
import 'package:water_del/models/cartModel.dart';
import 'package:water_del/utilities/styles.dart';

class ItemHolderWidget extends StatefulWidget {
  @override
  _ItemHolderWidgetState createState() => _ItemHolderWidgetState();
}

class _ItemHolderWidgetState extends State<ItemHolderWidget> {

  PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.85);
  }

  _itemSelector(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 300,
            width: Curves.easeInOut.transform(value) * 400,
            child: widget,
          ),
        );
      },
      child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20)
              ),
              margin: EdgeInsets.fromLTRB(10, 10, 10, 30),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Center(
                    child: Hero(
                      tag: itemsCart[index], 
                      child: Image.asset(
                        'assets/logos/google.png', 
                        width: 130, 
                        height: 130,
                        fit: BoxFit.cover,
                      )
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('FROM', style: headerOutlineBlack,),
                        Text('100 KES', style: boldOutlineBlack,)
                      ],
                    )
                  ),
                  Positioned(
                    left: 20,
                    bottom: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('${itemsCart[index].title}', style: boldOutlineBlack,),
                        Text('${itemsCart[index].quantity}', style: boldOutlineBlack,)
                      ],
                    )
                  ),
                  Positioned(
                    bottom: 5,
                    child: RawMaterialButton(
                      padding: EdgeInsets.all(8),
                      shape: CircleBorder(),
                      elevation: 3,
                      fillColor: Colors.white,
                      child: Icon(Icons.location_on,color: Colors.green, size: 30,),
                      onPressed: null
                    )
                  )
                ],
              ),
            )
          ],
        ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 300,
      width: double.infinity,
      child: PageView.builder(
        onPageChanged: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        controller: _pageController,
        itemCount: itemsCart.length,
        itemBuilder: (context, index) {
          return _itemSelector(index);
        },
      ),
    );
  }
}