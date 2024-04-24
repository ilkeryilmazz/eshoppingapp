class LoginRequestModel {
  String? email;
  String? password;

  LoginRequestModel({this.email, this.password});

  LoginRequestModel.fromJson(Map<dynamic, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}