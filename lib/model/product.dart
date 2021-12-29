import 'dart:io';

import 'package:petani_kopi/helper/utils.dart';

class Product {
  String? namaProduct;
  String? descProduct;
  String? hargaProduct;
  String? jenisKopi;
  List<String>? imagesUrl;
  List<String>? imagesHash;
  String? productId;

  //helper
  List<File>? initImage;

  //productSearch
  List<String>? productSearch;
  List<String>? nameSearch;
  String? userId;
  String? userName;
  String? userImage;
  String? userImageHash;
  String? userCity;

  Product({
    this.namaProduct,
    this.descProduct,
    this.hargaProduct,
    this.imagesHash,
    this.imagesUrl,
    this.productId,
    this.jenisKopi,

    //helper
    this.userId,
    this.initImage,

    //productSearch
    this.nameSearch,
    this.productSearch,
    this.userCity,
    this.userImage,
    this.userImageHash,
  });

  Map<String, dynamic> toMapProducts() {
    Map<String, dynamic> map = {};
    map["namaProduct"] = namaProduct;
    map["descProduct"] = descProduct;
    map["hargaProduct"] = hargaProduct;
    map["jenisKopi"] = jenisKopi;
    map["imagesHash"] = imagesHash;
    map["imagesUrl"] = imagesUrl;
    map["productId"] = productId;
    return map;
  }

  Map<String, dynamic> toSearch() {
    Map<String, dynamic> map = {};
    map["namaProduct"] = namaProduct;
    map["descProduct"] = descProduct;
    map["hargaProduct"] = hargaProduct;
    map["jenisKopi"] = jenisKopi;
    map["imagesHash"] = imagesHash;
    map["imagesUrl"] = imagesUrl;
    map["productId"] = productId;
    map["userImage"] = userImage;
    map["userImageHash"] = userImageHash;
    map["userCity"] = userCity;
    map["userId"] = userId;
    map["nameSearch"] = generateSearchList(data: userName ?? '');
    map["productSearch"] = generateSearchList(data: namaProduct ?? '');
    return map;
  }

  Product.map(Map<String, dynamic> json) {
    namaProduct = json['namaProduct'];
    descProduct = json['descProduct'];
    hargaProduct = json['hargaProduct'];
    jenisKopi = json['jenisKopi'];
    productId = json['productId'];
    json['imagesHash'].forEach((e) {
      imagesHash = [];
      imagesHash!.add(e);
    });
    json['imagesUrl'].forEach((e) {
      imagesUrl = [];
      imagesUrl!.add(e);
    });
  }

  Product.fromSearch(Map<String, dynamic> json) {
    productId = json['productId'];
    namaProduct = json['namaProduct'];
    descProduct = json['descProduct'];
    hargaProduct = json['hargaProduct'];
    jenisKopi = json['jenisKopi'];
    userImage = json['userImage'];
    userImageHash = json['userImageHash'];
    userCity = json['userCity'];
    userId = json['userId'];
    json['imagesHash'].forEach((e) {
      imagesHash = [];
      imagesHash!.add(e);
    });
    json['imagesUrl'].forEach((e) {
      imagesUrl = [];
      imagesUrl!.add(e);
    });
    json['nameSearch'].forEach((e) {
      nameSearch = [];
      nameSearch!.add(e);
    });
    json['productSearch'].forEach((e) {
      productSearch = [];
      productSearch!.add(e);
    });
  }
}
