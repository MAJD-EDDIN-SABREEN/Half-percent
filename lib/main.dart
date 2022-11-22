import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:half_percent_admin/ui/add_item.dart';
import 'package:half_percent_admin/ui/auth_container.dart';
import 'package:half_percent_admin/ui/home.dart';
import 'package:half_percent_admin/ui/log_in.dart';
import 'package:half_percent_admin/ui/signup.dart';
import 'package:half_percent_admin/ui/updateItem.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Half Percent Admin",
        routes: <String, WidgetBuilder>{
          '/Login': (BuildContext context) => Login(),
          '/signup': (BuildContext context) => Signup(),
          '/home': (BuildContext context) => Home(''),
          '/addItem': (BuildContext context) => AddItem('',''),
          '/updateItem': (BuildContext context) => UpdateItem('', '',''),
        },

        home: AuthContainer(),
        localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        ],
    supportedLocales: [
    Locale("ar", "AE"),
    ],
    locale: Locale("fa", "IR")
    );
  }
}
