
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eshopping/model/login_request_model.dart';
import 'package:eshopping/model/login_response_model.dart';
import 'package:eshopping/model/register_request_model.dart';
import 'package:eshopping/model/register_response_model.dart';
import 'package:eshopping/service/IAuthService.dart';

class AuthService extends IAuthService {
  AuthService(Dio dio): super(dio);

//Kullanıcı girişinin sağlanması için api'a istek gönderen metod;
  @override
  Future<LoginResponseModel?> postUserLogin(LoginRequestModel model) async{
    final response = await dio.post("/Users/Login",data: model);
    if (response.statusCode==HttpStatus.ok) {
      return LoginResponseModel.fromJson(response.data);
    }
    else{
      return null;
    }
  }
  //Kullanıcı kaydının sağlanması için api'a istek gönderen metod;
  @override
  Future<RegisterResponseModel?> postUserRegister(RegisterRequestModel model) async {
    final response = await dio.post("/Users/Register",data: model);
    if (response.statusCode==HttpStatus.ok) {
      return RegisterResponseModel.fromJson(response.data);
    }
    else{
      return null;
    }
  }
  
}