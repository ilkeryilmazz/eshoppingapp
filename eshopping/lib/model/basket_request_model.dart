
//Api'a istek atmak için kullanılan sepet nesnesi
class BasketRequestModel {
  int? id;
  int? userId;
  int? productId;

  BasketRequestModel({this.id, this.userId, this.productId});

  BasketRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['productId'] = this.productId;
    return data;
  }
}