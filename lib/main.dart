import 'package:flutter/material.dart';
import 'package:food/src/provider/app.dart';
import 'package:food/src/provider/category.dart';
import 'package:food/src/provider/product.dart';
import 'package:food/src/provider/restaurant.dart';
import 'package:food/src/provider/user.dart';
import 'package:food/src/screens/home.dart';
import 'package:food/src/screens/login.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: AppProvider()),
    ChangeNotifierProvider.value(value: UserProvider.initialize()),
    ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
    ChangeNotifierProvider.value(value: RestaurantProvider.initialize()),
    ChangeNotifierProvider.value(value: ProductProvider.initialize()),
  ],
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Food App',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: ScreensController()),
      //home: ShoppingBag()),
  ));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch(auth.status){
      case Status.Uninitialized :
        return loginScreen();
      case Status.Unauthenticated :
      case Status.Authenticating :
        return loginScreen();
      case Status.Authenticated :
        return MyHomePage();
      default:
        return loginScreen();
    }
  }
}