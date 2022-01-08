import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petani_kopi/bloc/cart_bloc/cart_event.dart';
import 'package:petani_kopi/bloc/cart_bloc/cart_state.dart';
import 'package:petani_kopi/firebase_query.dart/product_query.dart';
import 'package:petani_kopi/model/users.dart';
import 'package:petani_kopi/service/database.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  Users user = Users();
  Stream<QuerySnapshot>? shopStream;
  CartBloc() : super(CartInitial()) {
    on<CartEvent>((event, emit) => start(event, emit));
  }

  start(CartEvent event, Emitter<CartState> emit) async {
    try {
      user = await DB.getUser();
      if (event is InitCartShopList) {
        emit(InitCartOnLoading());
        await getShopList();
        emit(InitCartLoaded(shopStream!));
      }
    } catch (e) {
      emit(CartOnFailed(e.toString()));
    }
  }

  Future<void> getShopList() async {
    shopStream = await ProductQuery.getShopList(user);
  }
}
