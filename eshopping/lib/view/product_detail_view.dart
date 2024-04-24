import 'package:dio/dio.dart';
import 'package:eshopping/model/basket_request_model.dart';
import 'package:eshopping/model/product_detail_model.dart';
import 'package:eshopping/model/product_response_model.dart';
import 'package:eshopping/service/IBasketService.dart';
import 'package:eshopping/service/basket_service.dart';
import 'package:eshopping/view/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:eshopping/model/product_response_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailView extends StatelessWidget {
  Data? product;
  ProductDetailView(this.product, {super.key});
  IBasketService service = BasketService(Dio(BaseOptions(baseUrl: "https://10.0.2.2:7196/api")));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Column(
          
          children: [
            
             Image(image: NetworkImage(product!.imageUrl.toString()),
           
              width: MediaQuery.of(context).size.width,
              height: 400,
            ), Padding(
              padding:  EdgeInsets.only(left: 20,right: 20),
              child: Container(
               
                child: Column(
                  
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product!.name.toString(),style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 24,),),
                    Text(textAlign: TextAlign.justify,product!.description.toString(),style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 17),),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        
                        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor:Theme.of(context).colorScheme.primary ),onPressed: () async {
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                        
                          BasketRequestModel model= BasketRequestModel(id: 0,productId: product!.id,userId: prefs.getInt("userId")!.toInt());
                          service.addToBasket(model);
                          _productAddedToBasket(context);
                        }, child: Text(AppLocalizations.of(context)!.addToCart,style: TextStyle(color: Theme.of(context).colorScheme.secondary),)),
                      ],
                    )
                  ],
                ),
              ),
            ),
            ],
        ),
      ),
    );

  }
    _productAddedToBasket(BuildContext context) {
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
                Navigator.pop(context);
                 Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigationBarView(2)));
              }, child: Text(AppLocalizations.of(context)!.goToCart))],
          title:  Text(AppLocalizations.of(context)!.productAddedToCart),
          content: Container(
            child: Text(
              AppLocalizations.of(context)!.productAddedToCartDesc,
            ),
          ),
        );
        
      },
    );
  }
}
