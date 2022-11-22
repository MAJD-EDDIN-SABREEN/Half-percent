import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:half_percent_admin/ui/home.dart';
import 'package:half_percent_admin/ui/updateItem.dart';
import 'add_item.dart';
import 'item_detail.dart';
import 'package:http/http.dart' as http;

class ShowItems extends StatefulWidget {
  String type;
  String estateType;
  String carType;
  String selectedValueEstateType;
  String selectedValueEstateSpace;
  String selectedValueEstatePrice;
  String selectedValueEstateArea;
  String selectedValueCarName;
  String selectedValueCarManufacturingYear;
  String selectedValueCarPrice;
  String selectedValueCarCity;
  String userToken;

  ShowItems(
      this.type,
      this.estateType,
      this.carType,
      this.selectedValueEstateType,
      this.selectedValueEstateSpace,
      this.selectedValueEstatePrice,
      this.selectedValueEstateArea,
      this.selectedValueCarName,
      this.selectedValueCarManufacturingYear,
      this.selectedValueCarPrice,
      this.selectedValueCarCity,
      this.userToken);

  @override
  State<StatefulWidget> createState() {
    return ShowItemsState(this.type,
        this.estateType,
        this.carType,
        this.selectedValueEstateType,
        this.selectedValueEstateSpace,
        this.selectedValueEstatePrice,
        this.selectedValueEstateArea,
        this.selectedValueCarName,
        this.selectedValueCarManufacturingYear,
        this.selectedValueCarPrice,
        this.selectedValueCarCity,
        this.userToken);
  }
}

class ShowItemsState extends State<ShowItems> {
  String type;
  String userToken;
  String estateType;
  String carType;
  String selectedValueEstateType;
  String selectedValueEstateSpace;
  String selectedValueEstatePrice;
  String selectedValueEstateArea;
  String selectedValueCarName;
  String selectedValueCarManufacturingYear;
  String selectedValueCarPrice;
  String selectedValueCarCity;

