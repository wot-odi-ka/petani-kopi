import 'package:petani_kopi/helper/constants.dart';
import 'package:petani_kopi/model/product.dart';

class IncomingOrder {
  String? userId;
  String? userName;
  String? userImage;
  String? userImageHash;
  String? userLocation;
  String? userReceipt;
  String? userHashReceipt;
  String? userStatus;
  List<Product>? list;

  //helper
  int? index;
  bool? isChecked;
  String? shopId;

  //order
  String? incomingOrderId;
  String? outComingOrderId;

  IncomingOrder({
    this.userId,
    this.userImage,
    this.userImageHash,
    this.userLocation,
    this.userName,
    this.userHashReceipt,
    this.userReceipt,
    this.userStatus,
    this.index,
    this.list,
    //
    this.isChecked,
    this.shopId,
  });

  IncomingOrder.fromCart(Map<String, dynamic> json) {
    userId = json['shopId'];
    userName = json['shopName'];
    userImage = json['shopImage'];
    userImageHash = json['shopImageHash'];
    userLocation = json['shopLocation'];
    json['cartList'].forEach((item) {
      list = [];
      list!.add(Product.fromCartList(item));
    });
  }

  IncomingOrder.inOrder(
    Map<String, dynamic> json, {
    required List<Product> cartList,
    required String receiptUrl,
    required String receiptHash,
    required String shopID,
    required String outOrderId,
  }) {
    userId = json['userId'];
    userName = json['userName'];
    userImage = json['userImage'];
    userImageHash = json['userImageHash'];
    userLocation = json['userCity'];
    shopId = shopID;
    userReceipt = receiptUrl;
    userHashReceipt = receiptHash;
    list = cartList;
    outComingOrderId = outOrderId;
  }

  Map<String, dynamic> incomingOrder() {
    Map<String, dynamic> map = {};
    map["userId"] = userId;
    map["userName"] = userName;
    map["userImage"] = userImage;
    map["userImageHash"] = userImageHash;
    map["userLocation"] = userLocation;
    map["userReceipt"] = userReceipt;
    map["userHashReceipt"] = userHashReceipt;
    map["userStatus"] = userStatus ?? Const.notConfirmed;
    map["outComingOrderId"] = outComingOrderId;
    map["incomingOrderId"] = '';
    if (list != null) {
      map['cartList'] = list!.map((e) => e.toCartList()).toList();
    }
    return map;
  }

  Map<String, dynamic> myOrder() {
    Map<String, dynamic> map = {};
    map["userId"] = userId;
    map["userName"] = userName;
    map["userImage"] = userImage;
    map["userImageHash"] = userImageHash;
    map["userLocation"] = userLocation;
    map["userStatus"] = userStatus ?? Const.notConfirmed;
    if (list != null) {
      map['cartList'] = list!.map((e) => e.toCartList()).toList();
    }
    return map;
  }
}
