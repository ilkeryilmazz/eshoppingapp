


//Api'dan dönen favorite 
class FavoriteDtoResponseModel {
  List<Data>? data;
  bool? success;
  Null? message;

  FavoriteDtoResponseModel({this.data, this.success, this.message});

  FavoriteDtoResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? productId;
  String? productImage;
  String? productName;
  String? productDescription;
  int? productPrice;

  Data(
      {this.id,
      this.productId,
      this.productImage,
      this.productName,
      this.productDescription,
      this.productPrice});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    productImage = json['productImage'];
    productName = json['productName'];
    productDescription = json['productDescription'];
    productPrice = json['productPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['productImage'] = this.productImage;
    data['productName'] = this.productName;
    data['productDescription'] = this.productDescription;
    data['productPrice'] = this.productPrice;
    return data;
  }
}
