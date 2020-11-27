import 'package:flutter/material.dart';
import 'package:food/src/helpers/screen_Navigation.dart';
import 'package:food/src/helpers/style.dart';
import 'package:food/src/provider/category.dart';
import 'package:food/src/provider/product.dart';
import 'package:food/src/provider/restaurant.dart';
import 'package:food/src/provider/user.dart';
import 'package:food/src/screens/home.dart';
import 'package:food/src/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food/src/widgets/loading.dart';
import 'package:provider/provider.dart';
class loginScreen extends StatefulWidget {
  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  String _email, _password;
  final _key = GlobalKey<ScaffoldState>();
  bool _autoValidate = false;
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      key: _key,
      body: authProvider.status == Status.Authenticating? Loading() : SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("images/user-login.png",height: 200,width: 300,),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: gray),
                    borderRadius:BorderRadius.circular(10),
                  ),
                  child: Padding(padding: EdgeInsets.only(left: 10),
                    child: TextFormField(
                      /*validator: (input){
                        if(input.isEmpty){
                          return 'Please enter the mail';
                        }
                      },*/
                      controller: authProvider.email,
                      //onSaved: (input) => _email = input,
                      decoration: InputDecoration(
                          hintText: 'Emails',
                          border: InputBorder.none,
                          icon: Icon(Icons.email)
                      ),
                    ),),
                )
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: gray),
                    borderRadius:BorderRadius.circular(10),
                  ),
                  child: Padding(padding: EdgeInsets.only(left: 10),
                    child: TextFormField(
                      /*validator: (input){
                        if(input.length < 6){
                          return 'Password must be 6 cherecter';
                        }
                      },*/
                      controller: authProvider.password,
                      //onSaved: (input) => _password = input,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          border: InputBorder.none,
                          icon: Icon(Icons.lock)
                      ),
                      obscureText: true,
                    ),),
                )
              ),
              GestureDetector(
                onTap: ()async{
                  if(await authProvider.signIn()){
                    _key.currentState.showSnackBar(
                      SnackBar(content: Text("Login Field"))
                    );
                    return;
                  }
                  categoryProvider.loadCategories();
                  restaurantProvider.loadSingleRestaurant();
                  productProvider.loadProducts();
                  authProvider.clearController();
                  changeScreenReplacement(context, MyHomePage());
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: red,
                      border: Border.all(color: gray),
                      borderRadius:BorderRadius.circular(10),
                    ),
                    child: Padding(padding: EdgeInsets.only(top: 10,bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Login',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: white,
                          ),),
                        ],
                      ),
                    ),
                  )
                ),
              ),
              GestureDetector(
                onTap: (){
                  changeScreen(context,RegistrationScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Register Here',style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),),
                  ],
                ),
              ),
              SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }
}
