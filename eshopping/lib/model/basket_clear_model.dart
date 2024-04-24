
//Sepetin temizlenmesi sonucu apidan gelen cevap

class BasketClearResponseModel {
  bool? success;
  String? message;

  BasketClearResponseModel({this.success, this.message});

  BasketClearResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}
