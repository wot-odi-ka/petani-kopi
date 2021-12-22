import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petani_kopi/bloc/register_bloc/register_event.dart';
import 'package:petani_kopi/bloc/register_bloc/register_state.dart';
import 'package:petani_kopi/firebase_query.dart/login_query.dart';
import 'package:petani_kopi/helper/constants.dart';
import 'package:petani_kopi/model/users.dart';
import 'package:petani_kopi/service/auth.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(InitialRegister()) {
    on<RegisterEvent>((event, emit) => start(event, emit));
  }

  start(RegisterEvent event, Emitter<RegisterState> emit) async {
    try {
      if (event is RegisterSubmit) {
        emit(RegisterOnLoading());
        var user = await onSubmit(event.user);
        emit(RegisterComplete(user));
      }
    } catch (e) {
      emit(RegisterFailed(e.toString()));
    }
  }

  onSubmit(Users user) async {
    bool emailIsExist = await LogQuery.checkMail(user.userMail!);
    bool nickIsExist = await LogQuery.checkName(user.userName!);
    if (emailIsExist) {
      throw 'Email has been used';
    } else if (nickIsExist) {
      throw 'Username has been used';
    } else {
      var id = await Auth.signUpWithEmail(user.userMail!, user.password!);
      user.userId = id;
      user.userAlamat = Const.aboutMe;
      user.userImage = Const.emptyImage;
      user.userImageHash = Const.emptyHash;
      user.userIsSeller = false;
      await LogQuery.uploadUser(user.toMap());
    }
    return user;
  }
}
