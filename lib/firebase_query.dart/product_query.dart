import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petani_kopi/firebase_query.dart/query_key.dart';
import 'package:petani_kopi/model/product.dart';

class ProductQuery {
  static updateProduct(Product product) async {
    await FirebaseFirestore.instance
        .collection(Col.product)
        .doc(product.userId)
        .collection(Col.productList)
        .add(product.toMapProducts())
        .then((value) {
      value.update({'productId': value.id});
    }).catchError((e) => throw e);
  }
}
