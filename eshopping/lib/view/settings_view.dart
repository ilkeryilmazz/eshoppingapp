import 'package:eshopping/main.dart';
import 'package:eshopping/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  SharedPreferences? prefs;
  @override
  void initState() {
    initShared();
    super.initState();
    
   
  }

  initShared() async {
    prefs = await SharedPreferences.getInstance();
  }
 String dropDownValue="Türkçe";

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("E Shopping"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          
            Card(

              child: Container(
                
                width: MediaQuery.of(context).size.width, height: 50,
                child: TextButton(
                  
                    onPressed: () async {
                      if (prefs?.getBool("darkMode") == null) {
                        prefs?.setBool("darkMode", true);
                      } else if (prefs?.getBool("darkMode") == true) {
                        prefs?.setBool("darkMode", false);
                      } else if (prefs?.getBool("darkMode") == false) {
                        prefs?.setBool("darkMode", true);
                      }
                      runApp(MyApp(prefs?.getBool("darkMode"),prefs?.getBool("isEn")));
                    },
                    child: Text(AppLocalizations.of(context)!.changeTema,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary))),
              ),
            ),
                        Card(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: TextButton(
                                            onPressed: () async {
                                               if (prefs?.getBool("isEn") == null) {
                                                prefs?.setBool("isEn", true);
                                              } else if (prefs?.getBool("isEn") == true) {
                                                prefs?.setBool("isEn", false);
                                              } else if (prefs?.getBool("isEn") == false) {
                                                prefs?.setBool("isEn", true);
                                              }
                                              runApp(MyApp(prefs?.getBool("darkMode"),prefs?.getBool("isEn")));
                                            },
                                            child: Text(AppLocalizations.of(context)!.changeLanguage,
                                                style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary))),
                          ),
                        ),
                        Card(
                          child: Container(
                            width: MediaQuery.of(context).size.width, height: 50,
                            child: TextButton(
                                            onPressed: () async {
                                             prefs?.remove("userId");
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginView()));
                                            },
                                            child: Text(AppLocalizations.of(context)!.singout,
                                                style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary))),
                          ),
                        )
          ],
        ),
      ),
    );
  }
}
