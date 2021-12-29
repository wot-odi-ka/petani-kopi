import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petani_kopi/model/product.dart';

class MyShopState {}

class MyShopInitial extends MyShopState {}

class InitMyShopOnLoading extends MyShopState {}

class GetProductIdOnLoading extends MyShopState {}

class ProductOnDeleting extends MyShopState {
  final int index;
  ProductOnDeleting(this.index);
}

class InitMyShopLoaded extends MyShopState {
  final Stream<QuerySnapshot> products;

  InitMyShopLoaded(this.products);
}

class GetProductLoaded extends MyShopState {
  final Product product;

  GetProductLoaded(this.product);
}

class ProductDeleted extends MyShopState {}

class MyShopFailed extends MyShopState {
  final String error;

  MyShopFailed(this.error);
}
