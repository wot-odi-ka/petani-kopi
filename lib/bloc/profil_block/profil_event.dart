import 'package:petani_kopi/model/users.dart';

class ProfilEvent {}

class ProfilInitEvent extends ProfilEvent {}

class SubmitUpdateProfile extends ProfilEvent {
  final Users user;
  SubmitUpdateProfile(this.user);
}
