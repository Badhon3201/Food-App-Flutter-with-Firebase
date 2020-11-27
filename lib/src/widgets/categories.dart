import 'package:flutter/material.dart';
import 'package:food/src/models/category.dart';

import 'package:food/src/helpers/style.dart';
import 'package:food/src/widgets/loading.dart';
import 'package:transparent_image/transparent_image.dart';


class CategoryWidget extends StatelessWidget {

  final CategoryModel category;

  const CategoryWidget({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Stack(
        children: [
          Container(
            width: 140,
            height: 160,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Loading(),
                    ),
                  ),
                  Center(
                    child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: category.image),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: 140,
            height: 160,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.05),
                      Colors.black.withOpacity(0.25),
                    ]
                )
            ),
          ),

          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Text(category.name,style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold
              ),),
            ),
          )

        ],
      ),
    );
  }
}

