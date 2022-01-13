import 'package:flutter/cupertino.dart';
import 'package:petani_kopi/model/cart_model.dart';
import 'package:petani_kopi/model/shoplist.dart';

@immutable
abstract class CartEvent {}

class InitCartShopList extends CartEvent {}

class GetCartItem extends CartEvent {
  final ShopList model;

  GetCartItem(this.model);
}

class CartListDeleteEvent extends CartEvent {
  final CartModel model;

  CartListDeleteEvent(this.model);
}

class PaymentSubmitEvent extends CartEvent {
  final CartModel model;

  PaymentSubmitEvent(this.model);
}
