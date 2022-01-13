import 'package:petani_kopi/model/product.dart';

class Order {
  String? userId;
  String? userName;
  String? userImage;
  String? userImageHash;
  String? userLocation;
  String? incomingOrderId;
  String? outComingOrderId;
  String? userStatus;
  List<Product>? list;

  //helper
  int? index;

  Order({
    this.userId,
    this.userName,
    this.userImage,
    this.userImageHash,
    this.userLocation,
    this.incomingOrderId,
    this.outComingOrderId,
    this.userStatus,
    this.list,
    this.index,
  });

  Order.incoming(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    userImage = json['userImage'];
    userImageHash = json['userImageHash'];
    userLocation = json['userLocation'];
    incomingOrderId = json['incomingOrderId'];
    outComingOrderId = json['outComingOrderId'];
    userStatus = json['userStatus'];
    json['cartList'].forEach((item) {
      list = [];
      list!.add(Product.fromCartList(item));
    });
  }

  Order.outcoming(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    userImage = json['userImage'];
    userImageHash = json['userImageHash'];
    userLocation = json['userLocation'];
    outComingOrderId = json['outComingOrderId'];
    userStatus = json['userStatus'];
    json['cartList'].forEach((item) {
      list = [];
      list!.add(Product.fromCartList(item));
    });
  }
}
