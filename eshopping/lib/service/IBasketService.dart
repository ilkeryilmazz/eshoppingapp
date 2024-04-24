import 'package:dio/dio.dart';
import 'package:eshopping/model/basket_clear_model.dart';
import 'package:eshopping/model/basket_request_model.dart';
import 'package:eshopping/model/basket_response_dto_model.dart';
import 'package:eshopping/model/basket_response_model.dart';
import 'package:eshopping/model/login_request_model.dart';
import 'package:eshopping/model/login_response_model.dart';
import 'package:eshopping/model/product_response_model.dart';
import 'package:eshopping/model/register_request_model.dart';
import 'package:eshopping/model/register_response_model.dart';

abstract class IBasketService {
  final Dio dio;

  IBasketService(this.dio);

  Future<BasketResponseModel?> addToBasket(BasketRequestModel model);
  Future<BasketClearResponseModel?> clearBasket(int userId);
  Future<BasketResponseDtoModel?> getAllBasketProducts(int userId);
  Future<void> delete(BasketRequestModel model);
}
