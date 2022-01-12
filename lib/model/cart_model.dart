import 'package:petani_kopi/helper/extension.dart';
import 'package:petani_kopi/helper/utils.dart';
import 'package:petani_kopi/model/product.dart';

class CartModel {
  String? shopId;
  String? shopName;
  String? shopImage;
  String? shopImageHash;
  String? shopLocation;
  List<Product>? list;

  //helper
  int? index;
  bool? isExpand;
  bool? isChecked;

  CartModel({
    this.shopId,
    this.index,
    this.isExpand,
    this.list,
    this.shopImage,
    this.shopImageHash,
    this.shopLocation,
    this.shopName,
    this.isChecked,
  });

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
      map['cartList'] = list!.map((e) => e.toCartList()).toList();
    }
    return map;
  }

  CartModel.fromCartItem(Map<String, dynamic> json) {
    shopId = json['shopId'];
    shopName = json['shopName'];
    shopImage = json['shopImage'];
    shopImageHash = json['shopImageHash'];
    shopLocation = json['shopLocation'];
    isExpand = false;
    isChecked = false;
    index = 0;
    if (json['cartList'].isNotEmpty) {
      list = [];
      json['cartList'].forEach((e) {
        list!.add(Product.fromCartList(e));
      });
    }
  }
}

class CartUtils {
  static String countTotal(List<Product> products) {
    int result = 0;
    for (var i = 0; i < products.length; i++) {
      if (products[i].isChecked!) {
        int price = int.parse(products[i].totalPrice!.replaceAll('.', ''));
        result = result + price;
      }
    }

    return 'Rp. ' + setupSeparator(result);
  }

  static String countCheckout(List<CartModel> carts) {
    int result = 0;
    for (var i = 0; i < carts.length; i++) {
      for (var x = 0; x < carts[i].list!.length; x++) {
        if (carts[i].list![x].isChecked!) {
          int price = carts[i].list![x].totalPrice!.dotParse();
          result = result + price;
        }
      }
    }
    return setupSeparator(result);
  }

  static List<CartModel> checkoutFilter(List<CartModel> carts) {
    for (var i = 0; i < carts.length; i++) {
      for (var x = 0; x < carts[i].list!.length; x++) {
        if (carts[i].list![x].isChecked!) {
          carts[i].list!.removeWhere((element) => element.isChecked == false);
        }
      }
    }

    return carts;
  }
}
