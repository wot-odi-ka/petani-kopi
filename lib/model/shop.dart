class Shop {
  String? shopDesc;
  String? shopImage;
  String? shopImageHas;
  String? shopName;

  Shop({
    this.shopDesc,
    this.shopImage,
    this.shopImageHas,
    this.shopName,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["shopDesc"] = shopDesc;
    map["shopImage"] = shopImage;
    map["shopImageHas"] = shopImageHas;
    map["shopName"] = shopName;
    return map;
  }

  Shop.map(Map<String, dynamic> json) {
    shopDesc = json['shopDesc'];
    shopImage = json['shopImage'];
    shopImageHas = json['shopImageHas'];
    shopName = json['shopName'];
  }
}
