import 'package:dio/dio.dart';
import 'package:eshopping/model/login_request_model.dart';
import 'package:eshopping/model/login_response_model.dart';
import 'package:eshopping/model/register_request_model.dart';
import 'package:eshopping/model/register_response_model.dart';

abstract class IAuthService{
  final Dio dio;

  IAuthService( this.dio);

  Future<LoginResponseModel?> postUserLogin(LoginRequestModel model);
  Future<RegisterResponseModel?> postUserRegister(RegisterRequestModel model);
  }
