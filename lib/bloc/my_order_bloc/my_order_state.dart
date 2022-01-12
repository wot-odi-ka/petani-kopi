import 'package:petani_kopi/model/users.dart';

class MyOrderState {}

class MyOrderInitial extends MyOrderState {}

class InitialMyOrderLoading extends MyOrderState {}

class InitalMyOrderLoaded extends MyOrderState {}

class InitMyOrderDone extends MyOrderState {
  final Users user;

  InitMyOrderDone(this.user);
}

class MyOrderFiled extends MyOrderState {
  final String error;

  MyOrderFiled(this.error);
}
