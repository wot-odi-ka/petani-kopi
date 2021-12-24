import 'package:petani_kopi/model/product.dart';

class ProductEvent {}

class SubmitProduct extends ProductEvent {
  final Product product;

  SubmitProduct(this.product);
}

class RegisterProduct extends ProductEvent {
  final Product product;

  RegisterProduct(this.product);
}
