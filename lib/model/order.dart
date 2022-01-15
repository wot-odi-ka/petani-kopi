import 'package:petani_kopi/helper/constants.dart';
import 'package:petani_kopi/model/product.dart';

class OrderSubmit {
  String? userId;
  String? orderId;
  String? userName;
  String? userImage;
  String? userImageHash;
  String? userLocation;
  String? userReceipt;
  String? userHashReceipt;
  String? processStatus;
  String? orderType;
  List<Product>? list;

  //helper
  int? index;

  OrderSubmit({
    this.userId,
    this.orderId,
    this.userImage,
    this.userImageHash,
    this.userLocation,
    this.userName,
    this.userHashReceipt,
    this.userReceipt,
    this.processStatus,
    this.orderType,
    this.list,
    this.index,
  });

  OrderSubmit.incoming(Map<String, dynamic> json) {
    userId = json['shopId'];
    userName = json['shopName'];
    userImage = json['shopImage'];
    userImageHash = json['shopImageHash'];
    userLocation = json['shopLocation'];
    userReceipt = json['receiptUrl'];
    userHashReceipt = json['receiptHash'];
    orderType = Const.orderIncoming;
    list = [];
    json['cartList'].forEach((item) {
      list!.add(Product.fromCartList(item));
    });
  }

  OrderSubmit.outcoming({
    required Map<String, dynamic> json,
    required Map<String, dynamic> userMap,
  }) {
    userId = userMap['userId'];
    userName = userMap['userName'];
    userImage = userMap['userImage'];
    userImageHash = userMap['userImageHash'];
    userLocation = userMap['userCity'];
    userReceipt = json['receiptUrl'];
    userHashReceipt = json['receiptHash'];
    orderType = Const.orderOutcoming;
    list = [];
    json['cartList'].forEach((item) {
      list!.add(Product.fromCartList(item));
    });
  }

  OrderSubmit.fromOrder(Map<String, dynamic> json) {
    userId = json['userId'];
    orderId = json['orderId'];
    userName = json['userName'];
    userImage = json['userImage'];
    userImageHash = json['userImageHash'];
    userLocation = json['userLocation'];
    userReceipt = json['userReceipt'];
    userHashReceipt = json['userHashReceipt'];
    processStatus = json['processStatus'];
    orderType = json['orderType'];
    list = [];
    json['cartList'].forEach((item) {
      list!.add(Product.fromCartList(item));
    });
  }

  Map<String, dynamic> upload() {
    Map<String, dynamic> map = {};
    map["userId"] = userId;
    map["userName"] = userName;
    map["userImage"] = userImage;
    map["userImageHash"] = userImageHash;
    map["userLocation"] = userLocation;
    map["userReceipt"] = userReceipt;
    map["userHashReceipt"] = userHashReceipt;
    map["processStatus"] = Const.notConfirmed;
    map["orderType"] = orderType;
    if (list != null) {
      map['cartList'] = list!.map((e) => e.toCartList()).toList();
    }
    return map;
  }

  Map<String, dynamic> updateProcess() {
    Map<String, dynamic> map = {};
    map["orderId"] = orderId;
    map['processStatus'] = processStatus;
    return map;
  }
}
