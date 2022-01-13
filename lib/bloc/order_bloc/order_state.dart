import 'package:cloud_firestore/cloud_firestore.dart';

class OrderState {}

class InitialOrder extends OrderState {}

class InitGetIncomingLoading extends OrderState {}

class InitGetOutcomingLoading extends OrderState {}

class IncomingUpdating extends OrderState {
  final int index;

  IncomingUpdating(this.index);
}

class IncomingUpdated extends OrderState {
  final int index;

  IncomingUpdated(this.index);
}

class InitGetIncomingLoaded extends OrderState {
  final Stream<QuerySnapshot>? orderStream;

  InitGetIncomingLoaded(this.orderStream);
}

class InitGetOutcomingLoaded extends OrderState {
  final Stream<QuerySnapshot>? orderStream;

  InitGetOutcomingLoaded(this.orderStream);
}

class OrderFailed extends OrderState {
  final String error;

  OrderFailed(this.error);
}
