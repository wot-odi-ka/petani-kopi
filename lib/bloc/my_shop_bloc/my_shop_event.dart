import 'package:petani_kopi/model/product.dart';

class MyShopEvent {}

class InitShopProducts extends MyShopEvent {
  final String searchVal;
  final String coffeeType;

  InitShopProducts(this.searchVal, this.coffeeType);
}

class GetProductById extends MyShopEvent {
  final String productId;

  GetProductById(this.productId);
}

class DeleteProductById extends MyShopEvent {
  final Product product;
  final int index;

  DeleteProductById(this.product, this.index);
}
