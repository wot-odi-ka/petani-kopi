import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petani_kopi/model/product.dart';

class DasboardState {}

class DasboardInitialState extends DasboardState {}

class DasboardOnlodingState extends DasboardState {}

class DasboardOnloadedState extends DasboardState {
  final Stream<QuerySnapshot> products;

  DasboardOnloadedState(this.products);
}

class DasboardSucsess extends DasboardState {
  final Product products;

  DasboardSucsess(this.products);
}

class DasboardFiled extends DasboardState {
  final String error;

  DasboardFiled(this.error);
}
