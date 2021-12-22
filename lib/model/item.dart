class Item {
  final String name;
  final String brand;
  final String imageURL;
  final int price;

  Item(this.name, this.brand, this.imageURL, this.price);

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(json["name"], json["brand"], json["imageURL"], json["price"]);
  }
}
