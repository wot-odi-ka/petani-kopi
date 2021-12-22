import 'dart:io';

class Users {
  String? userId;
  String? userName;
  String? userMail;
  String? userImage;
  String? userImageHash;
  String? userProfile;
  String? password;
  bool? userIsSeller;
  String? userPhone;
  String? userAlamat;

  File? file;

  Users(
      {this.userId,
      this.userName,
      this.userMail,
      this.userImage,
      this.userImageHash,
      this.userProfile,
      this.password,
      this.userIsSeller,
      this.userPhone,
      this.file,
      this.userAlamat});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["userId"] = userId;
    map["userName"] = userName;
    map["userMail"] = userMail;
    map["userImage"] = userImage;
    map["userImageHash"] = userImageHash;
    map["userIsSeller"] = userIsSeller;
    map["userPhone"] = userPhone;
    map["userAlamat"] = userAlamat;
    return map;
  }

  Users.map(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    userMail = json['userMail'];
    userImage = json['userImage'];
    userImageHash = json['userImageHash'];
    userProfile = json['userProfile'];
    userIsSeller = json['userIsSeller'];
    userPhone = json['userPhone'];
    password = json['password'];
    file = json['file'];
    userAlamat = json['userAlamat'];
  }
}
