import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eshopping/model/basket_clear_model.dart';
import 'package:eshopping/model/basket_request_model.dart';
import 'package:eshopping/model/basket_response_dto_model.dart';
import 'package:eshopping/model/basket_response_model.dart';
import 'package:eshopping/model/product_response_model.dart';
import 'package:eshopping/service/IBasketService.dart';

class BasketService extends IBasketService {
  BasketService(Dio dio) : super(dio);

  //Sepete ürün eklemek için api'a giden istek;
  @override
  Future<BasketResponseModel?> addToBasket(BasketRequestModel model) async {
    final response = await dio.post("/Baskets/Add", data: model);
    if (response.statusCode == HttpStatus.ok) {
      return BasketResponseModel.fromJson(response.data);
    } else {
      return null;
    }
  }
   //Sepeti listelemek için api'a giden istek;
  @override
  Future<BasketResponseDtoModel?> getAllBasketProducts(int userId) async {
    final response = await dio.get("/Baskets/GetAllBasketProductByUserId",
        queryParameters: {"userId": userId});
    if (response.statusCode == HttpStatus.ok) {
      return BasketResponseDtoModel.fromJson(response.data);
    } else {
      return null;
    }
  }
   //Sepeti sıfırlmak için api'a giden istek;
  @override
  Future<BasketClearResponseModel?> clearBasket(int userId) async {
    final response = await dio
        .post("/Baskets/DeleteAllByUserId", queryParameters: {"userId": userId});
    if (response.statusCode == HttpStatus.ok) {
      return BasketClearResponseModel.fromJson(response.data);
    } else {
      return null;
    }
  }
   //Sepetten bir ürünü çıkarmak için için api'a giden istek;
  @override
  Future<void> delete(BasketRequestModel model) async {
    final response = await dio.post("/Baskets/Delete", data: model);
    
  }
}
