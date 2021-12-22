class LoginState {}

class LoginInitial extends LoginState {}

class LoginOnProgress extends LoginState {}

class LoginSuccess extends LoginState{}

class LoginFailed extends LoginState{
  final String error;

  LoginFailed(this.error);
}