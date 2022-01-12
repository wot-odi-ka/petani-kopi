import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petani_kopi/bloc/my_order_bloc/my_order_event.dart';
import 'package:petani_kopi/bloc/my_order_bloc/my_order_state.dart';
import 'package:petani_kopi/model/users.dart';
import 'package:petani_kopi/service/database.dart';

class MyOrderBloc extends Bloc<MyOrderEvent, MyOrderState> {
  Users users = Users();
  MyOrderBloc() : super(MyOrderInitial()) {
    on<MyOrderEvent>((event, emit) => start(event, emit));
  }

  start(MyOrderEvent event, Emitter<MyOrderState> emit) async {
    try {
      if (event is InitialMyOrderEvent) {
        emit(InitialMyOrderLoading());
        users = await DB.getUser();
        emit(InitMyOrderDone(users));
      } else if (event is MyOrderUpdatedStatus) {}
    } catch (e) {
      emit(MyOrderFiled(e.toString()));
    }
  }
}
