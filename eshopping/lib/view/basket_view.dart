import 'package:dio/dio.dart';
import 'package:eshopping/service/basket_service.dart';
import 'package:eshopping/view/bottom_navigation_bar.dart';
import 'package:eshopping/viewmodel/basket_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class BasketView extends StatelessWidget {
  const BasketView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BasketCubit(
          service: BasketService(
              Dio(BaseOptions(baseUrl: "https://10.0.2.2:7196/api")))),
      child: BlocConsumer<BasketCubit, BasketState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is BasketInitial) {
            context.read<BasketCubit>().getAllBasketProducts();
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
      body: context.read<BasketCubit>().isLoading == true
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 400,
                    child: ListView.builder(
                        itemCount:
                            context.watch<BasketCubit>().data!.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(context
                                .read<BasketCubit>()
                                .data!
                                .data![index]
                                .productName
                                .toString()),
                            subtitle: Text(context
                                    .read<BasketCubit>()
                                    .data!
                                    .data![index]
                                    .productPrice
                                    .toString() +
                                "₺"),
                                trailing: IconButton(onPressed: (){
                                  context.read<BasketCubit>().delete(context.read<BasketCubit>().data!.data![index].id!.toInt());
                                },icon: Icon(Icons.remove,color: Theme.of(context).colorScheme.primary,),),
                            leading: Image(
                              height: 200,
                              width: 75,
                              image: NetworkImage(context
                                  .read<BasketCubit>()
                                  .data!
                                  .data![index]
                                  .productImage
                                  .toString()),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 90,
                  ),
                  ListTile(
                      tileColor: Theme.of(context).colorScheme.primary,
                      trailing: TextButton(
                        onPressed: () async {
                          if (context.read<BasketCubit>().data!.data!.isEmpty) {
                            _basketIsEmpty(context);
                          } else {
                            _dialogBuilder(
                                context,
                                context.read<BasketCubit>().totalPrice,
                                context);
                          
                          }
                        },
                        child: Text(
                          AppLocalizations.of(context)!.confirmCart,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                      title: context.read<BasketCubit>().totalPrice > 0
                          ? Text(AppLocalizations.of(context)!.totalPrice +": " +
                              context
                                  .read<BasketCubit>()
                                  .totalPrice
                                  .toString() +
                              " ₺")
                          : Text(AppLocalizations.of(context)!.noProductInBasket),
                      leading: Icon(
                        Icons.arrow_downward,
                      )),
                ],
              ),
            ),
    );
  }

  _dialogBuilder(
      BuildContext context, int? price, BuildContext providerContext) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text(AppLocalizations.of(context)!.payConfirmed),
          content: Container(
            height: 125,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.payConfirmedDescOne +" "+
                      price.toString() +
                      "₺ ." + AppLocalizations.of(context)!.payConfirmedDescTwo,
                ),
                Icon(
                  Icons.verified_user,
                  size: 60,
                  color: Colors.green,
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                textStyle:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
              child:  Text(AppLocalizations.of(context)!.clearCar),
              onPressed: () {
                providerContext.read<BasketCubit>().clearBasket();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  _basketIsEmpty(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sepete Ürün Ekleyin'),
          content: Container(
            child: Text(
              'Ödeme yapabilmek için sepetinizde ürün olması gerekli. Sepetinize ürün ekledikten sonra tekrar deneyin.',
            ),
          ),
        );
      },
    );
  }
}
