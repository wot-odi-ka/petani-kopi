import 'package:petani_kopi/bloc/profil_block/profil_event.dart';
import 'package:petani_kopi/model/product.dart';

class ProductEvent {}

class SubmitProduct extends ProductEvent {}

class RegisterProduct extends ProductEvent {
  final Product product;

  RegisterProduct(this.product);
}
