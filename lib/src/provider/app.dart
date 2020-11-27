import 'package:flutter/material.dart';

enum SearchBy{PRODUCTS, RESTAURANTS}
class AppProvider extends ChangeNotifier{
  bool isLoading = false;
  SearchBy search = SearchBy.PRODUCTS;
  String filerBy = "Products";

  void changeLoading(){
    isLoading = !isLoading;
    notifyListeners();
  }

  void changeSearchBy({SearchBy newSearchBy}){
    search = newSearchBy;
    if(newSearchBy == SearchBy.PRODUCTS){
      filerBy = "Products";
    }else{
      filerBy = "Restaurants";
    }
    notifyListeners();
  }
}