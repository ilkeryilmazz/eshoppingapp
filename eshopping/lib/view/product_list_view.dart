import 'package:dio/dio.dart';
import 'package:eshopping/model/product_response_model.dart';
import 'package:eshopping/service/favorite_service.dart';
import 'package:eshopping/service/product_service.dart';
import 'package:eshopping/view/bottom_navigation_bar.dart';
import 'package:eshopping/view/product_detail_view.dart';
import 'package:eshopping/viewmodel/product_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ProductListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(
          ProductService(
              Dio(BaseOptions(baseUrl: "https://10.0.2.2:7196/api",receiveDataWhenStatusError: true))),
          FavoriteService(
              Dio(BaseOptions(baseUrl: "https://10.0.2.2:7196/api",receiveDataWhenStatusError: true)))),
      child: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is ProductInitial) {
            context.read<ProductCubit>().getIsDarkMode();
            context.read<ProductCubit>().getAllProducts();
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
      body: context.read<ProductCubit>().isLoading == true
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 280,
                crossAxisCount: 2,
              ),
              itemCount: context.watch<ProductCubit>().data?.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    var data = context.read<ProductCubit>().data!.data![index];
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetailView(data)));
                  },
                  child: Card(
                      semanticContainer: true,
                      child: Container(
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50)),
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.transparent),
                                  onPressed: () {
                                    var data = context
                                        .read<ProductCubit>()
                                        .data!
                                        .data![index];
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailView(data)));
                                  },
                                  child: Image(
                                    fit: BoxFit.cover,
                                    height: 200,
                                    width: 200,
                                    image: NetworkImage(context
                                        .read<ProductCubit>()
                                        .data!
                                        .data![index]
                                        .imageUrl
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
                                        .read<ProductCubit>()
                                        .data!
                                        .data![index]
                                        .name
                                        .toString()),
                                    Text(
                                      context
                                              .read<ProductCubit>()
                                              .data!
                                              .data![index]
                                              .price
                                              .toString() +
                                          "₺",
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.orange.shade300),
                                    )
                                  ],
                                ),
                                IconButton(
                                    onPressed: () async {
                                      var data = await context.read<ProductCubit>().addFavorite(context.read<ProductCubit>().data!.data![index].id);
                                      if (data.success==false) {
                                        _favoriteIsAlreadyExists(context,data.message);
                                      }
                                    },
                                    icon: Icon(Icons.favorite)),
                              ],
                            )
                          ],
                        ),
                      )),
                );
              }),
    );
  }
      _favoriteIsAlreadyExists(BuildContext context,String message) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary
              ),
              onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigationBarView(1)));
              }, child: Text(AppLocalizations.of(context)!.goToFavorite))],
          title:  Text(AppLocalizations.of(context)!.inFavorite),
          content: Container(
            child: Text(AppLocalizations.of(context)!.favoriteAlreadyExists),
            ),
          
        );
        
      },
    );
  }
}
