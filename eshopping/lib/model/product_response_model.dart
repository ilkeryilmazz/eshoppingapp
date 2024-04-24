class ProductResponseModel {
  List<Data>? data;
  bool? success;
  String? message;

  ProductResponseModel({this.data, this.success, this.message});

  ProductResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  int? categoryId;
  String? name;
  String? description;
  int? price;
  String? imageUrl;
  int? unitsInStock;

  Data(
      {this.id,
      this.categoryId,
      this.name,
      this.description,
      this.price,
      this.imageUrl,
      this.unitsInStock});

  Data.fromJson(Map<String, dynamic> json) {
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
