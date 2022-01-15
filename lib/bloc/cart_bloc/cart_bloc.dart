import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petani_kopi/bloc/cart_bloc/cart_event.dart';
import 'package:petani_kopi/bloc/cart_bloc/cart_state.dart';
import 'package:petani_kopi/firebase_query.dart/product_query.dart';
import 'package:petani_kopi/helper/utils.dart';
import 'package:petani_kopi/model/cart_model.dart';
import 'package:petani_kopi/model/incoming_oder.dart';
import 'package:petani_kopi/model/order.dart';
import 'package:petani_kopi/model/order_model.dart';
import 'package:petani_kopi/model/shoplist.dart';
import 'package:petani_kopi/model/users.dart';
import 'package:petani_kopi/service/database.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  Users user = Users();
  List<CartModel> carts = [];
  Stream<QuerySnapshot>? cartStream;
  Stream<QuerySnapshot>? shopStream;

  CartBloc() : super(CartInitial()) {
    on<CartEvent>((event, emit) => start(event, emit));
  }

  start(CartEvent event, Emitter<CartState> emit) async {
    try {
      user = await DB.getUser();
      if (event is InitCartShopList) {
        emit(InitCartOnLoading());
        await getCartItems();
        emit(InitCartLoaded(carts));
      } else if (event is GetCartItem) {
        emit(InitCartOnLoading());
        await getCartList(event.model);
        emit(CartItemLoaded(cartStream!));
      } else if (event is CartListDeleteEvent) {
        emit(CartDeleting());
        await updateCart(event.model);
        emit(CartDeleted());
      } else if (event is PaymentSubmitEvent) {
        emit(PaymentSubmitting(event.model.index!));
        await uploadOrders(event.model);
        await deleteCart(event.model);
        emit(PaymentSubmitted(event.model.index!));
      }
    } catch (e) {
      emit(CartOnFailed(e.toString()));
    }
  }

  Future<void> getShopList() async {
    shopStream = await ProductQuery.getShopList(user);
  }

  Future<void> getCartList(ShopList model) async {
    cartStream = await ProductQuery.getCartItem(user, model);
  }

  Future<void> getCartItems() async {
    carts = await ProductQuery.getCartList(user.userId!);
  }

  Future<void> updateCart(CartModel model) async {
    if (model.list!.isEmpty) {
      await ProductQuery.deleteCartAll(model, user.userId!);
    } else {
      await ProductQuery.newCart(model, user.userId!);
    }
  }

  Future<void> uploadOrder(CartModel model) async {
    if (model.receiptFile != null) {
      model.receiptUrl = await singleUpload(model.receiptFile!);
      var myOrder = IncomingOrder.fromCart(model.toOrder());
      String outOrderId = await ProductQuery.uploadMyOrder(
        myOrder,
        user.userId!,
      );
      var inOrder = IncomingOrder.inOrder(
        user.toMap(),
        shopID: model.shopId!,
        cartList: model.list!,
        receiptHash: model.receiptHash!,
        receiptUrl: model.receiptUrl!,
        outOrderId: outOrderId,
      );
      await ProductQuery.uploadInOrder(inOrder, user.userId!);
    } else {
      throw 'No Receipt';
    }
  }

  Future<void> deleteCart(CartModel model) async {
    bool isEqual = await ProductQuery.checkCart(model, user.userId!);
    if (isEqual) {
      await ProductQuery.deleteCartAll(model, user.userId!);
    } else {
      await ProductQuery.deleteCartOnList(model, user.userId!);
    }
  }

  Future<void> uploadOrders(CartModel model) async {
    if (model.receiptFile != null) {
      model.receiptUrl = await singleUpload(model.receiptFile!);
      var outcoming = OrderSubmit.outcoming(model.toOrder());
      var incoming = OrderSubmit.incoming(
        json: model.toOrder(),
        userMap: user.toMap(),
      );
      incoming.userId = model.shopId;
      outcoming.userId = user.userId;
      await ProductQuery.uploadOrder(incoming, outcoming);
    } else {
      throw 'No Receipt';
    }
  }
}
