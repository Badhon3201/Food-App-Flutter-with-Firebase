import 'package:flutter/material.dart';
import 'package:food/src/helpers/screen_Navigation.dart';

import 'package:food/src/helpers/style.dart';
import 'package:food/src/screens/bag.dart';
class ButtonNavigationIcon extends StatefulWidget {
  @override
  _ButtonNavigationIconState createState() => _ButtonNavigationIconState();
}

class _ButtonNavigationIconState extends State<ButtonNavigationIcon> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: (){
              print('click');
            },
            child: Column(
              children: [
                Icon(Icons.home,size: 30,color: gray),
                Text('Home'),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Icon(Icons.person_pin,size: 30,color: black,),
              Text('Near By'),
            ],
          ),
        ),

        GestureDetector(
          onTap: (){
            changeScreen(context,ShoppingBag());
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Icon(Icons.shopping_cart,size: 30,color: gray),
                Text('Cart'),
              ],
            ),

          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Icon(Icons.person,size: 30,color: black,),
              Text('Account'),
            ],
          ),
        )
      ],
    );
  }
}
