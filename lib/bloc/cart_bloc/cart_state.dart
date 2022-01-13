import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petani_kopi/model/cart_model.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class InitCartOnLoading extends CartState {}

class CartDeleting extends CartState {}

class PaymentSubmitting extends CartState {
  final int index;

  PaymentSubmitting(this.index);
}

class PaymentSubmitted extends CartState {
  final int index;

  PaymentSubmitted(this.index);
}

class InitCartLoaded extends CartState {
  // final Stream<QuerySnapshot> shops;
  final List<CartModel> carts;

  InitCartLoaded(this.carts);
}

class CartItemLoaded extends CartState {
  final Stream<QuerySnapshot> carts;

  CartItemLoaded(this.carts);
}

class CartDeleted extends CartState {}

class ShopListDeleted extends CartState {}

class CartOnFailed extends CartState {
  final String error;

  CartOnFailed(this.error);
}
