import 'dart:io';

class Product {
  String? namaProduct;
  String? descProduct;
  String? hargaProduct;
  List<String>? imagesUrl;
  List<String>? imagesHash;
  String? productId;

  String? userId;
  List<File>? initImage;

  Product({
    this.namaProduct,
    this.descProduct,
    this.hargaProduct,
    this.imagesHash,
    this.imagesUrl,
    this.userId,
    this.productId,
    this.initImage,
  });

  Map<String, dynamic> toMapProducts() {
    Map<String, dynamic> map = {};
    map["namaProduct"] = namaProduct;
    map["descProduct"] = descProduct;
    map["hargaProduct"] = hargaProduct;
    map["imagesHash"] = imagesHash;
    map["imagesUrl"] = imagesUrl;
    map["productId"] = productId;
    return map;
  }
}
