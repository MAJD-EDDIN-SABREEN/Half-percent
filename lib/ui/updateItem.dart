import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'addImages.dart';
import 'home.dart';

class UpdateItem extends StatefulWidget{
  String type;
  String userToken;
  String id;
  UpdateItem(this.type, this.userToken,this.id);

  @override
  State<StatefulWidget> createState() {
    return UpdateItemState(type,userToken,id);
  }

}
class UpdateItemState extends State<UpdateItem>{
  String type;
  String userToken;
  String id;
  UpdateItemState(this.type, this.userToken,this.id);
  File imageAdv;
  File imageService;
  TextEditingController advDetail= new TextEditingController();
  TextEditingController serviceDetail= new TextEditingController();
  TextEditingController estateOwnerName=new TextEditingController();
  TextEditingController estateOwnerPhone=new TextEditingController();
  TextEditingController estateType=new TextEditingController();
  TextEditingController estateState=new TextEditingController();
  TextEditingController estateSpace=new TextEditingController();
  TextEditingController roomNum=new TextEditingController();
  TextEditingController bathNum=new TextEditingController();
  TextEditingController estateLocation=new TextEditingController();
  TextEditingController estateDescription=new TextEditingController();
  TextEditingController estatePrice=new TextEditingController();
  TextEditingController carOwnerName=new TextEditingController();
  TextEditingController carOwnerPhone=new TextEditingController();
  TextEditingController carType=new TextEditingController();
  TextEditingController carModel=new TextEditingController();
  TextEditingController carYear=new TextEditingController();
  TextEditingController carColor=new TextEditingController();
  TextEditingController carTransmission=new TextEditingController();
  TextEditingController carCity=new TextEditingController();
  TextEditingController carDescription=new TextEditingController();
  TextEditingController carEngine=new TextEditingController();
  TextEditingController carPrice=new TextEditingController();
  TextEditingController carMileAge=new TextEditingController();
  TextEditingController workShopOwnerName=new TextEditingController();
  TextEditingController workShopName=new TextEditingController();
  TextEditingController workShopPhone=new TextEditingController();
  TextEditingController workShoparea=new TextEditingController();
  GlobalKey<FormState>formStateUpdateItem=new GlobalKey<FormState>();

