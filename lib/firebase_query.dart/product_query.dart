import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petani_kopi/firebase_query.dart/query_key.dart';
import 'package:petani_kopi/helper/constants.dart';
import 'package:petani_kopi/helper/utils.dart';
import 'package:petani_kopi/model/cart_model.dart';
import 'package:petani_kopi/model/incoming_oder.dart';
import 'package:petani_kopi/model/order.dart';
import 'package:petani_kopi/model/order_model.dart';
import 'package:petani_kopi/model/orderitemlist.dart';
import 'package:petani_kopi/model/product.dart';
import 'package:petani_kopi/model/shoplist.dart';
import 'package:petani_kopi/model/users.dart';

class ProductQuery {
  static updateProduct(Product product) async {
    await FirebaseFirestore.instance
        .collection(Col.product)
        .doc(product.userId)
        .collection(Col.productList)
        .add(product.toMapProducts())
        .then((value) async {
      value.update({ProdKey.productId: value.id});
      product.productId = value.id;
      var col = FirebaseFirestore.instance.collection(Col.productSearch);
      await col.doc(product.productId).set(product.toSearch());
    }).catchError((e) => throw e);
  }

  static uploadProduct(Product product) async {
    await FirebaseFirestore.instance
        .collection(Col.product)
        .add(product.toSearch())
        .then((value) => value.update({ProdKey.productId: value.id}))
        .catchError((e) => throw e);
  }

  static getProfileProduct(Map<String, dynamic> map) async {
    String type = map['jenisKopi'];
    if (type.isNotEmpty) {
      return FirebaseFirestore.instance
          .collection(Col.product)
          .where('userId', isEqualTo: map['userId'])
          .where('jenisKopi', isEqualTo: map['jenisKopi'])
          .where('productSearch', arrayContains: map['searchVal'])
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection(Col.product)
          .where('userId', isEqualTo: map['userId'])
          .where('productSearch', arrayContains: map['searchVal'])
          .snapshots();
    }
  }

  static getDashboardProduct(Map<String, dynamic> map) async {
    String type = map['jenisKopi'];
    if (type.isNotEmpty) {
      return FirebaseFirestore.instance
          .collection(Col.product)
          // .where('userId', isNotEqualTo: map['userId'])
          .where('jenisKopi', isEqualTo: map['jenisKopi'])
          .where('productSearch', arrayContains: map['searchVal'])
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection(Col.product)
          // .where('userId', isNotEqualTo: map['userId'])
          .where('productSearch', arrayContains: map['searchVal'])
          .snapshots();
    }
  }

  static getProductById(String productId) async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection(Col.product)
        .where(ProdKey.productId, isEqualTo: productId)
        .get()
        .catchError((e) => throw e);

    var map = snap.docs[0].data() as Map<String, dynamic>;

