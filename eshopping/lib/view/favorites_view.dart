import 'package:dio/dio.dart';
import 'package:eshopping/model/product_response_model.dart';
import 'package:eshopping/service/favorite_service.dart';
import 'package:eshopping/view/product_detail_view.dart';
import 'package:eshopping/viewmodel/favorite_cubit.dart';
import 'package:eshopping/viewmodel/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteCubit(
          service: FavoriteService(
              Dio(BaseOptions(baseUrl: "https://10.0.2.2:7196/api")))),
      child: BlocConsumer<FavoriteCubit, FavoriteState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FavoriteInitial) {
            context.read<FavoriteCubit>().getFavorite();
          }
          return buildScaffold(context);
        },
      ),
    );
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("E Shopping App"),
      ),
      body: context.read<FavoriteCubit>().isLoading == true
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: context.watch<FavoriteCubit>().data?.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {},
                  child: Card(
                      semanticContainer: true,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,

                            child: IconButton(
                              color: Colors.black,
                              style: IconButton.styleFrom(
                               
                              ),
                              onPressed: (){
                                context.read<FavoriteCubit>().deleteFavorite(context.read<FavoriteCubit>().data!.data![index].id!.toInt());
                              }, icon: Icon(Icons.remove,color: Theme.of(context).colorScheme.primary,))),
                          ClipRRect(

                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50)),
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.transparent),
                                onPressed: () {
                                  Data data = Data(
                                      id: context
                                          .read<FavoriteCubit>()
                                          .data!
                                          .data![index]
                                          .productId,
                                      description: context
                                          .read<FavoriteCubit>()
                                          .data!
                                          .data![index]
                                          .productDescription,
                                      imageUrl: context
                                          .read<FavoriteCubit>()
                                          .data!
                                          .data![index]
                                          .productImage,
                                      name: context
                                          .read<FavoriteCubit>()
                                          .data!
                                          .data![index]
                                          .productName,
                                      price: context
                                          .read<FavoriteCubit>()
                                          .data!
                                          .data![index]
                                          .productPrice,
                                      unitsInStock: 0,
                                      categoryId: 0);
                      
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailView(data)));
                                },
                                child: Image(
                                  fit: BoxFit.contain,
                                  height: 100,
                                  width: 200,
                                  image: NetworkImage(context
                                      .read<FavoriteCubit>()
                                      .data!
                                      .data![index]
                                      .productImage
                                      .toString()),
                                )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(context
                                      .read<FavoriteCubit>()
                                      .data!
                                      .data![index]
                                      .productName
                                      .toString()),
                                  
                                ],
                              ),
                            ],
                          )
                        ],
                      )),
                );
              }),
    );
  }
}
