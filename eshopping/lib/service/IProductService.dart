import 'package:dio/dio.dart';
import 'package:eshopping/model/login_request_model.dart';
import 'package:eshopping/model/login_response_model.dart';
import 'package:eshopping/model/product_response_model.dart';
import 'package:eshopping/model/register_request_model.dart';
import 'package:eshopping/model/register_response_model.dart';

abstract class IProductService {
  final Dio dio;

  IProductService(this.dio);

  Future<ProductResponseModel?> getAllProducts();

}
