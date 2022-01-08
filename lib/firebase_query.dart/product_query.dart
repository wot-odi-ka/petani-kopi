import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petani_kopi/firebase_query.dart/query_key.dart';
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
}
