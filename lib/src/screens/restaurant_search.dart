import 'package:flutter/material.dart';
import 'package:food/src/helpers/screen_Navigation.dart';
import 'package:food/src/helpers/style.dart';
import 'package:food/src/provider/app.dart';
import 'package:food/src/provider/product.dart';
import 'package:food/src/provider/restaurant.dart';
import 'package:food/src/screens/restaurant.dart';
import 'package:food/src/widgets/loading.dart';
import 'package:food/src/widgets/product.dart';
import 'package:food/src/widgets/restaurant.dart';
import 'package:provider/provider.dart';

class RestaurantsSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final app = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        leading: IconButton(icon: Icon(Icons.close), onPressed: (){
          Navigator.pop(context);
        }),
        title: Text("Restaurants",style: TextStyle(color: gray,fontSize: 18),),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){

          })
        ],

      ),
      body: app.isLoading ? Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Loading(),
          ],
        ),
      ) : restaurantProvider.searchedRestaurants.length < 1? Column(
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
              Text("No Restaurant Found",style: TextStyle(color: gray,fontSize: 22,fontWeight: FontWeight.w300),),
            ],
          ),
        ],
      ) : ListView.builder(
        itemCount: restaurantProvider.searchedRestaurants.length,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: ()async{
              app.changeLoading();
              await productProvider.loadProductsByRestaurant(
                  restaurantId: restaurantProvider.searchedRestaurants[index].id
              );
              changeScreen(context, RestaurantScreen(
                restaurantModel: restaurantProvider.searchedRestaurants[index],
              ));
              app.changeLoading();
            },
            child: RestaurantsWidget(
                restaurant: restaurantProvider.searchedRestaurants[index]
            ),
          );
        },
      ),
    );
  }
}
