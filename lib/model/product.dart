import 'dart:io';

class Product {
  String? namaProduct;
  String? jenisProduct;
  String? descProduct;
  String? hargaProduct;
  String? imageHas;
  String? imageUrlProduct;

  String? userId;
  String? productId;

  File? file;

  Product({
    this.namaProduct,
    this.jenisProduct,
    this.descProduct,
    this.hargaProduct,
    this.imageHas,
    this.imageUrlProduct,
    this.file,
    this.userId,
    this.productId,
  });

  Map<String, dynamic> toMapProducts() {
    Map<String, dynamic> map = {};
    map["namaProduct"] = namaProduct;
    map["jenisProduct"] = jenisProduct;
    map["descProduct"] = descProduct;
    map["hargaProduct"] = hargaProduct;
    map["imageHas"] = imageHas;
    map["imageUrlProduct"] = imageUrlProduct;
    map["productId"] = productId;
    return map;
  }
}
