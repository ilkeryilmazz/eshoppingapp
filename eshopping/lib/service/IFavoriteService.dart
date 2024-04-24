import 'package:dio/dio.dart';
import 'package:eshopping/model/favorite_dto_response_model.dart';
import 'package:eshopping/model/favorite_request_model.dart';
import 'package:eshopping/model/favorite_response_model.dart';
import 'package:eshopping/model/login_request_model.dart';
import 'package:eshopping/model/login_response_model.dart';
import 'package:eshopping/model/product_response_model.dart';
import 'package:eshopping/model/register_request_model.dart';
import 'package:eshopping/model/register_response_model.dart';

abstract class IFavoriteService {
  final Dio dio;

  IFavoriteService(this.dio);

  Future<FavoriteResponseModel?> addFavorite(FavoriteRequestModel model);
  Future<FavoriteDtoResponseModel?> getFavorite(int userId);
  Future<void> delete(FavoriteRequestModel model);
}