  ShowItemsState(
      this.type,
      this.estateType,
      this.carType,
      this.selectedValueEstateType,
      this.selectedValueEstateSpace,
      this.selectedValueEstatePrice,
      this.selectedValueEstateArea,
      this.selectedValueCarName,
      this.selectedValueCarManufacturingYear,
      this.selectedValueCarPrice,
      this.selectedValueCarCity,
      this.userToken);
  List<String> estateTypes = [];
  List<String> estatearea = [];
  List<String> estatePrice = [
    '50->100 مليون',
    '101->200 مليون',
    '201->500 مليون',
    'اكثر من 500 مليون'
  ];
  List<String> estateSpace = ['50->100 متر', '101->200 متر', 'اكثر من 200 متر'];
  List<String> carName = [];
  List<String> carManufacturingYear = [];
  List<String> carPrice = ['5->20 مليون',
    '21->50 مليون',
    '50->100 مليون',
    'اكثر من 100 مليون'];
  List<String> carCity = [];
  int fromPriceSpaceForFilteringData(String SelectedValue) {
    switch (SelectedValue) {
      case '50->100 مليون':
        return 50000000;
        break;
      case '101->200 مليون':
        return 101000000;
        break;
      case '201->500 مليون':
        return 201000000;
        break;
      case 'اكثر من 500 مليون':
        return 501000000;
        break;
      case '50->100 متر':
        return 50;
        break;
      case '101->200 متر':
        return 101;
        break;
      case 'اكثر من 200 متر':
        return 201;
        break;
      case '5->20 مليون':
        return 5000000;
        break;
      case '21->50 مليون':
        return 21000000;
        break;
      case '50->100 مليون':
        return 50000000;
        break;
      case 'اكثر من 100 مليون':
        return 100000000;
        break;

    }
  }
  int toPriceSpaceForFilteringData(String SelectedValue) {
    switch (SelectedValue) {
      case '50->100 مليون':
        return 100000000;
        break;
      case '101->200 مليون':
        return 200000000;
        break;
      case '201->500 مليون':
        return 500000000;
        break;
      case 'اكثر من 500 مليون':
        return 500000000000;
        break;
      case '50->100 متر':
        return 100;
        break;
      case '101->200 متر':
        return 200;
        break;
      case 'اكثر من 200 متر':
        return 1000;
        break;
      case '5->20 مليون':
        return 20000000;
        break;
      case '21->50 مليون':
        return 50000000;
        break;
      case '50->100 مليون':
        return 50000000;
        break;
      case 'اكثر من 100 مليون':
        return 100000000000;
        break;

    }
  }
  List<Widget> showEstatesImages(List imagespaths) {
    List<Widget> images = [];
    for (int i = 0; i < imagespaths.length; i++) {
      images.add(Image.network(
        'http://10.0.2.2:8000/images/EstatePictures/${imagespaths[i]['imageName']}',
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes
                  : null,
            ),
          );
        },
      ));
    }
    return images;
  }
  List<Widget> showCarsImages(List imagespaths) {
    List<Widget> images = [];
    for (int i = 0; i < imagespaths.length; i++) {
      images.add(Image.network(
        'http://10.0.2.2:8000/images/CarPictures/${imagespaths[i]['imageName']}',
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes
                  : null,
            ),
          );
        },
      ));
    }
    return images;
  }
  void navigationBottomEstate(int val) {
    switch (val) {
      case 0:
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => Home(userToken)),
                (route) => false);
        break;
      case 1:
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ShowItems(type, 'sell',
                    '', null, null, null, null, null, null, null, null,userToken)),
                (route) => false);
        break;
      case 2:
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ShowItems(type, 'rent',
                    '', null, null, null, null, null, null, null, null,userToken)),
                (route) => false);
        break;
    }
  }
  void navigationBottomCar(int val) {
    switch (val) {
      case 0:
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => Home(userToken)),
                (route) => false);
        break;

    }
  }
  void navigationBottomService(int val) {
    switch (val) {
      case 0:
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => Home(userToken)),
                (route) => false);
        break;
      case 1:
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ShowItems('الطلبات', '',
                    '', null, null, null, null, null, null, null, null,userToken)),
                (route) => false);
        break;

    }
  }

  Future<List> carFiltering() async {
    switch (carType) {
      case 'all':
        return getCarsData();
        break;
      case 'search':
        return getCarsFilteringData();
        break;
    }
  }
  Future<List> estateFiltering() async {
    switch (estateType) {
      case 'all':
        return getEstatesData();
        break;
      case 'sell':
        return getEstatesForSellimgData();
        break;
      case 'rent':
        return getEstatesForRentData();
        break;
      case 'search':
        return getEstatesFilteringData();
        break;
    }
  }
  Future<Widget>showItemsAlert(String msg) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(msg),
          actions: <Widget>[
            TextButton(
              child: new Text('حسناً'),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Future<List>getAdvData()async{
    String myurl = 'http://10.0.2.2:8000/api/advertisement/getAll';
    var response;
    try {
      response = await http.get(Uri.parse(myurl),
        headers: {
          'Accept': 'application/json',
        },
      );
      return jsonDecode(response.body);
    }
    catch (e) {
      showItemsAlert('لايوجد اتصال بلانترنت');
    }
  }
  Future<List>getServiceData()async{
    String myurl = 'http://10.0.2.2:8000/api/Service/getAll';
    var response;
    try {
      response = await http.get(Uri.parse(myurl),
        headers: {
          'Accept': 'application/json',
        },
      );
      return jsonDecode(response.body);
    }
    catch (e) {
      showItemsAlert('لايوجد اتصال بلانترنت');
    }
  }
  Future<List> getCarsData() async {
    String myurl = 'http://10.0.2.2:8000/api/Car/viewAll';
    var response;
    try {
      response = await http.get(
      Uri.parse(myurl),
        headers: {
          'Accept': 'application/json',
        },
      );
      return jsonDecode(response.body);

    } catch (e) {
      if(jsonDecode(response.body)=="not found Car")
        return [{"0":"0"}];
      showItemsAlert('لايوجد اتصال بلانترنت');
    }
  }
   Future <Widget>workshopAlert(String workshopType,String ownerName,String ownerPhone,String area,String workShopId) async {

   return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(workshopType),

          actions: <Widget>[
           Center(child: Column(

               children: [Text(ownerName,style: TextStyle(fontWeight: FontWeight.bold),),
            Text(ownerPhone,style: TextStyle(fontWeight: FontWeight.bold),),
            Text(area,style: TextStyle(fontWeight: FontWeight.bold),),

           ])),Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [TextButton(
              child: new Text('حسناً'),
              onPressed: () async {
                Navigator.pop(context);
              },
            ), TextButton(
              child: new Text( 'حذف'),
              onPressed: () async {
               deleteWorkshop(workShopId);
              },
            ), TextButton(
              child: new Text('تعديل'),
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder:
                            (BuildContext context) =>
                            UpdateItem(type, userToken,workShopId.toString())));
              },
            ),])],
        );
      },
    );
  }
  Future <Widget>orderAlert(String phone,String describe,String orderId) async {

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(phone),

          actions: <Widget>[
            Center(child: Column(

                children: [Text(describe,style: TextStyle(fontWeight: FontWeight.bold),),


                ])),Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [TextButton(
                  child: new Text('حسناً'),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ), TextButton(
                  child: new Text( 'حذف'),
                  onPressed: () async {
                    deleteOrder(orderId);
                  },
                ),
                 ])],
        );
      },
    );
  }
  // Widget dropDown(String name, String selectedValue) {
  //   return DropdownButtonHideUnderline(
  //     child: DropdownButton2(
  //       isExpanded: true,
  //       hint: Row(
  //         children: [
  //           Expanded(
  //               child: Text(
  //             name,
  //             style: TextStyle(
  //               fontSize: 10,
  //               fontWeight: FontWeight.bold,
  //               color: Colors.white,
  //             ),
  //             maxLines: 2,
  //             overflow: TextOverflow.ellipsis,
  //           ))
  //         ],
  //       ),
  //       items: items
  //           .map((item) => DropdownMenuItem<String>(
  //                 value: item,
  //                 child: Text(
  //                   item,
  //                   style: const TextStyle(
  //                     fontSize: 20,
  //                     fontWeight: FontWeight.bold,
  //                     color: Colors.white,
  //                   ),
  //                   overflow: TextOverflow.ellipsis,
  //                 ),
  //               ))
  //           .toList(),
  //       value: selectedValue,
  //       onChanged: (value) {
  //         setState(() {
  //           selectedValue = value as String;
  //         });
  //       },
  //       icon: const Icon(
  //         Icons.arrow_drop_down,
  //       ),
  //       iconSize: 14,
  //       iconEnabledColor: Colors.white,
  //       iconDisabledColor: Colors.grey,
  //       buttonHeight: 50,
  //       buttonWidth: MediaQuery.of(context).size.width / 5,
  //       buttonPadding: const EdgeInsets.only(left: 14, right: 14),
  //       buttonDecoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(14),
  //         border: Border.all(
  //           color: Colors.black26,
  //         ),
  //         color: Colors.grey,
  //       ),
  //       buttonElevation: 2,
  //       itemHeight: 40,
  //       itemPadding: const EdgeInsets.only(left: 14, right: 14),
  //       dropdownMaxHeight: 200,
  //       dropdownWidth: 200,
  //       dropdownPadding: null,
  //       dropdownDecoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(14),
  //         color: Colors.black,
  //       ),
  //       dropdownElevation: 8,
  //       scrollbarRadius: const Radius.circular(40),
  //       scrollbarThickness: 6,
  //       scrollbarAlwaysShow: true,
  //       offset: const Offset(-20, 0),
  //     ),
  //   );
  // }
  Future<List> getCarsFilteringData() async {
    String myurl = 'http://10.0.2.2:8000/api/Car/search';
    var response;
    try {
      response = await http.post(Uri.parse(myurl), headers: {
        'Accept': 'application/json',
      }, body: {
        "name": selectedValueCarName == null ? "" : selectedValueCarName,
        "manufacturingYear": selectedValueCarManufacturingYear==null ? "" :selectedValueCarManufacturingYear,
        "city": selectedValueCarCity==null ? "" :selectedValueCarCity,
        "pricefrom":selectedValueCarPrice==null ? "":"${fromPriceSpaceForFilteringData(selectedValueCarPrice)}",
        "priceto":selectedValueCarPrice==null ? "":"${toPriceSpaceForFilteringData(selectedValueCarPrice)}",
      });
      return jsonDecode(response.body);

    } catch (e) {
      if(jsonDecode(response.body)=="not found Car")
        return [{"0":"0"}];
      showItemsAlert('لايوجد اتصال بلانترنت');
    }
  }
  Future<void> deleteAdv(String advId) async {
    var response;
    print(advId);
    String myurl = 'http://10.0.2.2:8000/api/advertisement/delete/$advId';
    try {

       response = await http.delete(Uri.parse(myurl),
          headers: {
            'Accept': 'application/json',
          },
          );
   if(response.statusCode==200)
     {
       Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(

           builder: (BuildContext context) =>
               Home(userToken)
       ), (route) => false);
     }
    }
    catch (e) {

    }
  }
  Future<void> deleteEstate(String estateId) async {
    var response;
    String myurl = 'http://10.0.2.2:8000/api/Estate/delete/$estateId';
    try {

      response = await http.delete(Uri.parse(myurl),
        headers: {
          'Accept': 'application/json',
        },
      );
      if(response.statusCode==200)
      {
        Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(

            builder: (BuildContext context) =>
                Home(userToken)
        ), (route) => false);
      }
    }
    catch (e) {

    }
  }
  Future<void> updateEstate(String estateId) async {
    var response;
    String myurl = 'http://10.0.2.2:8000/api/Estate/delete/$estateId';
    try {

      response = await http.delete(Uri.parse(myurl),
        headers: {
          'Accept': 'application/json',
        },
      );
      if(response.statusCode==200)
      {
        Navigator.pushAndRemoveUntil(context,   MaterialPageRoute(
            builder: (BuildContext context) =>
                AddItem(type,userToken)), (route) => false);
      }
    }
    catch (e) {

    }
  }
  Future<void> deleteCar(String carId) async {
    var response;
    String myurl = 'http://10.0.2.2:8000/api/Car/delete/$carId';
    try {

      response = await http.delete(Uri.parse(myurl),
        headers: {
          'Accept': 'application/json',
        },
      );
      if(response.statusCode==200)
      {
        Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(

            builder: (BuildContext context) =>
                Home(userToken)
        ), (route) => false);
      }
    }
    catch (e) {

    }
  }
  Future<void> updateCar(String carId) async {
    var response;
    String myurl = 'http://10.0.2.2:8000/api/Car/delete/$carId';
    try {

      response = await http.delete(Uri.parse(myurl),
        headers: {
          'Accept': 'application/json',
        },
      );
      if(response.statusCode==200)
      {
        Navigator.pushAndRemoveUntil(context,   MaterialPageRoute(
            builder: (BuildContext context) =>
                AddItem(type,userToken)), (route) => false);
      }
    }
    catch (e) {

    }
  }
  Future<void> deleteService(String serviceId) async {
    var response;
    String myurl = 'http://10.0.2.2:8000/api/Service/delete/$serviceId';
    try {

      response = await http.delete(Uri.parse(myurl),
        headers: {
          'Accept': 'application/json',
        },
      );
      if(response.statusCode==200)
      {
        Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(

            builder: (BuildContext context) =>
                Home(userToken)
        ), (route) => false);
      }
    }
    catch (e) {

    }
  }
  Future<void> deleteWorkshop(String workshopId) async {
    var response;
    String myurl = 'http://10.0.2.2:8000/api/Workshop/delete/$workshopId';
    try {

      response = await http.delete(Uri.parse(myurl),
        headers: {
          'Accept': 'application/json',
        },
      );
      if(response.statusCode==200)
      {
        Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(

            builder: (BuildContext context) =>
                Home(userToken)
        ), (route) => false);
      }
    }
    catch (e) {

    }
  }
  Future<void> deleteOrder(String orderId) async {
    var response;
    String myurl = 'http://10.0.2.2:8000/api/Service/cancelRequest/$orderId';
    try {
      response = await http.delete(Uri.parse(myurl),
        headers: {
          'Accept': 'application/json',
        },
      );
      if(response.statusCode==200)
      {
        Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(

            builder: (BuildContext context) =>
                Home(userToken)
        ), (route) => false);
      }
    }
    catch (e) {

    }
  }
  Future<List> getEstatesData() async {
    String myurl = 'http://10.0.2.2:8000/api/Estate/viewAll';
    var response;
    try {
      response = await http.get(
        Uri.parse(myurl),
        headers: {
          'Accept': 'application/json',
        },
      );
      return jsonDecode(response.body);
    } catch (e) {
      if(jsonDecode(response.body)=="not found Estate")
        return [{"0":"0"}];
      showItemsAlert('لايوجد اتصال بلانترنت');
    }
  }
  Future<List> getWorkshopsData() async {
    String myurl = 'http://10.0.2.2:8000/api/Workshop/getAll';
    var response;
    try {
      response = await http.get(
        Uri.parse(myurl),
        headers: {
          'Accept': 'application/json',
        },
      );
      return jsonDecode(response.body);
    } catch (e) {
      if(jsonDecode(response.body)=="not found Estate")
        return [{"0":"0"}];
      showItemsAlert('لايوجد اتصال بلانترنت');
    }
  }
  Future<List> getOrdersData() async {
    String myurl = 'http://10.0.2.2:8000/api/RequestService/getAll';
    var response;
    try {
      response = await http.get(
        Uri.parse(myurl),
        headers: {
          'Accept': 'application/json',
        },
      );
      return jsonDecode(response.body);
    } catch (e) {
      if(jsonDecode(response.body)=="not found Estate")
        return [{"0":"0"}];
      showItemsAlert('لايوجد اتصال بلانترنت');
    }
  }
  Future<List> getEstatesForSellimgData() async {
    String myurl = 'http://10.0.2.2:8000/api/Estate/viewForSelling';
    var response;
    try {
      response = await http.get(
        Uri.parse(myurl),
        headers: {
          'Accept': 'application/json',
        },
      );
      return jsonDecode(response.body);
    } catch (e) {
      if(jsonDecode(response.body)=="not found Estate")
        return [{"0":"0"}];
      showItemsAlert('لايوجد اتصال بلانترنت');
    }
  }
  Future<List> getEstatesForRentData() async {
    String myurl = 'http://10.0.2.2:8000/api/Estate/viewForRent';
    var response;
    try {
      response = await http.get(
        Uri.parse(myurl),
        headers: {
          'Accept': 'application/json',
        },
      );
      return jsonDecode(response.body);
    } catch (e) {
      if(jsonDecode(response.body)=="not found Estate")
        return [{"0":"0"}];
      showItemsAlert('لايوجد اتصال بلانترنت');
    }
  }
  Future<List> getEstatesFilteringData() async {
    String myurl = 'http://10.0.2.2:8000/api/Estate/search';
    var response;
    try {
      response = await http.post(Uri.parse(myurl), headers: {
        'Accept': 'application/json',
      }, body: {
        "area": selectedValueEstateArea == null ? "" : selectedValueEstateArea,
        "type": selectedValueEstateType==null ? "" :selectedValueEstateType,
        "pricefrom":selectedValueEstatePrice==null ? "":"${fromPriceSpaceForFilteringData(selectedValueEstatePrice)}",
        "priceto":selectedValueEstatePrice==null ? "":"${toPriceSpaceForFilteringData(selectedValueEstatePrice)}",
        "spacefrom":selectedValueEstateSpace==null ? "":"${fromPriceSpaceForFilteringData(selectedValueEstateSpace)}",
        "spaceto":selectedValueEstateSpace==null ? "":"${toPriceSpaceForFilteringData(selectedValueEstateSpace)}",
      }
      );

      return jsonDecode(response.body);

    } catch (e) {
      if(jsonDecode(response.body)=="not found Estate")
        return [{"0":"0"}];
      showItemsAlert("لا يوجد اتصال بلانترنت");

    }
  }
  List<String> twoItemForDropDown(List data){
    if(data.length==1)
      return null;
    else
      return data;

  }
  void filter(List data, String type) {
    switch (type) {
      case 'عقارات':
        for (int i = 0; i < data.length; i++) {
          estatearea.add(data[i]['area']);
          estateTypes.add(data[i]['type']);
        }


        estatearea = estatearea.toSet().toList();
        estateTypes = estateTypes.toSet().toList();
        twoItemForDropDown(estatearea);
        twoItemForDropDown(estateTypes);
        break;
      case 'سيارات':
        for (int i = 0; i < data.length; i++) {

          carCity.add(data[i]['city']);
          carManufacturingYear.add((data[i]['manufacturingYear']).toString());
          carName.add(data[i]['name']);
        }
        carCity = carCity.toSet().toList();
        carManufacturingYear = carManufacturingYear.toSet().toList();
        carName = carName.toSet().toList();
        twoItemForDropDown(carCity);
        twoItemForDropDown(carManufacturingYear);
        twoItemForDropDown(carName);
        break;
    }
  }
  Widget showAdv(){
     return  FutureBuilder(future: getAdvData(),
         builder:(BuildContext context, AsyncSnapshot snapshot){
       if(snapshot.hasData){
       return Container(
        color: Colors.white,
        child: Column(children: <Widget>[
          Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int postion) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        //height: MediaQuery.of(context).size.height /3,
                        width:  MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Column(children: [
                          Container(

                              child:
   Image.network('http://10.0.2.2:8000/images/AdvertisementPictures/${snapshot.data[postion]['image']}'
   ,fit: BoxFit.cover)

                                ,height: 200,
                            width:  MediaQuery.of(context).size.width,
                        ),


                          Padding(padding: EdgeInsets.only(left: 20)),

                          Text(
                            snapshot.data[postion]['describe'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue.shade900,
                            ),
                          ),


                          Padding(padding: EdgeInsets.only(top: 10)),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: () {

                                       deleteAdv(snapshot.data[postion]['id'].toString());

                                    },
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            OutlinedBorder>(
                                            StadiumBorder()),
                                        backgroundColor:
                                        MaterialStateProperty.all<
                                            Color>(Colors.purple)),
                                    child: Row(children: [
                                      Text(
                                        "حذف",
                                        style:
                                        TextStyle(color: Colors.white),
                                      ),
                                      Icon(Icons.delete)
                                    ])),

                                Padding(padding: EdgeInsets.only(left: 5,right: 5)),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder:
                                                (BuildContext context) =>
                                                UpdateItem(type, userToken,'${snapshot.data[postion]['id']}')));
                                  },
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          OutlinedBorder>(StadiumBorder()),
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.purple)),
                                  child: Row(children: [
                                    Text(
                                      "تعديل",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Icon(Icons.app_registration)
                                  ]),
                                )
                              ]),

                          Padding(padding: EdgeInsets.only(top: 5))

                          // typeSearch(searchType,postion)
                        ]),
                      ),
                    );
                  })),
        ]))
   ;}
       else
         return Center(child: CircularProgressIndicator(),);
     });
  }
  Widget showService(){
    return  FutureBuilder(future: getServiceData(),
    builder:(BuildContext context, AsyncSnapshot snapshot){
    if(snapshot.hasData){
    return ListView(
    scrollDirection: Axis.horizontal,
    children: <Widget>[
    SizedBox(height: 15.0),
    Container(
    color: Colors.grey,
    width: MediaQuery.of(context).size.width,

    child: GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,


    ),
    itemCount:snapshot.data.length ,
    itemBuilder:(BuildContext context, int postion) {
    return _buildCard(snapshot.data[postion]['nameService'], 'http://10.0.2.2:8000/images/ServicePictures/${snapshot.data[postion]['imageService']}',
        snapshot.data[postion]['id']  , context);
    },

    )),
    SizedBox(height: 15.0)
    ],
    );}
    else return Center(child: CircularProgressIndicator(),);
    }
    );
  }
  Widget showEstate(){
    return  FutureBuilder(
        future: estateFiltering(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
    if (snapshot.data[0]["0"] != '0') {
    filter(snapshot.data, type);
     return Container(
        color: Colors.white,
        child: Column(children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 10)),
         SingleChildScrollView(
           scrollDirection: Axis.horizontal,
          child: Row(

            children: [

              DropdownButtonHideUnderline(
                child: DropdownButton2(
                  hint: Text(
                    'النوع',
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: estateTypes
                      .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
                      .toList(),
                  value: selectedValueEstateType,
                  onChanged: (value) {
                    setState(() {
                      selectedValueEstateType = value;
                    });
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ShowItems(
                                    type,
                                    'search',
                                    '',
                                    selectedValueEstateType,
                                    selectedValueEstateSpace,
                                    selectedValueEstatePrice,
                                    selectedValueEstateArea,
                                    selectedValueCarName,
                                    selectedValueCarManufacturingYear,
                                    selectedValueCarPrice,
                                    selectedValueCarCity
                                    ,userToken))
                        , (route) => false
                    );
                  },
                  buttonElevation: 2,
                  itemPadding: const EdgeInsets.only(left: 14, right: 1),
                  buttonHeight: 50,
                  buttonWidth: 120,
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.black26,
                    ),
                    color: Colors.grey,
                  ),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white,
                  ),
                  dropdownElevation: 8,
                  scrollbarRadius: const Radius.circular(40),

                ),
              ),
              //dropDown('النوع', selectedValueEstateType, estateTypes),
              Padding(padding: EdgeInsets.only(right: 5)),
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                  hint: Text(
                    'المساحة',
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: estateSpace
                      .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
                      .toList(),
                  value: selectedValueEstateSpace,
                  onChanged: (value) {
                    setState(() {
                      selectedValueEstateSpace = value;
                    });
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ShowItems(
                                   type,
                                    'search',
                                    '',
                                    selectedValueEstateType,
                                    selectedValueEstateSpace,
                                    selectedValueEstatePrice,
                                    selectedValueEstateArea,
                                    selectedValueCarName,
                                    selectedValueCarManufacturingYear,
                                    selectedValueCarPrice,
                                    selectedValueCarCity
                                ,userToken))
                        , (route) => false
                    );
                  },
                  buttonElevation: 2,
                  itemPadding: const EdgeInsets.only(left: 14, right: 1),
                  buttonHeight: 50,
                  buttonWidth: 120,
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.black26,
                    ),
                    color: Colors.grey,
                  ),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white,
                  ),
                  dropdownElevation: 8,
                  scrollbarRadius: const Radius.circular(40),

                ),
              ),
              //dropDown('المساحة',selectedValueEstateSpace,estateSpace),
              Padding(padding: EdgeInsets.only(right: 5)),
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                  hint: Text(
                    'السعر',
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).hintColor,
                    ),
                  ),

                  items: estatePrice
                      .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
                      .toList(),
                  value: selectedValueEstatePrice,
                  onChanged: (value) {
                    setState(() {
                      selectedValueEstatePrice = value;
                    });
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ShowItems(
                                    type,
                                    'search',
                                    '',
                                    selectedValueEstateType,
                                    selectedValueEstateSpace,
                                    selectedValueEstatePrice,
                                    selectedValueEstateArea,
                                    selectedValueCarName,
                                    selectedValueCarManufacturingYear,
                                    selectedValueCarPrice,
                                    selectedValueCarCity,
                                userToken))
                        , (route) => false
                    );
                  },
                  buttonElevation: 2,
                  itemPadding: const EdgeInsets.only(left: 14, right: 14),
                  buttonHeight: 50,
                  buttonWidth: 120,
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.black26,
                    ),
                    color: Colors.grey,
                  ),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white,
                  ),
                  dropdownElevation: 8,
                  scrollbarRadius: const Radius.circular(40),

                ),
              ),
              //dropDown('السعر',selectedValueEstatePrice,estatePrice),
              Padding(padding: EdgeInsets.only(right: 5)),
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                  hint: Text(
                    'المنطقة',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: estatearea
                      .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
                      .toList(),
                  value: selectedValueEstateArea,
                  onChanged: (value) {
                    setState(() {
                      selectedValueEstateArea = value;
                    });
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ShowItems(
                                   type,
                                    'search',
                                    '',
                                    selectedValueEstateType,
                                    selectedValueEstateSpace,
                                    selectedValueEstatePrice,
                                    selectedValueEstateArea,
                                    selectedValueCarName,
                                    selectedValueCarManufacturingYear,
                                    selectedValueCarPrice,
                                    selectedValueCarCity,
                                userToken))
                        , (route) => false
                    );
                  },
                  buttonElevation: 2,
                  itemPadding: const EdgeInsets.only(left: 14, right: 2),
                  buttonHeight: 50,
                  buttonWidth: 120,
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.black26,
                    ),
                    color: Colors.grey,
                  ),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white,
                  ),
                  dropdownElevation: 8,
                  scrollbarRadius: const Radius.circular(40),

                ),
              ),
            ],

          )),
          Padding(padding: EdgeInsets.only(top: 10)),
          Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int postion) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        color: Colors.white,
                        child: Column(children: [
                          Container(
                            padding: EdgeInsets.only(top: 15),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 4,
                            child: ImageSlideshow(
                              width: double.infinity,
                              height: 200,
                              initialPage: 0,
                              indicatorColor: Colors.blue,
                              indicatorBackgroundColor: Colors.grey,
                              onPageChanged: (value) {},
                              autoPlayInterval: 3000,
                              isLoop: true,
                              children: showEstatesImages(
                                  snapshot.data[postion]
                                  ['image_estate'])
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left: 20)),

                          Text(
                            'نوع العقار : ' +
                                '${snapshot.data[postion]['type']}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue.shade900,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Text( 'المنطقة:' +
                              '${snapshot.data[postion]['area']}',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue.shade900,
                              )),

                          Padding(padding: EdgeInsets.only(top: 10)),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                     deleteEstate('${snapshot.data[postion]["id"]}');
                                    },
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            OutlinedBorder>(
                                            StadiumBorder()),
                                        backgroundColor:
                                        MaterialStateProperty.all<
                                            Color>(Colors.purple)),
                                    child: Row(children: [
                                      Text(
                                        "حذف",
                                        style:
                                        TextStyle(color: Colors.white),
                                      ),
                                      Icon(Icons.delete)
                                    ])),
                                Padding(padding: EdgeInsets.only(left: 5,right: 5)),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext
                                              context) =>
                                                  ItemDetail('estate',snapshot.data,postion)));
                                    },
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            OutlinedBorder>(
                                            StadiumBorder()),
                                        backgroundColor:
                                        MaterialStateProperty.all<
                                            Color>(Colors.purple)),
                                    child: Row(children: [
                                      Text(
                                        "المزيد",
                                        style:
                                        TextStyle(color: Colors.white),
                                      ),
                                      Icon(Icons.read_more)
                                    ])),
                                Padding(padding: EdgeInsets.only(left: 5,right: 5)),
                                ElevatedButton(
                                  onPressed: () {
                                    updateEstate('${snapshot.data[postion]["id"]}');
                                  },
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          OutlinedBorder>(StadiumBorder()),
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.purple)),
                                  child: Row(children: [
                                    Text(
                                      "تعديل",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Icon(Icons.app_registration)
                                  ]),
                                )
                              ]),

                          Padding(padding: EdgeInsets.only(top: 5))

                          // typeSearch(searchType,postion)
                        ]),
                      ),
                    );
                  })),
        ]));}else
      return Center(child: Text('لا يوجد عقارات'));}
    return Center(child: CircularProgressIndicator());});
  }
  Widget showCar(){
    return FutureBuilder(
        future: carFiltering(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
    if (snapshot.data[0]["0"] != '0') {
      filter(snapshot.data, type);
      return Container(
          child: Column(children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 10)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    hint: Text(
                      'النوع',

                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme
                            .of(context)
                            .hintColor,
                      ),
                    ),
                    items: carName
                        .map((item) =>
                        DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                        .toList(),
                    value: selectedValueCarName,
                    onChanged: (value) {
                      setState(() {
                        selectedValueCarName = value;
                      });

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ShowItems(
                                      type,
                                      '',
                                      'search',
                                      selectedValueEstateType,
                                      selectedValueEstateSpace,
                                      selectedValueEstatePrice,
                                      selectedValueEstateArea,
                                      selectedValueCarName,
                                      selectedValueCarManufacturingYear,
                                      selectedValueCarPrice,
                                      selectedValueCarCity,
                                      userToken))
                          , (route) => false);
                    },
                    buttonElevation: 2,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    buttonHeight: 50,
                    buttonWidth: 120,
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.black26,
                      ),
                      color: Colors.grey,
                    ),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white,
                    ),
                    dropdownElevation: 8,
                    scrollbarRadius: const Radius.circular(40),

                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 5)),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    hint: Text(
                      'سنة الصنع',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme
                            .of(context)
                            .hintColor,
                      ),
                    ),
                    items: carManufacturingYear
                        .map((item) =>
                        DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                        .toList(),
                    value: selectedValueCarManufacturingYear,
                    onChanged: (value) {
                      setState(() {
                        selectedValueCarManufacturingYear = value;
                      });
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ShowItems(
                                      type,
                                      '',
                                      'search',
                                      selectedValueEstateType,
                                      selectedValueEstateSpace,
                                      selectedValueEstatePrice,
                                      selectedValueEstateArea,
                                      selectedValueCarName,
                                      selectedValueCarManufacturingYear,
                                      selectedValueCarPrice,
                                      selectedValueCarCity,
                                      userToken))
                          , (route) => false);
                    },
                    buttonElevation: 2,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    buttonHeight: 50,
                    buttonWidth:
                        120,
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.black26,
                      ),
                      color: Colors.grey,
                    ),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white,
                    ),
                    dropdownElevation: 8,
                    scrollbarRadius: const Radius.circular(40),

                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 5)),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    hint: Text(
                      'السعر',

                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme
                            .of(context)
                            .hintColor,
                      ),
                    ),
                    items: carPrice
                        .map((item) =>
                        DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                        .toList(),
                    value: selectedValueCarPrice,
                    onChanged: (value) {
                      setState(() {
                        selectedValueCarPrice = value;
                      });
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ShowItems(
                                      type,
                                      '',
                                      'search',
                                      selectedValueEstateType,
                                      selectedValueEstateSpace,
                                      selectedValueEstatePrice,
                                      selectedValueEstateArea,
                                      selectedValueCarName,
                                      selectedValueCarManufacturingYear,
                                      selectedValueCarPrice,
                                      selectedValueCarCity,
                                      userToken))
                          , (route) => false);
                    },
                    buttonElevation: 2,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    buttonHeight: 50,
                    buttonWidth: 120,
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.black26,
                      ),
                      color: Colors.grey,
                    ),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white,
                    ),
                    dropdownElevation: 8,
                    scrollbarRadius: const Radius.circular(40),

                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 5)),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    hint: Text(
                      'المنطقة',

                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme
                            .of(context)
                            .hintColor,
                      ),
                    ),
                    items: carCity
                        .map((item) =>
                        DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                        .toList(),
                    value: selectedValueCarCity,
                    onChanged: (value) {
                      setState(() {
                        selectedValueCarCity = value;
                      });
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ShowItems(
                                      type,
                                      '',
                                      'search',
                                      selectedValueEstateType,
                                      selectedValueEstateSpace,
                                      selectedValueEstatePrice,
                                      selectedValueEstateArea,
                                      selectedValueCarName,
                                      selectedValueCarManufacturingYear,
                                      selectedValueCarPrice,
                                      selectedValueCarCity,
                                      userToken))
                          , (route) => false);
                    },
                    buttonElevation: 2,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    buttonHeight: 50,
                    buttonWidth:120,
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.black26,
                      ),
                      color: Colors.grey,
                    ),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white,
                    ),
                    dropdownElevation: 8,
                    scrollbarRadius: const Radius.circular(40),

                    //    BoxDecoration(color: Colors.purple),
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            )),
            Padding(padding: EdgeInsets.only(top: 10)),
            Expanded(
              child: Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int postion) {
                        return Center(
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                child: Column(children: [
                                  Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 4,
                                    child: ImageSlideshow(
                                      width: double.infinity,
                                      height: 200,
                                      initialPage: 0,
                                      indicatorColor: Colors.blue,
                                      indicatorBackgroundColor: Colors.grey,
                                      onPageChanged: (value) {},
                                      autoPlayInterval: 3000,
                                      isLoop: true,
                                      children: showCarsImages(snapshot
                                          .data[postion]['image_car'])
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 20, top: 10)),
                                  Text(
                                    '${snapshot.data[postion]['name']} ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.blue.shade900,
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 10)),
                                  Text( 'سنة الصنع : ' +
                                      '${snapshot.data[postion]['manufacturingYear']}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.blue.shade900,
                                      )),
                                  Padding(padding: EdgeInsets.only(top: 10)),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              deleteCar('${snapshot.data[postion]["id"]}');
                                            },
                                            style: ButtonStyle(
                                                shape: MaterialStateProperty
                                                    .all<
                                                    OutlinedBorder>(
                                                    StadiumBorder()),
                                                backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.purple)),
                                            child: Row(children: [
                                              Text(
                                                "حذف",
                                                style:
                                                TextStyle(color: Colors.white),
                                              ),
                                              Icon(Icons.delete)
                                            ])),
                                        Padding(padding: EdgeInsets.only(
                                            left: 5, right: 5)),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                      context) =>
                                                          ItemDetail(
                                                              'car',snapshot.data,postion)));
                                            },
                                            style: ButtonStyle(
                                                shape: MaterialStateProperty
                                                    .all<
                                                    OutlinedBorder>(
                                                    StadiumBorder()),
                                                backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.purple)),
                                            child: Row(children: [
                                              Text(
                                                "المزيد",
                                                style:
                                                TextStyle(color: Colors.white),
                                              ),
                                              Icon(Icons.read_more)
                                            ])),
                                        Padding(padding: EdgeInsets.only(
                                            left: 5, right: 5)),
                                        ElevatedButton(
                                          onPressed: () {
                                           updateCar('${snapshot.data[postion]["id"]}');
                                          },
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                  OutlinedBorder>(
                                                  StadiumBorder()),
                                              backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.purple)),
                                          child: Row(children: [
                                            Text(
                                              "تعديل",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Icon(Icons.app_registration)
                                          ]),
                                        )
                                      ]),
                                  Padding(padding: EdgeInsets.only(top: 5))
                                ]),
                              )),
                        );
                      })),
            )
          ]));
    }
    else
      return Center(child: Text('لا يوجد سيارات'));
    }
    else
      return Center(child: CircularProgressIndicator());
        }
        );
  }
