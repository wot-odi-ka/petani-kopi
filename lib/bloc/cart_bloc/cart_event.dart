import 'package:flutter/cupertino.dart';
import 'package:petani_kopi/model/shoplist.dart';

@immutable
abstract class CartEvent {}

class InitCartShopList extends CartEvent {}

class GetCartItem extends CartEvent {
  final ShopList model;

  GetCartItem(this.model);
}
