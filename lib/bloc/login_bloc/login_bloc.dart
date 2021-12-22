import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petani_kopi/bloc/login_bloc/login_event.dart';
import 'package:petani_kopi/bloc/login_bloc/login_state.dart';
import 'package:petani_kopi/firebase_query.dart/login_query.dart';
import 'package:petani_kopi/helper/constants.dart';
import 'package:petani_kopi/model/users.dart';
import 'package:petani_kopi/service/auth.dart';
import 'package:petani_kopi/service/database.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) => start(event, emit));
  }

  start(LoginEvent event, Emitter<LoginState> emit) async {
    try {
      if (event is LoginOnSubmit) {
        emit(LoginOnProgress());
        await submitting(event.data);
        emit(LoginSuccess());
      }
    } catch (e) {
      emit(LoginFailed(e.toString()));
    }
  }

  submitting(map) async {
    var id = await Auth.signInWithEmail(
      mail: map[Const.email],
      pass: map[Const.pass],
    );
    Users result = await LogQuery.getUsersById(id);
    await DB.saveUser(result);
  }

  // getFriendList(String id) async {
  //   List<String>? roomIds = await ChatQuery.getRoomList(id);
  //   if (roomIds != null) await DB.initChatRoom(roomIds);
  // }

  // updateOnline(Users user) async {
  //   Map<String, dynamic> map = user.toMap();
  //   map[UserKey.onlineStatus] = true;
  //   await LogQuery.updateOnline(map);
  // }

}
