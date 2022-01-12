import 'package:petani_kopi/model/product.dart';

class CartModel {
  String? shopId;
  String? shopName;
  String? shopImage;
  String? shopImageHash;
  String? shopLocation;
  List<Product>? list;

  CartModel.fromProduct(Map<String, dynamic> json) {
    shopId = json['userId'];
    shopName = json['userName'];
    shopImage = json['userImage'];
    shopImageHash = json['userImageHash'];
    shopLocation = json['userCity'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["shopId"] = shopId;
    map["shopName"] = shopName;
    map["shopImage"] = shopImage;
    map["shopImageHash"] = shopImageHash;
    map["shopLocation"] = shopLocation;
    if (list != null) {
      map['cartList'] = list!.map((e) => e.toCart()).toList();
    }
    return map;
  }
}
