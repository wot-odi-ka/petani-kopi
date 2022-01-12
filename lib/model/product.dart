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
  bool? isChecked;

  //cart
  String? totalPrice;
  String? itemCount;

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
    this.isChecked = false,

    //cart
    this.totalPrice,
    this.itemCount,

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
    userName = json['userName'];
    userImageHash = json['userImageHash'];
    userCity = json['userCity'];
    userId = json['userId'];
    if (json['imagesHash'].isNotEmpty) {
      imagesHash = [];
      json['imagesHash'].forEach((e) {
        imagesHash!.add(e);
      });
    }
    if (json['imagesUrl'].isNotEmpty) {
      imagesUrl = [];
      json['imagesUrl'].forEach((e) {
        imagesUrl!.add(e);
      });
    }
    if (json['imagesUrl'].isNotEmpty) {
      nameSearch = [];
      json['nameSearch'].forEach((e) {
        nameSearch!.add(e);
      });
    }
    if (json['imagesUrl'].isNotEmpty) {
      productSearch = [];
      json['productSearch'].forEach((e) {
        productSearch!.add(e);
      });
    }
  }

  Map<String, dynamic> toCart() {
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
    map["totalPrice"] = totalPrice;
    map["itemCount"] = itemCount;
    return map;
  }

  Product.fromCart(Map<String, dynamic> json) {
    productId = json['productId'];
    namaProduct = json['namaProduct'];
    descProduct = json['descProduct'];
    hargaProduct = json['hargaProduct'];
    jenisKopi = json['jenisKopi'];
    userImage = json['userImage'];
    userName = json['userName'];
    userImageHash = json['userImageHash'];
    userCity = json['userCity'];
    userId = json['userId'];
    totalPrice = json['totalPrice'];
    itemCount = json['itemCount'];
    if (json['imagesHash'].isNotEmpty) {
      imagesHash = [];
      json['imagesHash'].forEach((e) {
        imagesHash!.add(e);
      });
    }
    if (json['imagesUrl'].isNotEmpty) {
      imagesUrl = [];
      json['imagesUrl'].forEach((e) {
        imagesUrl!.add(e);
      });
    }
    if (json['nameSearch'].isNotEmpty) {
      nameSearch = [];
      json['nameSearch'].forEach((e) {
        nameSearch!.add(e);
      });
    }
    if (json['productSearch'].isNotEmpty) {
      productSearch = [];
      json['productSearch'].forEach((e) {
        productSearch!.add(e);
      });
    }
  }

  Map<String, dynamic> toCartList() {
    Map<String, dynamic> map = {};
    map["namaProduct"] = namaProduct;
    map["descProduct"] = descProduct;
    map["hargaProduct"] = hargaProduct;
    map["jenisKopi"] = jenisKopi;
    map["imagesHash"] = imagesHash;
    map["imagesUrl"] = imagesUrl;
    map["productId"] = productId;
    map["totalPrice"] = totalPrice;
    map["itemCount"] = itemCount;
    return map;
  }

  Product.fromCartList(Map<String, dynamic> json) {
    productId = json['productId'];
    namaProduct = json['namaProduct'];
    descProduct = json['descProduct'];
    hargaProduct = json['hargaProduct'];
    jenisKopi = json['jenisKopi'];
    totalPrice = json['totalPrice'];
    itemCount = json['itemCount'];
    isChecked = false;
    if (json['imagesHash'].isNotEmpty) {
      imagesHash = [];
      json['imagesHash'].forEach((e) {
        imagesHash!.add(e);
      });
    }
    if (json['imagesUrl'].isNotEmpty) {
      imagesUrl = [];
      json['imagesUrl'].forEach((e) {
        imagesUrl!.add(e);
      });
    }
  }
}
