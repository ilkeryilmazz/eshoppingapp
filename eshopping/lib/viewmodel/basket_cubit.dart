import 'package:eshopping/model/basket_request_model.dart';
import 'package:eshopping/model/basket_response_dto_model.dart';
import 'package:eshopping/service/IBasketService.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BasketCubit extends Cubit<BasketState> {
  BasketCubit({required this.service}) : super(BasketInitial());
  IBasketService service;
  BasketResponseDtoModel? data;
  bool isLoading=false;
  int totalPrice=0;

  delete(int id){
    BasketRequestModel model = BasketRequestModel(id:id,productId: 0,userId: 0 );
    service.delete(model);
    totalPrice=0;
    getAllBasketProducts();
  }

  Future<void> getAllBasketProducts() async {
    changeLoadingView();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = await service.getAllBasketProducts(prefs.getInt("userId")!.toInt());
    if (data is BasketResponseDtoModel) {
      this.data = data;
      for (var i = 0; i < data.data!.length; i++) {
        this.totalPrice += data.data![i].productPrice!.toInt();
      }
      emit(BasketLoadedState(data));
    }
    changeLoadingView();
  }

    void changeLoadingView() {
    isLoading = !isLoading;
    emit(BasketLoadingState(isLoading));
  }

  Future<void> clearBasket() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final datas = await service.clearBasket(prefs.getInt("userId")!.toInt());
     totalPrice=0;
     getAllBasketProducts();
    }
   
  }

    

abstract class BasketState {}

class BasketInitial extends BasketState {}

class BasketLoadedState extends BasketState {
  final BasketResponseDtoModel model;

  BasketLoadedState(this.model);
}
class BasketLoadingState extends BasketState{
  bool isLoading;
  BasketLoadingState(this.isLoading) {}
}