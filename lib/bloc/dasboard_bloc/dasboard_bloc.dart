import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petani_kopi/bloc/dasboard_bloc/dasboard_event.dart';
import 'package:petani_kopi/bloc/dasboard_bloc/dasboard_state.dart';
import 'package:petani_kopi/model/product.dart';
import 'package:petani_kopi/service/database.dart';

class DasboardBloc extends Bloc<DasboardEvent, DasboardState> {
  String? url;
  String? hash;
  Product product = Product();
  DasboardBloc() : super(DasboardInitialState()) {
    on<DasboardEvent>((event, emit) => start(event, emit));
  }

  start(DasboardEvent event, Emitter<DasboardState> emit) async {
    try {
      if (event is DasboardInitialEvent) {
        emit(DasboardOnloadedState());
        product = await DB.getUser();
        emit(DasboardOnlodingState());
      }
    } catch (e) {
      emit(DasboardFiled(e.toString()));
    }
  }
}
