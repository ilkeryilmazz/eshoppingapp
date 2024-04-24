import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eshopping/model/favorite_dto_response_model.dart';
import 'package:eshopping/model/favorite_request_model.dart';
import 'package:eshopping/model/favorite_response_model.dart';
import 'package:eshopping/model/product_response_model.dart';
import 'package:eshopping/service/IFavoriteService.dart';

class FavoriteService extends IFavoriteService {
  FavoriteService(Dio dio) : super(dio);

 //Favorilere ürün eklemek için api'a giden istek;
  @override
  Future<FavoriteResponseModel?> addFavorite(FavoriteRequestModel model) async {
    try {
       final response = await dio.post("/Favorites/Add", data: model);
    if (response.statusCode == HttpStatus.ok) {
      return FavoriteResponseModel.fromJson(response.data);
    } else {
      return null;
    }
    } catch (e) {
     if (e is DioError) {
       return FavoriteResponseModel.fromJson(e.response!.data);
     }
    }
  }
//Favorileri listelemek  için api'a giden istek;
  @override
  Future<FavoriteDtoResponseModel?> getFavorite(int userId) async {
     final response = await dio.get("/Favorites/GetAllFavoriteProductByUserId", queryParameters: {
      "userId":userId
     });
    if (response.statusCode == HttpStatus.ok) {
      return FavoriteDtoResponseModel.fromJson(response.data);
    } else {
      return null;
    }
  }
  //Favorilere eklenen ürünü silmek  için api'a giden istek;
  @override
  Future<void> delete(FavoriteRequestModel model) async {
    final response = await dio.post("/Favorites/Delete", data: model);
    
  }
 
  
}
