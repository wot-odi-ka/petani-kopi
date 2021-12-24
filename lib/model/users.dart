import 'dart:io';

class Users {
  String? userId;
  String? userName;
  String? userMail;
  String? userImage;
  String? userImageHash;
  String? password;
  String? userPhone;
  String? userAlamat;
  String? userCity;
  String? noRekening;
  String? rekening;
  bool? userIsSeller;

  //helper
  File? file;

  Users({
    this.userId,
    this.userName,
    this.userMail,
    this.userImage,
    this.userImageHash,
    this.password,
    this.userPhone,
    this.userAlamat,
    this.userCity,
    this.noRekening,
    this.rekening,
    this.userIsSeller,

    //helper
    this.file,
  });

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
    map["userCity"] = userCity;
    map["noRekening"] = noRekening;
    map["rekening"] = rekening;
    return map;
  }

  Users.map(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    userMail = json['userMail'];
    userImage = json['userImage'];
    userImageHash = json['userImageHash'];
    userPhone = json['userPhone'];
    userAlamat = json['userAlamat'];
    userCity = json['userCity'];
    noRekening = json['noRekening'];
    rekening = json['rekening'];
    userIsSeller = json['userIsSeller'];
  }
}