  Future<void> updateAdvInServer(String advId) async {
    var formData=formStateUpdateItem.currentState;

    if(formData.validate()) {
      formData.save();
      String myurl = 'http://10.0.2.2:8000/api/advertisement/update/$advId';
      var request = http.MultipartRequest(
          'POST', Uri.parse(myurl)
      );
      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] = 'Bearer $userToken';
      request.fields['describe'] = advDetail.text;
      request.files.add(await http.MultipartFile.fromPath(
          'image',
          imageAdv.path
      )
      );
      try {
        var response = await request.send();
        final res = await http.Response.fromStream(response);
        switch (res.statusCode.toString()) {
          case '200' :Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(

              builder: (BuildContext context) =>
                  Home(userToken)
          ), (route) => false);break;

        }
      }
      catch (e) {


      }
    }
  }
  Future<void> updateServiceInServer(String serviceId) async {
    var formData=formStateUpdateItem.currentState;

    if(formData.validate()) {
      formData.save();
      String myurl = 'http://10.0.2.2:8000/api/Service/update/$serviceId';
      var request = http.MultipartRequest(
          'POST', Uri.parse(myurl)
      );
      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] = 'Bearer $userToken';
      request.fields['nameService'] = serviceDetail.text;
      request.files.add(await http.MultipartFile.fromPath(
          'imageService',
          imageService.path
      )
      );
      try {
        var response = await request.send();
        final res = await http.Response.fromStream(response);
        switch (res.statusCode.toString()) {
          case '200' :Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(

              builder: (BuildContext context) =>
                  Home(userToken)
          ), (route) => false);break;

        }
      }
      catch (e) {


      }
    }
  }
  Future<void>updateEstateInServer (String estateId) async{
    var formData=formStateUpdateItem.currentState;
    var response;
    if(formData.validate()) {
      formData.save();
      String myurl = 'http://10.0.2.2:8000/api/Estate/update/$estateId';
      print(estateStateNumber(estateState.text));
      try {
        response = await http.post(Uri.parse(myurl),
            headers: {
              'Accept': 'application/json',
              'Authorization' : 'Bearer $userToken'
            },
            body: {
              'estateOwnerName':estateOwnerName.text,
              'estateOwnerPhoneNumber':estateOwnerPhone.text,
              'space':'${int.parse(estateSpace.text)}',
              'numberOfBathrooms':'${int.parse(bathNum.text)}',
              'numberOfRooms':'${int.parse(roomNum.text)}',
              'describe':estateDescription.text,
              'price':'${int.parse(estatePrice.text)}',
              'type':estateType.text,
              'area':estateLocation.text,
              'state': estateStateNumber(estateState.text),
            });
        print(response.statusCode.toString());
        switch(response.statusCode.toString())
        {
          case '200':
            var responsebody = jsonDecode(response.body);
            estateId = responsebody['id'].toString();
            Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(

                builder: (BuildContext context) =>
                    AddImages(userToken,type,estateId,'')
            ), (route) => false);break;
          case"500":updateItemAlert();break;

        }

      }

      catch (e) {
        updateItemAlert();
      }
    }
  }
  Future<void>updateCarInServer (String carId) async{
    print("hi");
    var formData=formStateUpdateItem.currentState;
    var response;
    if(formData.validate()) {
      formData.save();
      String myurl = 'http://10.0.2.2:8000/api/Car/update/$carId';
      try {
        response = await http.post(Uri.parse(myurl),
            headers: {
              'Accept': 'application/json',
              'Authorization' : 'Bearer $userToken'
            },
            body: {
              'carOwnerPhoneNumber':'${int.parse(carOwnerPhone.text)}',
              'carOwnerName':carOwnerName.text,
              'motionVector':carTransmission.text,
              'mileage':'${int.parse(carMileAge.text)}',
              'city':carCity.text,
              'color':carColor.text,
              'price':'${int.parse(carPrice.text)}',
              'manufacturingYear':'${int.parse(carYear.text)}',
              'describe':carDescription.text,
              'name':carType.text,
              'engineCapacity':'${int.parse(carEngine.text)}',
              'model':carModel.text
            });
        print(response.statusCode.toString());
        switch(response.statusCode.toString())
        {
          case '200':  var responsebody=jsonDecode(response.body);
          carId = responsebody['id'].toString();
          Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(
              builder: (BuildContext context) =>
                  AddImages(userToken,type,'',carId)
          ), (route) => false);break;
          case"500":updateItemAlert();break;
        }
      }

      catch (e) {
        updateItemAlert();
      }
    }
  }
  Future<void>updateWorkshopInServer (String workshopId) async{
    var formData=formStateUpdateItem.currentState;
    if(formData.validate()) {
      formData.save();
      String myurl = 'http://10.0.2.2:8000/api/Workshop/update/$workshopId';
      try {

        var response = await http.post(Uri.parse(myurl),
            headers: {
              'Accept': 'application/json',

            },
            body: {
              'nameOfOwnerWorkshop':workShopOwnerName.text,
              'phoneNumberOfOwnerWorkshop':workShopPhone.text,
              'typeOfWorkshop':workShopName.text,
              'area':workShoparea.text
            }
        );

        switch(response.statusCode.toString())
        {
          case '200':

            Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(
                builder: (BuildContext context) =>
                    Home(userToken)
            ), (route) => false);break;
          case"500":updateItemAlert();break;

        }

      }

      catch (e) {
        updateItemAlert();
      }
    }
  }
  String advDetailValidator(String val){
    if (val.trim().isEmpty)
      return'???????????? ?????????????? ???? ?????? ???? ???????? ????????????';
  }
  String serviceDetailValidator(String val){
    if (val.trim().isEmpty)
      return'?????? ???????????? ???? ?????? ???? ???????? ????????????';
  }
  String estateOwnerNameValidator(String val){
    if (val.trim().isEmpty)
      return'?????? ???????????? ???? ?????? ???? ???????? ????????????';
  }
  String estateOwnerPhoneValidator(String val){
    if (val.trim().isEmpty)
      return'?????? ???????????? ???????????? ???? ?????? ???? ???????? ????????????';
    if (val.trim().length<10)
      return '?????? ???????????? ???????????? ?????? ???????? ';
    if(val.trim().length>10)
      return '?????? ???????????? ???????????? ?????? ???????? ';
    if(val.trim().trim().substring(0,2)!="09")
      return '?????? ???????????? ???????????? ?????? ???? ???????? ?? 09 ';
  }
  String estateTypeValidator(String val){
    if (val.trim().isEmpty)
      return'?????? ?????????? ???? ?????? ???? ???????? ????????????';

  }
  String estateStateValidator(String val){
    if (val.trim().isEmpty)
      return'?????? ?????????? ???? ?????? ???? ???????? ????????????';

    if (val.trim()!='??????'&&val.trim()!='????????') {
      print(val.trim());
      return '?????? ?????????? ?????? ???? ???????? ?????????? ?????? (??????) ???? (????????)';
    }
  }
  String estateSpaceValidator(String val){
    if (val.trim().isEmpty)
      return'?????????? ?????????? ???? ?????? ???? ???????? ????????????';
  }
  String roomNumValidator(String val){
    if (val.trim().isEmpty)
      return'?????? ?????????? ???? ?????? ???? ???????? ????????????';
  }
  String bathNumValidator(String val){
    if (val.trim().isEmpty)
      return'?????? ???????????????? ???? ?????? ???? ???????? ????????????';
  }
  String estateLocationValidator(String val){
    if (val.trim().isEmpty)
      return'???????????? ???? ?????? ???? ???????? ????????????';
  }
  String estateDescriptionValidator(String val){
    if (val.trim().isEmpty)
      return'?????????? ???? ?????? ???? ???????? ????????????';
  }
  String estatePriceValidator(String val){
    if (val.trim().isEmpty)
      return'?????????? ???? ?????? ???? ???????? ????????????';
  }
  String carOwnerNameValidator(String val){
    if (val.trim().isEmpty)
      return'?????? ???????????? ???? ?????? ???? ???????? ????????????';
  }
  String carOwnerPhoneValidator(String val){
    if (val.trim().isEmpty)
      return'?????? ???????????? ???????????? ???? ?????? ???? ???????? ????????????';
    if (val.trim().length<10)
      return '?????? ???????????? ???????????? ?????? ???????? ';
    if(val.trim().length>10)
      return '?????? ???????????? ???????????? ?????? ???????? ';
    if(val.trim().trim().substring(0,2)!="09")
      return '?????? ???????????? ???????????? ?????? ???? ???????? ?? 09 ';
  }
  String carTypeValidator(String val){
    if (val.trim().isEmpty)
      return'?????? ?????????????? ???? ?????? ???? ???????? ????????????';
  }
  String carModelValidator(String val){
    if (val.trim().isEmpty)
      return'?????????? ?????????????? ???? ?????? ???? ???????? ????????????';
  }
  String carYearValidator(String val){
    if (val.trim().isEmpty)
      return'?????? ?????? ?????????????? ???? ?????? ???? ???????? ????????????';
  }
  String carColorValidator(String val){
    if (val.trim().isEmpty)
      return'?????? ?????????????? ???? ?????? ???? ???????? ????????????';
  }
  String carTransmissionValidator(String val){
    if (val.trim().isEmpty)
      return'???????? ???????? ?????????????? ???? ?????? ???? ???????? ????????????';
  }
  String carCityValidator(String val){
    if (val.trim().isEmpty)
      return'??????????????  ???? ?????? ???? ???????? ????????????';
  }
  String carDescriptionValidator(String val){
    if (val.trim().isEmpty)
      return'?????? ?????????????? ???? ?????? ???? ???????? ????????????';
  }
  String carEngineValidator(String val){
    if (val.trim().isEmpty)
      return'???????? ?????????????? ???? ?????? ???? ???????? ????????????';
  }
  String carPriceValidator(String val){
    if (val.trim().isEmpty)
      return'?????? ?????????????? ???? ?????? ???? ???????? ????????????';
  }
  String carMileAgeValidator(String val){
    if (val.trim().isEmpty)
      return'?????? ?????????????????????? ???? ?????? ???? ???????? ????????????';
  }
  String workShopPhoneValidator(String val){
    if (val.trim().isEmpty)
      return'?????? ???????????? ???????????? ???? ?????? ???? ???????? ????????????';
    if (val.trim().length<10)
      return '?????? ???????????? ???????????? ?????? ???????? ';
    if(val.trim().length>10)
      return '?????? ???????????? ???????????? ?????? ???????? ';
    if(val.trim().trim().substring(0,2)!="09")
      return '?????? ???????????? ???????????? ?????? ???? ???????? ?? 09 ';
  }
  String workShopNameValidator(String val){
    if (val.trim().isEmpty)
      return'?????? ?????????????????????? ???? ?????? ???? ???????? ????????????';
  }
  String workShopOwnerNameValidator(String val){
    if (val.trim().isEmpty)
      return'?????? ?????????????????????? ???? ?????? ???? ???????? ????????????';
  }
  String workShopAreaValidator(String val){
    if (val.trim().isEmpty)
      return'?????? ?????????????????????? ???? ?????? ???? ???????? ????????????';
  }
  String estateStateNumber(String estateStateController){
    if(estateStateController=="??????")
      return '1';
    else
      return '0';
  }
  Future<Widget>updateItemAlert() async {


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("???? ?????? ?????????? ?????????????? ?????????? ???????? ???? ???????? ?????????????? ????????????????"),
          actions: <Widget>[
            TextButton(
              child: new Text('??????????'),
              onPressed: () async {
                Navigator.pushNamed(context, "/home");
              },
            ),
          ],
        );
      },
    );
  }
  Future addAdvPhoto()async{
    final ImagePicker imagePicker = ImagePicker();
    final List<XFile> selectedImages = await
    imagePicker.pickMultiImage();
    final myfile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
     imageAdv= File(myfile.path);
    });
  }
  Future addServicePhoto()async{
    final myfile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      imageService= File(myfile.path);
    });
  }
  Widget updateAdv(){

    return Form(
        key: formStateUpdateItem,
        child:
        Container(
            color: Colors.white,
            child: ListView(

              children: [ Padding(padding: EdgeInsets.only(top: 5)),
                Center(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.purple.shade900),
                          ),
                          onPressed: () {
                            addAdvPhoto();

                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '?????????? ???????? ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Padding(padding: EdgeInsets.only(left: 7)),
                                Icon(Icons.image)
                              ]))),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width/2  ,
                      height: MediaQuery.of(context).size.height/4,
                      child: imageAdv==null?Center(child: Text("???? ???????? ????????")):Image.file(imageAdv),)),
                Padding(padding: EdgeInsets.only(top: 10)),
                Card(
                  child: TextFormField(
                    validator: advDetailValidator,
                    controller: advDetail,
                    decoration: InputDecoration(
                        labelText: '?????? ??????????????',
                        icon: Icon(Icons.description_outlined),
                        border: InputBorder.none),
                  ),
                  elevation: 5,
                ),
                Padding(padding: EdgeInsets.only(top: 20)),
                SizedBox(
                    width: MediaQuery.of(context).size.width/6,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.purple.shade900),
                        ),
                        onPressed: () {
                          updateAdvInServer(id);
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  child: Text(
                                    '?????????? ??????????????',
                                    style: TextStyle(color: Colors.white),
                                  )),
                              Padding(padding: EdgeInsets.only(left: 7)),
                              Icon(Icons.ondemand_video)
                            ]))),
              ],
            )));
  }
  Widget updateService(){

    return Form(
        key: formStateUpdateItem,
        child:
        Container(
            color: Colors.white,
            child: ListView(

              children: [ Padding(padding: EdgeInsets.only(top: 5)),
                Center(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.purple.shade900),
                          ),
                          onPressed: () {
                           addServicePhoto();

                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '?????????? ???????? ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Padding(padding: EdgeInsets.only(left: 7)),
                                Icon(Icons.image)
                              ]))),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width/2  ,
                      height: MediaQuery.of(context).size.height/4,
                      child: imageService==null?Center(child: Text("???? ???????? ????????")):Image.file(imageService),)),
                Padding(padding: EdgeInsets.only(top: 10)),
                Card(
                  child: TextFormField(
                    validator: serviceDetailValidator,
                    controller: serviceDetail,
                    decoration: InputDecoration(
                        labelText: '?????? ????????????',
                        icon: Icon(Icons.description_outlined),
                        border: InputBorder.none),
                  ),
                  elevation: 5,
                ),
                Padding(padding: EdgeInsets.only(top: 20)),
                SizedBox(
                    width: MediaQuery.of(context).size.width/6,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.purple.shade900),
                        ),
                        onPressed: () {
                          updateServiceInServer(id);
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  child: Text(
                                    '?????????? ???????????? ',
                                    style: TextStyle(color: Colors.white),
                                  )),
                              Padding(padding: EdgeInsets.only(left: 7)),
                              Icon(Icons.cleaning_services)
                            ]))),
              ],
            )));
  }

  Widget updateWorkshop(){
    return Form(
        key: formStateUpdateItem,
        child:
        Container(
            color: Colors.white,
            child: ListView(

              children: [
                Padding(padding: EdgeInsets.only(top: 5)),
                Card(
                  child: TextFormField(
                    validator: workShopNameValidator,
                    controller: workShopName,
                    decoration: InputDecoration(
                        labelText: '?????? ????????????',
                        icon: Icon(Icons.description_outlined),
                        border: InputBorder.none),
                  ),
                  elevation: 5,
                ),
                Card(
                  child: TextFormField(
                    validator: workShopOwnerNameValidator,
                    controller: workShopOwnerName,
                    decoration: InputDecoration(
                        labelText: '???????? ????????????',
                        icon: Icon(Icons.description_outlined),
                        border: InputBorder.none),
                  ),
                  elevation: 5,
                ),
                Card(
                  child: TextFormField(
                    validator: workShopPhoneValidator,
                    controller: workShopPhone,
                    keyboardType: TextInputType.phone ,
                    decoration: InputDecoration(
                        labelText: '?????? ???????? ????????????',
                        icon: Icon(Icons.description_outlined),
                        border: InputBorder.none),
                  ),
                  elevation: 5,
                ),
                Card(
                  child: TextFormField(
                    validator: workShopAreaValidator,
                    controller: workShoparea,
                    keyboardType: TextInputType.phone ,
                    decoration: InputDecoration(
                        labelText: '??????????????',
                        icon: Icon(Icons.description_outlined),
                        border: InputBorder.none),
                  ),
                  elevation: 5,
                ),
                Padding(padding: EdgeInsets.only(top: 20)),
                SizedBox(
                    width: MediaQuery.of(context).size.width/6,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.purple.shade900),
                        ),
                        onPressed: () {
                          updateWorkshopInServer(id);
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  child: Text(
                                    '?????????? ????????????',
                                    style: TextStyle(color: Colors.white),
                                  )),
                              Padding(padding: EdgeInsets.only(left: 7)),
                              Icon(Icons.add_business_rounded)
                            ]))),
              ],
            )));
  }
  Widget updateItemPage(){

    if(type=='??????????????'){
      return updateAdv();
    }
    if(type=='??????????'){
       return updateService();
    }
    if(type=='??????????'){

      return updateWorkshop();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple.shade900,
        ),
        body: Container(
          color: Colors.grey,
          child: updateItemPage(),
        ),
      ),
    );
  }

}