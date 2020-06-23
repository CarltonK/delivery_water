import 'package:flutter/material.dart';
import 'package:water_del/models/cartModel.dart';
import 'package:water_del/utilities/styles.dart';

class SingleCartItem extends StatelessWidget {
  final CartModel model;

  SingleCartItem({@required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8)
      ),
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 100,
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                model.imgUrl,
                fit: BoxFit.fitHeight,
              )
            ),
          ),
          Column(
            children: <Widget>[
              Text(model.title, style: normalOutlineBlack),
              Text("${model.price.toString()} KES", style: subheaderOutlineBlack,)
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white
                ),
                child: IconButton(
                  icon: Icon(Icons.add,color: Colors.green,),
                  padding: EdgeInsets.all(1),
                  constraints: BoxConstraints(
                    maxHeight: 30,
                    maxWidth: 30,
                    minHeight: 30,
                    minWidth: 30
                  ),
                  iconSize: 20, 
                  onPressed: null
                ),
              ),
              SizedBox(height: 5,),
              Container(
                color: Colors.transparent,
                child: Text(model.quantity.toString()),
              ),
              SizedBox(height: 5,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white
                ),
                child: IconButton(
                  icon: Icon(Icons.remove,color: Colors.red,),
                  padding: EdgeInsets.all(1),
                  constraints: BoxConstraints(
                    maxHeight: 30,
                    maxWidth: 30,
                    minHeight: 30,
                    minWidth: 30
                  ),
                  iconSize: 20, 
                  onPressed: null
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}