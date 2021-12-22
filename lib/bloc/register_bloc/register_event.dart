import 'package:petani_kopi/model/users.dart';

class RegisterEvent {}

class RegisterSubmit extends RegisterEvent {
  final Users user;

  RegisterSubmit(this.user);
}
