import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petani_kopi/bloc/pesanan_keluar_bloc/pesanan_keluar_event.dart';
import 'package:petani_kopi/bloc/pesanan_keluar_bloc/pesanan_keluar_state.dart';

class PesananKeluarBloc extends Bloc<PesananKeluarEvent, PesananKeluarState> {
  PesananKeluarBloc() : super(PesnanKeluarInitialstate()) {
    on<PesananKeluarEvent>((event, emit) => start(event, emit));
  }
  start(PesananKeluarEvent event, Emitter<PesananKeluarState> emit) {}
}
