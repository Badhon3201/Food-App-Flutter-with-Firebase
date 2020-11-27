import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel{
  static const ID = "id";
  static const DESCRIPTION = "description";
  static const CART = "cart";
  static const USER_ID = "userId";
  static const TOTAL = "total";
  static const PRODUCT_ID = "productId";
  static const PRICE = "price";
  static const STATUS = "status";
  static const CREATED_AT = "createdAt";
  static const RESTAURANT_ID = "restaurantId";


  String _id;
  String _restaurantId;
  String _description;
  String _userId;
  String _status;
  int _createdAt;
  int _total;

//  getters
  String get id => _id;
  String get restaurantId => _restaurantId;
  String get description => _description;
  String get userId => _userId;
  String get status => _status;
  int get total => _total;
  int get createdAt => _createdAt;

  // public variable
  List cart;


  OrderModel.fromSnapshot(DocumentSnapshot snapshot){
    _id = snapshot.data[ID];
    _description = snapshot.data[DESCRIPTION];
    _total = snapshot.data[TOTAL];
    _status = snapshot.data[STATUS];
    _userId = snapshot.data[USER_ID];
    _createdAt = snapshot.data[CREATED_AT];
    _restaurantId = snapshot.data[RESTAURANT_ID];
    cart = snapshot.data[CART];
  }

}