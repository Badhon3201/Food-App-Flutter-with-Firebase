import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:food/src/helpers/screen_Navigation.dart';
import 'package:food/src/models/product.dart';

import 'package:food/src/helpers/style.dart';
import 'package:food/src/provider/app.dart';
import 'package:food/src/provider/user.dart';
import 'package:food/src/screens/bag.dart';
import 'package:food/src/widgets/loading.dart';
import 'package:food/src/widgets/small_icon_button.dart';
import 'package:provider/provider.dart';
class Details extends StatefulWidget {
  final ProductModel product;
  Details({@required this.product});
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int quantity = 1;
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    return Scaffold(
      backgroundColor: white,
      body: app.isLoading ? Loading() : SafeArea(
        child:  Column(
          children: [
            Container(
              height: 300,
              child: Stack(
                children: [
                  Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Loading(),
                      )),
                  Carousel(
                    images: [
                      NetworkImage('${widget.product.image}'),
                      NetworkImage('${widget.product.image}'),
                      NetworkImage('${widget.product.image}'),
                    ],
                    dotBgColor: white,
                    dotColor: gray,
                    dotIncreasedColor: red,
                    dotIncreaseSize: 1.2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(icon: Icon(Icons.arrow_back_ios,color: white,), onPressed: (){
                        Navigator.pop(context);
                      }),
                      Stack(
                        children: [
                          IconButton(icon: Icon(Icons.shopping_cart,color: white,size: 40,),onPressed: (){
                            changeScreen(context, ShoppingBag());
                          },),
                          Positioned(
                            right: 5,
                            bottom: 4,
                            child: Container(
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: gray,
                                    offset: Offset(2, 3),
                                    blurRadius: 3,
                                  )
                                ]
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 2),
                                child: Text("$quantity",style: TextStyle(color: red,fontWeight: FontWeight.bold,fontSize: 16),),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Positioned(
                    bottom: 50,
                    right: 10,
                    child: SmallButton(),
                  ),
                ],
              ),
            ),
            Text(widget.product.name,style: TextStyle(
              fontSize: 24,fontWeight: FontWeight.bold,
            ),),
            Text("\$" + widget.product.price.toString(),style: TextStyle(
              fontSize: 16,fontWeight: FontWeight.bold,color: red
            ),),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(icon: Icon(Icons.remove,size: 44,),onPressed: (){
                  setState(() {
                    quantity -= 1;
                  });
                },),
                GestureDetector(
                  onTap: ()async{
                    app.changeLoading();
                    print("All set loading");
                    bool value =  await user.addToCard(product: widget.product, quantity: quantity);
                    if(value){
                      print("Item added to cart");
                      _key.currentState.showSnackBar(
                        SnackBar(content: Text("Added to Cart"),)
                      );
                      user.reloadUserModel();
                      app.changeLoading();
                      return;
                    }else{
                      print("Item NOT added to cart");
                    }
                    print("lOADING SET TO FALSE");

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: red,
                    ),
                    child: app.isLoading ? Loading() : Padding(
                        padding: EdgeInsets.fromLTRB(28, 12, 28, 12),
                      child: Text("Add $quantity To Cart",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
                IconButton(icon: Icon(Icons.add,size: 44,color: red,),onPressed: (){
                  setState(() {
                    quantity += 1;
                  });
                },),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
