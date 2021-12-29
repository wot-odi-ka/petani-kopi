import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petani_kopi/firebase_query.dart/query_key.dart';
import 'package:petani_kopi/model/product.dart';

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

  static deleteProduct(Product product) async {
    return FirebaseFirestore.instance
        .collection(Col.product)
        .doc(product.productId)
        .delete();
  }

  static Future<List<Product>> getRandomSearchProduct() async {
    List<Product> products = [];
    var col = FirebaseFirestore.instance.collection(Col.productSearch);
    QuerySnapshot snap = await col.get();
    for (var element in snap.docs) {
      var map = element.data() as Map<String, dynamic>;
      products.add(Product.fromSearch(map));
    }
    products.shuffle();
    return products;
  }
}

class ProductQueryHelper {
  static getAllDocumentId() async {
    List<String> result = [];
    var col = FirebaseFirestore.instance.collection(Col.productSearch);
    var snapshot = await col.get();
    for (var element in snapshot.docs) {
      result.add(element.id);
    }
    debugPrint(result.toString());
    return result;
  }
}
