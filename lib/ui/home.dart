import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:half_percent_admin/ui/showItems.dart';
import 'add_item.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  String userToken;

  Home(this.userToken);

  @override
  State<StatefulWidget> createState() {
    return HomeState(userToken);
  }
}

class HomeState extends State<Home> {
String userToken;

  HomeState(this.userToken);






  void onPressedDialog(String nameOfDialog ,String firstOption,String secondOption) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title:
            Text(nameOfDialog,style: TextStyle(color: Colors.purple.shade900),textAlign: TextAlign.right,),
            children: [
              SimpleDialogOption(
                child: Text(firstOption,textAlign: TextAlign.right,),
                onPressed: () async {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AddItem(nameOfDialog,userToken)));

                },
              ),
              SimpleDialogOption(
                child: Text(secondOption,textAlign: TextAlign.right,),
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ShowItems(nameOfDialog,"all","all",null,null,null,null,null,null,null,null,userToken)));

                },
              ),
            ],
          );
        });
  }

  void onTap(String name){
    if(name=='إعلانات'){
      onPressedDialog('إعلانات', 'إضافة إعلان', 'استعراض الإعلانات');
    }
    if(name=='عقارات'){
     onPressedDialog('عقارات', 'إضافة عقار', 'استعراض العقارات');
    }
    if(name=='سيارات'){
      onPressedDialog('سيارات', 'إضافة سيارة', 'استعراض السيارات');
    }
    if(name=='خدمات'){
      onPressedDialog('خدمات', 'إضافة خدمة', 'استعراض الخدمات');
    }
    if(name=='ورشات'){
      onPressedDialog('ورشات', 'إضافة ورشة', 'استعراض الورشات');
    }

  }

  Widget carOrHomeOrService(String imgPath,String name){
    return InkWell(
        child:Container(
           // margin: EdgeInsets.only(top: 20),
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(imgPath),
                    fit: BoxFit.fill)),
            child: Stack(children: <Widget>[
              Positioned(
                child:
                Container(
                 // margin: EdgeInsets.only(top: 50),
                  child: Center(
                    child: Text(
                      name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ]))
        ,
        onTap:(){ onTap(name);}
    );
  }
void navigationBottom(int val) {
  switch (val) {
    case 1:
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => Home(userToken)),
              (route) => false);
      break;
    case 2:
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ShowItems('الطلبات', '',
                  '', null, null, null, null, null, null, null, null,userToken)),
              (route) => false);
      break;

  }
}
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple.shade800,
          centerTitle: true,
          title: Text("الصفحة الرئيسية"),
        ),
        body: SingleChildScrollView(
          child: Container(
            //padding: EdgeInsets.only(top: 20),
            color: Colors.white,
            child: Column(
              children: [
                carOrHomeOrService('images/estate.jpg', 'إعلانات'),
                carOrHomeOrService('images/estate.jpg', 'عقارات'),
                carOrHomeOrService('images/car.jpg', 'سيارات'),
                carOrHomeOrService('images/electricity.jpg', 'خدمات'),
                carOrHomeOrService('images/electricity.jpg', 'ورشات')

              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              title: Text('الإعدادات'),
              icon: Icon(Icons.settings),
            ),
            BottomNavigationBarItem(
                title: Text('الرئيسية'), icon: Icon(Icons.home_filled)),
            BottomNavigationBarItem(
                title: Text('الطلبات'), icon: Icon(Icons.reorder_rounded)),

          ],
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.purple.shade800,
          onTap: navigationBottom,
          fixedColor: Colors.white,
          unselectedItemColor: Colors.white,
        ),
      ),
    );
  }
}
