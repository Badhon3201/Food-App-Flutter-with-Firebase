import 'package:flutter/material.dart';
import 'package:food/src/helpers/style.dart';

class SmallButton extends StatefulWidget {
  final String icon;
  SmallButton({this.icon});
  @override
  _SmallButtonState createState() => _SmallButtonState();
}

class _SmallButtonState extends State<SmallButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: gray,
            offset: Offset(2, 1),
            blurRadius: 3
          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(
          Icons.favorite,
          size: 16,
          color: red,
        ),
      ),
    );
  }
}
