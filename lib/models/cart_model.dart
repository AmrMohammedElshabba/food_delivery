import 'package:food_delivery/models/products_model.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  int? quantity;
  String? img;
  String? time;
  bool? isExist;
  ProductsModel? products;

  CartModel(
      {this.id,
        this.name,
        this.price,
        this.quantity,
        this.img,
        this.time,
        this.isExist,
        this.products
      });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    img = json['img'];
    time = json['time'];
    isExist = json['isExist'];
    products = ProductsModel.fromJson(json['products']);
  }


  Map<String,dynamic> toJson(){
    return {
      "id":this.id,
      "name": this.name,
      "price":this.price,
      "quantity":this.quantity,
      "img":this.img,
      "isExist":this.isExist,
      "time":this.time,
      "products" : this.products!.toJson(),
    };
  }

}