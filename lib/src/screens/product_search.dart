import 'package:flutter/material.dart';
import 'package:food/src/helpers/screen_Navigation.dart';
import 'package:food/src/helpers/style.dart';
import 'package:food/src/provider/product.dart';
import 'package:food/src/screens/details.dart';
import 'package:food/src/widgets/product.dart';
import 'package:provider/provider.dart';

class ProductSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        leading: IconButton(icon: Icon(Icons.close), onPressed: (){
          Navigator.pop(context);
        }),
        title: Text("Products",style: TextStyle(color: gray,fontSize: 18),),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){
            
          })
        ],

      ),
      body: productProvider.productsSearched.length < 1? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search,color: gray,size: 30,),
            ],
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("No Product Found",style: TextStyle(color: gray,fontSize: 22,fontWeight: FontWeight.w300),),
            ],
          ),
        ],
      ) : ListView.builder(
        itemCount: productProvider.productsSearched.length,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              changeScreen(context, Details(product: productProvider.productsSearched[index]));
            },
            child: ProductWidget(
                product: productProvider.productsSearched[index]
            ),
          );
        },
      ),
    );
  }
}
