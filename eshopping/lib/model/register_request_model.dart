class RegisterRequestModel {
  int? id;
  String? userName;
  String? email;
  String? password;

  RegisterRequestModel({this.id, this.userName, this.email, this.password});

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}