Widget showWorkshops(){
    return FutureBuilder(
        future: getWorkshopsData(),
        builder:  (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            if (snapshot.data[0]["0"] != '0'){
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  scrollDirection: Axis.vertical,
                   itemBuilder: (BuildContext context, int postion){
                  return  ListTile(
                    title: Text(snapshot.data[postion]["typeOfWorkshop"]),
                    subtitle: Text(snapshot.data[postion]["area"]),
                    leading: Icon(Icons.wb_incandescent_outlined),
                    onTap: (){workshopAlert('${snapshot.data[postion]["typeOfWorkshop"]}','${snapshot.data[postion]["nameOfOwnerWorkshop"]}','${snapshot.data[postion]["phoneNumberOfOwnerWorkshop"]}','${snapshot.data[postion]["area"]}','${snapshot.data[postion]["id"]}');},
                  ) ;
              });
            }
            else
              return Center(child: Text('لا يوجد ورشات'));
          }
          else return Center(child: CircularProgressIndicator(),);
    }
    );
}
  Widget showOrders(){
    return FutureBuilder(
        future: getOrdersData(),
        builder:  (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            if (snapshot.data[0]["0"] != '0'){
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int postion){
                    return  ListTile(
                      title: Text('${snapshot.data[postion]["mobile"]}'),
                     // subtitle: Text(snapshot.data[postion]["descriptionOfTheProblem"]),
                      leading: Icon(Icons.reorder_rounded),
                  onTap: ()async{orderAlert('${snapshot.data[postion]["mobile"]}', '${snapshot.data[postion]["descriptionOfTheProblem"]}','${snapshot.data[postion]["id"]}' );},  ) ;
                  });
            }
            else
              return Center(child: Text('لا يوجد ورشات'));
          }
          else return Center(child: CircularProgressIndicator(),);
        }
    );
  }
  Widget navigationBar() {
    if (type == 'عقارات') {
      return BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              title: Text('الرئيسية'), icon: Icon(Icons.home_filled)),
          BottomNavigationBarItem(
              title: Text('بيع'), icon: Icon(Icons.home_work)),
          BottomNavigationBarItem(
              title: Text('آجار'), icon: Icon(Icons.home_work_outlined)),

        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.purple.shade800,
        onTap: navigationBottomEstate,
        fixedColor: Colors.white,
        unselectedItemColor: Colors.white,
      );
    }
    if (type == 'سيارات') {
      return BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              title: Text('الرئيسية'), icon: Icon(Icons.home_filled)),

          BottomNavigationBarItem(
              title: Text('اعدادات'), icon: Icon(Icons.home_filled)),


        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.purple.shade800,
        onTap: navigationBottomCar,
        fixedColor: Colors.white,
        unselectedItemColor: Colors.white,
      );
    }
    if (type == 'خدمات') {
      return BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              title: Text('الرئيسية'), icon: Icon(Icons.home_filled)),
          BottomNavigationBarItem(
              title: Text('الطلبات'), icon: Icon(Icons.rate_review)),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.purple.shade800,
        onTap: navigationBottomService,
        fixedColor: Colors.white,
        unselectedItemColor: Colors.white,
      );
    }
    if (type == 'الطلبات') {
      return BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              title: Text('الرئيسية'), icon: Icon(Icons.home_filled)),
          BottomNavigationBarItem(
              title: Text('الطلبات'), icon: Icon(Icons.rate_review)),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.purple.shade800,
        onTap: navigationBottomService,
        fixedColor: Colors.white,
        unselectedItemColor: Colors.white,
      );
    }
  }
  Widget _buildCard(String name, String imgPath,serviceId, context) {
    return Container(
        //height: MediaQuery.of(context).size.height*3 ,
        decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(15)),
     //   padding: EdgeInsets.only(top: 2.0, bottom: 2.0, left: 5.0, right: 5.0),
      child: Column(children: [
            Container(
             height: MediaQuery.of(context).size.height /10,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(imgPath), fit: BoxFit.fill)),
            ),
            Container(
              //height: MediaQuery.of(context).size.height /20,
              color: Colors.purple,
              child: Center(
                child: Text(
                  name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
        Padding(padding: EdgeInsets.only(top: 10)),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    deleteService(serviceId.toString());
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<
                          OutlinedBorder>(
                          StadiumBorder()),
                      backgroundColor:
                      MaterialStateProperty.all<
                          Color>(Colors.purple)),
                  child: Row(children: [
                    Text(
                      "حذف",
                      style:
                      TextStyle(color: Colors.white),
                    ),
                    Icon(Icons.delete)
                  ])),
              Padding(padding: EdgeInsets.only(left: 5,right: 5)),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder:
                              (BuildContext context) =>
                              UpdateItem(type, userToken,serviceId.toString())));
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<
                        OutlinedBorder>(StadiumBorder()),
                    backgroundColor:
                    MaterialStateProperty.all<Color>(
                        Colors.purple)),
                child: Row(children: [
                  Text(
                    "تعديل",
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(Icons.app_registration)
                ]),

              )
            ]),

          ]),
        );
  }
  Widget show(String type) {
    if (type == 'عقارات') {
      return showEstate();
    } else if (type == 'سيارات') {
     return showCar();
    }
    else if (type == 'خدمات') {
    return showService();
    }
    else if (type=='إعلانات')
      {
     return  showAdv();
      }
    else if (type=='ورشات')
    {
      return  showWorkshops();
    }
    else if (type=='الطلبات')
    {
      return showOrders();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.purple,
        ),
        body:show(type)

        ,
        bottomNavigationBar: navigationBar(),
      ),
    );
  }
}
