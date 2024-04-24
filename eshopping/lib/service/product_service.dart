import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eshopping/model/product_response_model.dart';
import 'package:eshopping/service/IProductService.dart';

class ProductService extends IProductService {
  ProductService(Dio dio) : super(dio);
  //Ürünleri listelemek için api'a giden istek;
  @override
  Future<ProductResponseModel?> getAllProducts() async {
    final response = await dio.get("/Products/GetAll");
    if (response.statusCode == HttpStatus.ok) {
      return ProductResponseModel.fromJson(response.data);
    } else {
      return null;
    }
  }
}
