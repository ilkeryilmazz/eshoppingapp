class ProductDetailModel {
  int? id;
  int? categoryId;
  String? name;
  String? description;
  int? price;
  String? imageUrl;
  int? unitsInStock;

  ProductDetailModel(
      {this.id,
      this.categoryId,
      this.name,
      this.description,
      this.price,
      this.imageUrl,
      this.unitsInStock});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['categoryId'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    imageUrl = json['imageUrl'];
    unitsInStock = json['unitsInStock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryId'] = this.categoryId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['imageUrl'] = this.imageUrl;
    data['unitsInStock'] = this.unitsInStock;
    return data;
  }
}
