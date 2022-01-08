import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class InitCartOnLoading extends CartState {}

class InitCartLoaded extends CartState {
  final Stream<QuerySnapshot> shops;

  InitCartLoaded(this.shops);
}

class ShopListDeleted extends CartState {}

class CartOnFailed extends CartState {
  final String error;

  CartOnFailed(this.error);
}