    return Product.fromSearch(map);
  }

  static deleteProduct(Product product) async {
    return FirebaseFirestore.instance
        .collection(Col.product)
        .doc(product.productId)
        .delete();
  }

  static addShopList(ShopList model, Users user) async {
    int oldPrice = int.parse(model.totalPrice!.replaceAll('.', ''));
    int sumResult = 0;

    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection(Col.cart)
        .doc(user.userId)
        .collection(Col.cartItem)
        .where('userId', isEqualTo: model.userId)
        .get()
        .catchError((e) => throw e);
    if (snap.docs.isNotEmpty) {
      for (var element in snap.docs) {
        var map = element.data() as Map<String, dynamic>;
        int current = int.parse(map['totalPrice'].replaceAll('.', ''));
        sumResult = current + oldPrice;
      }
      model.totalPrice = setupSeparator(sumResult);
    }

    await FirebaseFirestore.instance
        .collection(Col.cart)
        .doc(user.userId)
        .collection(Col.shopList)
        .doc(model.userId)
        .set(model.toMap())
        .catchError((e) => throw e);
  }

  static addOrderList(OrderList model, Users user) async {
    await FirebaseFirestore.instance
        .collection(Col.cart)
        .doc(user.userId)
        .collection(Col.shopList)
        .doc(model.userId)
        .set(model.toMap())
        .catchError((e) => throw e);
  }

  static uploadCart(Product product, Users user) async {
    await FirebaseFirestore.instance
        .collection(Col.cart)
        .doc(user.userId)
        .collection(Col.cartItem)
        .add(product.toCart())
        .catchError((e) => throw e);
  }

  static getShopList(Users user) {
    return FirebaseFirestore.instance
        .collection(Col.cart)
        .doc(user.userId)
        .collection(Col.shopList)
        .snapshots();
  }

  static cartDeleteAll(Users user, ShopList model) {
    return FirebaseFirestore.instance
        .collection(Col.cart)
        .doc(user.userId)
        .collection(Col.cartItem)
        .where('userId', isEqualTo: model.userId)
        .get()
        .then((value) async {
      for (var element in value.docs) {
        await element.reference.delete();
      }
    });
  }

  static getCartItem(Users user, ShopList model) {
    return FirebaseFirestore.instance
        .collection(Col.cart)
        .doc(user.userId)
        .collection(Col.cartItem)
        .where('userId', isEqualTo: model.userId)
        .snapshots();
  }

  static Future<bool> cartIsEmpty(String userId, String shopId) async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection(Col.cart)
        .doc(userId)
        .collection(Col.cartItem)
        .where('shopId', isEqualTo: shopId)
        .get()
        .catchError((e) => throw e);

    return snap.docs.isEmpty;
  }

  static newCart(CartModel model, String userId) {
    FirebaseFirestore.instance
        .collection(Col.cart)
        .doc(userId)
        .collection(Col.cartItem)
        .doc(model.shopId)
        .set(model.toMap())
        .catchError((e) => throw e);
  }

  static deleteCartAll(CartModel model, String userId) {
    FirebaseFirestore.instance
        .collection(Col.cart)
        .doc(userId)
        .collection(Col.cartItem)
        .doc(model.shopId)
        .delete();
  }

  static addCartList(CartModel model, String userId) {
    List<Map<String, dynamic>> mapList = [];
    mapList.addAll(model.list!.map((e) => e.toCartList()).toList());
    FirebaseFirestore.instance
        .collection(Col.cart)
        .doc(userId)
        .collection(Col.cartItem)
        .doc(model.shopId)
        .update({
      'cartList': FieldValue.arrayUnion(mapList),
    }).catchError((e) => throw e);
  }

  static Future<List<CartModel>> getCartList(String userId) async {
    List<CartModel> models = [];
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection(Col.cart)
        .doc(userId)
        .collection(Col.cartItem)
        .get()
        .catchError((e) => throw e);

    for (var i = 0; i < snap.docs.length; i++) {
      var map = snap.docs[i].data() as Map<String, dynamic>;
      models.add(CartModel.fromCartItem(map));
    }

    return models;
  }

  static Future<void> deleteCartOnList(CartModel model, String userId) async {
    List<Map<String, dynamic>> mapList = [];
    mapList.addAll(model.list!.map((e) => e.toCartList()).toList());
    FirebaseFirestore.instance
        .collection(Col.cart)
        .doc(userId)
        .collection(Col.cartItem)
        .doc(model.shopId)
        .update({
      'cartList': FieldValue.arrayRemove(mapList),
    }).catchError((e) => throw e);
  }

  static uploadInOrder(IncomingOrder model, String userId) async {
    await FirebaseFirestore.instance
        .collection(Col.incomingOrder)
        .doc(model.shopId)
        .collection(Col.orderList)
        .add(model.incomingOrder())
        .then((value) {
      value.update({'incomingOrderId': value.id});
    }).catchError((e) => throw e);
  }

  static uploadMyOrder(IncomingOrder model, String userId) async {
    return await FirebaseFirestore.instance
        .collection(Col.outComingOrder)
        .doc(userId)
        .collection(Col.orderList)
        .add(model.myOrder())
        .then((value) {
      value.update({'outComingOrderId': value.id});
      return value.id;
    }).catchError((e) => throw e);
  }

  static checkCart(CartModel model, String userId) async {
    List<CartModel> carts = [];
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection(Col.cart)
        .doc(userId)
        .collection(Col.cartItem)
        .where('shopId', isEqualTo: model.shopId)
        .get()
        .catchError((e) => throw e);

    for (var i = 0; i < snap.docs.length; i++) {
      var map = snap.docs[i].data() as Map<String, dynamic>;
      carts.add(CartModel.fromCartItem(map));
    }

    return carts[0].list!.length == model.list!.length;
  }

  static getIncomingOrder(Users user) {
    return FirebaseFirestore.instance
        .collection(Col.incomingOrder)
        .doc(user.userId)
        .collection(Col.orderList)
        .snapshots();
  }

  static getOutcomingOrder(Users user, String status) {
    if (status.isEmpty) {
      return FirebaseFirestore.instance
          .collection(Col.outComingOrder)
          .doc(user.userId)
          .collection(Col.orderList)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection(Col.outComingOrder)
          .doc(user.userId)
          .collection(Col.orderList)
          .where('userStatus', isEqualTo: status)
          .snapshots();
    }
  }

  static updateIncomingOrder(Users user, Order order) async {
    await FirebaseFirestore.instance
        .collection(Col.incomingOrder)
        .doc(user.userId)
        .collection(Col.orderList)
        .doc(order.incomingOrderId)
        .update({'userStatus': order.userStatus}).catchError((e) => throw e);
  }

  static updateOutcomingOrder(Order order) async {
    await FirebaseFirestore.instance
        .collection(Col.outComingOrder)
        .doc(order.userId)
        .collection(Col.orderList)
        .doc(order.outComingOrderId)
        .update({'userStatus': order.userStatus}).catchError((e) => throw e);
  }

  static uploadOrder(OrderSubmit order) async {
    await FirebaseFirestore.instance
        .collection(Col.order)
        .add(order.upload())
        .then((value) {
      value.update({'orderId': value.id});
    });
  }

  static getIncomingOrders(Users user) {
    return FirebaseFirestore.instance
        .collection(Col.order)
        .where('userId', isEqualTo: user.userId)
        .where('orderType', isEqualTo: Const.orderIncoming)
        .snapshots();
  }

  static getOutcomingOrders(Users user) {
    return FirebaseFirestore.instance
        .collection(Col.order)
        .where('userId', isEqualTo: user.userId)
        .where('orderType', isEqualTo: Const.orderOutcoming)
        .snapshots();
  }

  static updateOrder(Map<String, String> map) {
    return FirebaseFirestore.instance
        .collection(Col.order)
        .where('orderId', isEqualTo: map['orderId'])
        .get()
        .then((value) async {
      for (var element in value.docs) {
        await element.reference.update({'processStatus': map['processStatus']});
      }
    });
  }
}
