import 'package:eshopping/model/favorite_request_model.dart';
import 'package:eshopping/model/product_response_model.dart';
import 'package:eshopping/service/IFavoriteService.dart';
import 'package:eshopping/service/IProductService.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductCubit extends Cubit<ProductState> {
  final IProductService service;
  final IFavoriteService favoriteService;
  ProductCubit(this.service, this.favoriteService) : super(ProductInitial());
  bool isLoading = false;
  bool? isDark=false;
  ProductResponseModel? data;
  addFavorite(int? productId) async {
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     FavoriteRequestModel model = FavoriteRequestModel(id: 0,userId: prefs.getInt("userId")!.toInt(),productId: productId);
     var data = favoriteService.addFavorite(model);
     return data;
  }

  Future<void> getAllProducts() async {
    changeLoadingView();
    final data = await service.getAllProducts();
    this.data = data;
    if (data is ProductResponseModel) {
      emit(ProductsLoadedState(data));
    }
     changeLoadingView();
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(ProductLoadingState(isLoading));
  }
    getIsDarkMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    this.isDark = prefs.getBool("darkMode");
     return prefs.getBool("darkMode");
  }
}

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoadingState extends ProductState {
  final bool isLoading;
  ProductLoadingState(this.isLoading);
}

class ProductsLoadedState extends ProductState {
  final ProductResponseModel data;
  ProductsLoadedState(this.data);
}
