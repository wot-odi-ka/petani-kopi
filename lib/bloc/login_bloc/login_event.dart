class LoginEvent {}

class LoginOnSubmit extends LoginEvent {
  final Map<String, dynamic> data;

  LoginOnSubmit(this.data);
}

class ForgotPassOnSubmit extends LoginEvent {
  final Map<String, dynamic> data;

  ForgotPassOnSubmit(this.data);
}
