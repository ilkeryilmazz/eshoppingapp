
import 'dart:io';
import 'package:device_preview/device_preview.dart';
import 'package:eshopping/l10n/l10n.dart';
import 'package:eshopping/view/bottom_navigation_bar.dart';
import 'package:eshopping/view/onboard_view.dart';
import 'package:eshopping/view/product_list_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:eshopping/theme/theme.dart';
import 'package:eshopping/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
   final SharedPreferences prefs = await SharedPreferences.getInstance();
   bool? isDarkMode = (prefs.getBool("darkMode"));
   bool? isEn = (prefs.getBool("isEn"));
  runApp(
    MyApp(isDarkMode,isEn)
    );
   
  
  }

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
  
}

class MyApp extends StatelessWidget {
  bool? isDarkMode=false;
  bool? isEn=false;
  MyApp(this.isDarkMode,this.isEn);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      
    

      child: MaterialApp(
        supportedLocales: L10n.all,
        locale: isEn == true ? Locale('en') : Locale('tr'),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: isDarkMode == true ? darkMode :  lightMode,
        darkTheme: darkMode,
        home: OnBoardView(),
      ),
    );
  }
}