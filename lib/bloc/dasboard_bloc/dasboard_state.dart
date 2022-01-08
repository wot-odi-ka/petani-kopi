import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petani_kopi/model/product.dart';

class DasboardState {}

class DasboardInitialState extends DasboardState {}

class DasboardOnlodingState extends DasboardState {}

class AddCartSubmittin extends DasboardState {}

class AddCartSubmitted extends DasboardState {}

class DasboardOnloadedState extends DasboardState {
  final Stream<QuerySnapshot> products;

  DasboardOnloadedState(this.products);
}

class GetProductSucsess extends DasboardState {
  final Product products;

  GetProductSucsess(this.products);
}

class DasboardFiled extends DasboardState {
  final String error;

  DasboardFiled(this.error);
}
