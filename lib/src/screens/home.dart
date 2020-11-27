import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food/src/helpers/screen_Navigation.dart';
import 'package:food/src/models/user.dart';
import 'package:food/src/provider/app.dart';
import 'package:food/src/provider/category.dart';
import 'package:food/src/provider/product.dart';
import 'package:food/src/provider/restaurant.dart';
import 'package:food/src/provider/user.dart';
import 'package:food/src/screens/product_search.dart';
import 'package:food/src/screens/restaurant.dart';
import 'package:food/src/screens/restaurant_search.dart';
import 'package:food/src/widgets/buttonNavigationIcon.dart';
import 'package:food/src/widgets/categories.dart';
import 'package:food/src/widgets/featured_product.dart';
import 'package:food/src/widgets/loading.dart';
import 'package:food/src/widgets/restaurant.dart';
import 'package:provider/provider.dart';
import 'package:food/src/helpers/style.dart';

import 'bag.dart';
import 'category.dart';
import 'login.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    //restaurantProvider.loadSingleRestaurant();

    return Scaffold(
      backgroundColor: white,
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: black),
              accountName: Text(
                user.userModel?.name ?? "username lading...",
              ),
              accountEmail: Text(
                user.userModel?.email ?? "email loading...",
              ),
            ),

            ListTile(
              onTap: () {
                changeScreen(context, MyHomePage());
                Loading();
              },
              leading: Icon(Icons.home),
              title: Text("Home"),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Account"),
            ),
            ListTile(
              onTap: (){
                print("click");
              },
              leading: Icon(Icons.shopping_cart),
              title: Text("Cart"),
            ),
            ListTile(
              onTap: () {
                user.signOut();
                changeScreenReplacement(context, loginScreen());
              },
              leading: Icon(Icons.exit_to_app),
              title: Text("Log out"),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        elevation: 0,
        backgroundColor: black,
        title: Text("Food App",style: TextStyle(color: white),),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: (){
                   changeScreen(context,ShoppingBag());
                },
                icon: Icon(
                    Icons.shopping_cart,color: Colors.white,
                ),
              ),
            ],
          ),
          Stack(
            children: [
              IconButton(
                onPressed: (){

                },
                icon: Icon(
                    Icons.notifications,color: Colors.white,
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    color: red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: app.isLoading ? Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Loading(),
          ],
        ),
      ) : SafeArea(
        child: ListView(
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: black,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20) )
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 10.0,bottom: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[400],
                        offset: Offset(1, 1),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Icon(Icons.search,color: red,),
                    title: TextField(
                      textInputAction: TextInputAction.search,
                      onSubmitted: (pattern)async{
                        app.changeLoading();
                        if(app.search == SearchBy.PRODUCTS){
                          await productProvider.search(productName: pattern);
                          changeScreen(context, ProductSearchScreen());
                        }else{
                          await restaurantProvider.search(name: pattern);
                          changeScreen(context, RestaurantsSearchScreen());
                        }

                        app.changeLoading();
                      },
                      decoration: InputDecoration(
                        hintText: 'Find Food and Resturants',hintStyle: TextStyle(fontSize: 16),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Search BY",style: TextStyle(fontSize: 17),),
                DropdownButton<String>(
                  value: app.filerBy,
                  icon: Icon(Icons.filter_list,color: red,),
                  elevation: 0,
                  onChanged: (value){
                    if(value == "Products"){
                      app.changeSearchBy(newSearchBy: SearchBy.PRODUCTS);
                    }else{
                      app.changeSearchBy(newSearchBy: SearchBy.RESTAURANTS);
                    }
                  },
                  items: <String>["Products", "Restaurants"].map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value));
                  }).toList(),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryProvider.categories.length,
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: ()async{
                      //app.changeLoading();
                      await productProvider.loadProductsByCategory(
                          categoryName: categoryProvider.categories[index].name
                      );
                      changeScreen(
                          context,
                          CategoryScreen(categoryModel:
                          categoryProvider.categories[index],
                          ));
                      //app.changeLoading();
                    },
                    child: CategoryWidget(category: categoryProvider.categories[index])
                  );
                },
                
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Featured',style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: gray,
                  ),),
                  Text('See All',style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: gray,
                  ),),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Featured(),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Popular Restaurants',style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: gray,
                  ),),
                  Text('See All',style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: gray,
                  ),),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),

            Column(
              children: restaurantProvider.restaurants
                  .map((item) => GestureDetector(
                onTap: ()async{
                  app.changeLoading();
                  //await productProvider.loadProductsByRestaurant(restaurantId: item.id);
                  app.changeLoading();
                  changeScreen(context, RestaurantScreen(restaurantModel: item,));
                },
                child: RestaurantsWidget(restaurant: item,),
              ))
                  .toList(),

            )

          ],
        ),
      ),
    );
  }
}
