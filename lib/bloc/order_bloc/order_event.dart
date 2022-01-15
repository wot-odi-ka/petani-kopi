import 'package:petani_kopi/model/order.dart';
import 'package:petani_kopi/model/order_model.dart';

class OrderEvent {}

class InitGetIncomingOrder extends OrderEvent {}

class InitGetOutComingOrder extends OrderEvent {
  final String orderStatus;

  InitGetOutComingOrder(this.orderStatus);
}

class IncomingOrderUpdateStatus extends OrderEvent {
  final OrderSubmit order;

  IncomingOrderUpdateStatus(this.order);
}

class DeleteOrderEvent extends OrderEvent {
  final OrderSubmit order;

  DeleteOrderEvent(this.order);
}
