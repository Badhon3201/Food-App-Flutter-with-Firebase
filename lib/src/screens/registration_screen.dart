import 'package:flutter/material.dart';
import 'package:food/src/helpers/screen_Navigation.dart';
import 'package:food/src/helpers/style.dart';
import 'package:food/src/provider/user.dart';
import 'package:food/src/widgets/loading.dart';
import 'package:provider/provider.dart';

import 'home.dart';
import 'login.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);
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
                      child: TextField(
                        controller: authProvider.name,
                        decoration: InputDecoration(
                            hintText: 'Username',
                            border: InputBorder.none,
                            icon: Icon(Icons.person)
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
                      child: TextField(
                        controller: authProvider.email,
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
                      child: TextField(
                        controller: authProvider.password,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            border: InputBorder.none,
                            icon: Icon(Icons.lock)
                        ),
                      ),),
                  )
              ),
              GestureDetector(
                onTap: ()async{
                  print("BTN CLICKED!!!!");
                  print("BTN CLICKED!!!!");
                  print("BTN CLICKED!!!!");
                  print("BTN CLICKED!!!!");
                  print("BTN CLICKED!!!!");
                  print("BTN CLICKED!!!!");

                  if(!await authProvider.signUp()){
                    _key.currentState.showSnackBar(
                        SnackBar(content: Text("Resgistration failed!"))
                    );
                    return;
                  }
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
                              Text('Registration',style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: white,
                              ),),
                            ],
                          )
                      ),
                    )
                ),
              ),
              GestureDetector(
                onTap: (){
                  changeScreen(context,loginScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Login Here',style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    );
  }
}
