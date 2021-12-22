import 'package:petani_kopi/model/users.dart';

class RegisterState {}

class InitialRegister extends RegisterState {}

class RegisterOnLoading extends RegisterState {}

class RegisterOnLogin extends RegisterState {}

class RegisterComplete extends RegisterState {
  final Users user;

  RegisterComplete(this.user);
}

class RegisterFailed extends RegisterState {
  final String error;

  RegisterFailed(this.error);
}
