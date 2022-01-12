class OrderList {
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
  String? totalPrice;

  OrderList({
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
    this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["userId"] = userId;
    map["userName"] = userName;
    map["userMail"] = userMail;
    map["userImage"] = userImage;
    map["userImageHash"] = userImageHash;
    map["userPhone"] = userPhone;
    map["userAlamat"] = userAlamat;
    map["userCity"] = userCity;
    map["noRekening"] = noRekening;
    map["rekening"] = rekening;
    map["totalPrice"] = totalPrice;
    return map;
  }

  OrderList.map(Map<String, dynamic> json) {
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
    totalPrice = json['totalPrice'];
  }
}
