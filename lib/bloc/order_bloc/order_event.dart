import 'package:petani_kopi/model/order_model.dart';

class OrderEvent {}

class InitGetIncomingOrder extends OrderEvent {}

class InitGetOutComingOrder extends OrderEvent {
  final String orderStatus;

  InitGetOutComingOrder(this.orderStatus);
}

class IncomingOrderUpdateStatus extends OrderEvent {
  final Order order;

  IncomingOrderUpdateStatus(this.order);
}
