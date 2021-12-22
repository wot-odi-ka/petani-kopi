import 'package:petani_kopi/model/users.dart';

class ProfilState {}

class ProfilInitial extends ProfilState {}

class ProfilOnLoading extends ProfilState {}

class ProfileUpdated extends ProfilState {
  final Users newUser;

  ProfileUpdated(this.newUser);
}

class InitUserProfileDone extends ProfilState {
  final Users user;

  InitUserProfileDone(this.user);
}

class UserProfileFailed extends ProfilState {
  final String error;

  UserProfileFailed(this.error);
}
