import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petani_kopi/firebase_query.dart/query_key.dart';
import 'package:petani_kopi/helper/utils.dart';
import 'package:petani_kopi/model/cart_model.dart';
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
          // .where('userId', isEqualTo: map['userId'])
          .where('jenisKopi', isEqualTo: map['jenisKopi'])
          .where('productSearch', arrayContains: map['searchVal'])
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection(Col.product)
          // .where('userId', isEqualTo: map['userId'])
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

  static addCartList(CartModel model, String userId) {
    List<Map<String, dynamic>> mapList = [];
    mapList.addAll(model.list!.map((e) => e.toCart()).toList());
    FirebaseFirestore.instance
        .collection(Col.cart)
        .doc(userId)
        .collection(Col.cartItem)
        .doc(model.shopId)
        .update({
      'cartList': FieldValue.arrayUnion(mapList),
    }).catchError((e) => throw e);
  }
}
