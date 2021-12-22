import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petani_kopi/firebase_query.dart/query_key.dart';
import 'package:petani_kopi/model/users.dart';
import 'package:petani_kopi/service/auth.dart';
import 'package:petani_kopi/service/database.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  Users user = Users();
  AuthBloc() : super(InitialAuth()) {
    on<AuthEvent>((event, emit) => start(event, emit));
  }

  start(AuthEvent event, Emitter<AuthState> emit) async {
    try {
      user = await DB.getUser();
      if (event is InitAuthEvent) {
        bool isLogin = await DB.checkLogin();
        if (isLogin) emit(IsLoggedIn());
      } else if (event is AuthLogout) {
        await doLogout();
        emit(LogoutDone());
      }
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  doLogout() async {
    Map<String, dynamic> map = user.toMap();
    map[UserKey.onlineStatus] = false;
    await Auth.signOut();
    await DB.clear();
  }
}
