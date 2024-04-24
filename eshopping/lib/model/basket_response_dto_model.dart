
//Api'dan sepeti listelemek için dönen dto nesnesi
class BasketResponseDtoModel {
  List<Data>? data;
  bool? success;
  String? message;

  BasketResponseDtoModel({this.data, this.success, this.message});

  BasketResponseDtoModel.fromJson(Map<String, dynamic> json) {
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
  String? productImage;
  String? productName;
  int? productPrice;

  Data({this.id, this.productImage, this.productName, this.productPrice});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productImage = json['productImage'];
    productName = json['productName'];
    productPrice = json['productPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productImage'] = this.productImage;
    data['productName'] = this.productName;
    data['productPrice'] = this.productPrice;
    return data;
  }
}
