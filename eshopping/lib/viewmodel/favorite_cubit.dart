import 'package:eshopping/model/favorite_dto_response_model.dart';
import 'package:eshopping/model/favorite_request_model.dart';
import 'package:eshopping/service/IFavoriteService.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit({required this.service}) : super(FavoriteInitial());
  IFavoriteService service;
  FavoriteDtoResponseModel? data;
  bool isLoading=false;

   void changeLoadingView() {
    isLoading = !isLoading;
    emit(FavoriteLoadingState(isLoading));
  }
  deleteFavorite(int favoriteId) async {
    FavoriteRequestModel model = FavoriteRequestModel(id: favoriteId,productId: 0,userId: 0);
    await service.delete(model);
    getFavorite();
  }
  getFavorite() async {
    changeLoadingView();
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     var data = await service.getFavorite(prefs.getInt("userId")!.toInt());
     if (data is FavoriteDtoResponseModel) {
      this.data = data;
       emit(FavoriteLoaded(data));
     }
     changeLoadingView();
  }
}

abstract class FavoriteState{

}
class FavoriteLoadingState extends FavoriteState {
  final bool isLoading;
  FavoriteLoadingState(this.isLoading);
}
class FavoriteInitial extends FavoriteState{

}class FavoriteLoaded extends FavoriteState{
FavoriteDtoResponseModel model;
FavoriteLoaded(this.model);
}