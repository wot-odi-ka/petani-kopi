import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petani_kopi/bloc/order_bloc/order_event.dart';
import 'package:petani_kopi/bloc/order_bloc/order_state.dart';
import 'package:petani_kopi/firebase_query.dart/product_query.dart';
import 'package:petani_kopi/model/order_model.dart';
import 'package:petani_kopi/model/users.dart';
import 'package:petani_kopi/service/database.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  Users user = Users();
  Stream<QuerySnapshot>? orderStream;
  OrderBloc() : super(InitialOrder()) {
    on<OrderEvent>((event, emit) => start(event, emit));
  }

  start(OrderEvent event, Emitter<OrderState> emit) async {
    try {
      user = await DB.getUser();
      if (event is InitGetIncomingOrder) {
        emit(InitGetIncomingLoading());
        await getIncomingOrders();
        emit(InitGetIncomingLoaded(orderStream));
      } else if (event is InitGetOutComingOrder) {
        emit(InitGetOutcomingLoading());
        await getOutComing(event.orderStatus);
        emit(InitGetOutcomingLoaded(orderStream));
      } else if (event is IncomingOrderUpdateStatus) {
        emit(IncomingUpdating(event.order.index ?? 0));
        await updateInOut(event.order);
        emit(IncomingUpdated(event.order.index ?? 0));
      }
    } catch (e) {
      emit(OrderFailed(e.toString()));
    }
  }

  Future<void> getIncoming() async {
    orderStream = await ProductQuery.getIncomingOrder(user);
  }

  Future<void> getIncomingOrders() async {
    orderStream = await ProductQuery.getIncomingOrders(user);
  }

  Future<void> getOutComing(String orderStatus) async {
    orderStream = await ProductQuery.getOutcomingOrder(user, orderStatus);
  }

  Future<void> updateInOut(Order order) async {
    await ProductQuery.updateIncomingOrder(user, order);
    await ProductQuery.updateOutcomingOrder(order);
  }
}
