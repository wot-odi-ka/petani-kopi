import 'package:petani_kopi/model/product.dart';

class DasboardEvent {}

class DasboardInitialEvent extends DasboardEvent {}

class DasboardViewEvent extends DasboardEvent {
  final Product product;

  DasboardViewEvent(this.product);
}
