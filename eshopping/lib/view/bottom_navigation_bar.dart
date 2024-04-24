import 'package:eshopping/view/basket_view.dart';
import 'package:eshopping/view/favorites_view.dart';
import 'package:eshopping/view/product_list_view.dart';
import 'package:eshopping/view/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomNavigationBarView extends StatefulWidget {
   int? newIndex;
  BottomNavigationBarView(this.newIndex, {super.key});
 
  @override
  State<BottomNavigationBarView> createState() => _BottomNavigationBarViewState(this.newIndex);
}

class _BottomNavigationBarViewState extends State<BottomNavigationBarView> {
  int _currentIndex = 0;
  List<Widget> _body = <Widget>[
    ProductListView(),
    FavoriteView(),
    BasketView(),
    SettingsView()
  ];
  int? newIndex;
  _BottomNavigationBarViewState(this.newIndex);
  
  @override
  Widget build(BuildContext context) {
    if (this.newIndex!=null) {
      _currentIndex=newIndex!.toInt();
      newIndex=null;
    }
    return Scaffold(
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newIndex){
          print(newIndex);
          setState(() {
            _currentIndex=newIndex;
          });
        },
        fixedColor: Colors.black,
        unselectedLabelStyle: TextStyle(color: Colors.black, fontSize: 14),
        backgroundColor: Theme.of(context).colorScheme.primary,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list_alt,
              color: Colors.black,
            ),
            label: AppLocalizations.of(context)!.products,
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: Colors.black,
              ),
              label: AppLocalizations.of(context)!.favorites),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
              label: AppLocalizations.of(context)!.cart),
               BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              label: AppLocalizations.of(context)!.settings),
        ],
      ),
      body: _body[_currentIndex],
    );
  }
}
