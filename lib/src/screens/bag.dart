import 'package:flutter/material.dart';
import 'package:food/src/helpers/order.dart';
import 'package:food/src/helpers/style.dart';
import 'package:food/src/models/cart_item.dart';
import 'package:food/src/models/product.dart';
import 'package:food/src/provider/app.dart';
import 'package:food/src/provider/user.dart';
import 'package:food/src/screens/details.dart';
import 'package:food/src/widgets/featured_product.dart';
import 'package:food/src/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ShoppingBag extends StatefulWidget {
  @override
  _ShoppingBagState createState() => _ShoppingBagState();
}

class _ShoppingBagState extends State<ShoppingBag> {
  final _key = GlobalKey<ScaffoldState>();
  OrderServices _orderServices = OrderServices();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        elevation: 0,
        //leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: black,),),
        backgroundColor: white,
        centerTitle: true,
        title: Text('Shopping Cart',style: TextStyle(color: black),),
        /*leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),*/

      ),
      backgroundColor: white,
      body: Column(
        children: [
          /*ListView.builder(
            itemCount: user.userModel.cart.length,
            itemBuilder: (_,index){
              return Text(user.userModel.cart[index].name);
            }
          )*/
        ],
      ),


      /*body: app.isLoading ? Loading() : ListView.builder(
        itemCount: user.userModel.cart.length,
        itemBuilder: (_,index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red[100],
                      offset: Offset(3, 5),
                      blurRadius: 25,
                    )
                  ]
              ),
              child: Row(
                children: [
                  //Image.asset("images/01.jpg",height: 120.0,width: 120.0,),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                    child: Image.network(
                      user.userModel.cart[index].image,
                      height: 120,
                      width: 140,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: user.userModel.cart[index].name+ "\n",
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: "\$${user.userModel.cart[index].price / 100} \n\n",
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300)),
                                  TextSpan(
                                      text: "Quantity: ",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400)),
                                  TextSpan(
                                      text: user.userModel.cart[index].quantity.toString(),
                                      style: TextStyle(
                                          color: Colors.deepPurpleAccent,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400)),
                                ]
                            ),
                          ),
                        ),
                        SizedBox(width: 50,),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: (){

                          },
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: red,
                            ),
                            onPressed: ()async{
                              app.changeLoading();
                              bool value = await user.removeFromCart(cartItem: user.userModel.cart[index]);
                              if(value){
                                user.reloadUserModel();
                                print("Item added to cart");
                                _key.currentState.showSnackBar(
                                    SnackBar(content: Text("Removed from Cart!"))
                                );
                                app.changeLoading();
                                return;
                              }else{
                                print("ITEM WAS NOT REMOVED");
                                app.changeLoading();
                              }
                            })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),*/
      /*bottomNavigationBar: Container(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Total: ",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 22,
                          fontWeight: FontWeight.w400)),
                  TextSpan(
                      text: " \$${user.userModel.totalCartPrice / 100}",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 22,
                          fontWeight: FontWeight.normal)),
                ]),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: Colors.blue),
                child: FlatButton(
                    onPressed: () {
                      if(user.userModel.totalCartPrice == 0){
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(20.0)), //this right here
                                child: Container(
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text('Your cart is emty', textAlign: TextAlign.center,),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                        return;
                      }
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(20.0)), //this right here
                              child: Container(
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('You will be charged \$${user.userModel.totalCartPrice / 100} upon delivery!', textAlign: TextAlign.center,),

                                      SizedBox(
                                        width: 320.0,
                                        child: RaisedButton(
                                          onPressed: () async{
                                            var uuid = Uuid();
                                            String id = uuid.v4();
                                            _orderServices.createOrder(
                                                userId: user.user.uid,
                                                id: id,
                                                description: "Some random description",
                                                status: "complete",
                                                totalPrice: user.userModel.totalCartPrice,
                                                cart: user.userModel.cart
                                            );
                                            for(CartItemModel cartItem in user.userModel.cart){
                                              bool value = await user.removeFromCart(cartItem: cartItem);
                                              if(value){
                                                user.reloadUserModel();
                                                print("Item added to cart");
                                                _key.currentState.showSnackBar(
                                                    SnackBar(content: Text("Removed from Cart!"))
                                                );
                                              }else{
                                                print("ITEM WAS NOT REMOVED");
                                              }
                                            }
                                            _key.currentState.showSnackBar(
                                                SnackBar(content: Text("Order created!"))
                                            );
                                            Navigator.pop(context);

                                          },
                                          child: Text(
                                            "Accept",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          color: const Color(0xFF1BC0C5),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 320.0,
                                        child: RaisedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Reject",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            color: red
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child: Text(
                      "Check out",
                      style: TextStyle(
                        fontSize: 20,
                        color: white,
                        fontWeight: FontWeight.normal,),
                    )),
              )
            ],
          ),
        ),
      ),*/
    );
  }
}
