class AuthState {}

class InitialAuth extends AuthState {}

class IsLoggedIn extends AuthState {}

class LogoutDone extends AuthState {}

class AuthFailed extends AuthState {
  final String error;

  AuthFailed(this.error);
}
