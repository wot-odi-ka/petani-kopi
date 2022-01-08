import 'package:petani_kopi/model/product.dart';

class DasboardEvent {}

class DasboardInitialEvent extends DasboardEvent {
  final String searchVal;
  final String coffeeType;

  DasboardInitialEvent(this.searchVal, this.coffeeType);
}

class DasboardViewEvent extends DasboardEvent {
  final Product product;

  DasboardViewEvent(this.product);
}

class AddToCartEvent extends DasboardEvent {
  final Product product;

  AddToCartEvent(this.product);
}
