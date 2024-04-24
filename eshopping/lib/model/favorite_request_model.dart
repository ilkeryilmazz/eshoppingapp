class FavoriteRequestModel {
  int? id;
  int? userId;
  int? productId;

  FavoriteRequestModel({this.id, this.userId, this.productId});

  FavoriteRequestModel.fromJson(Map<String, dynamic> json) {
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