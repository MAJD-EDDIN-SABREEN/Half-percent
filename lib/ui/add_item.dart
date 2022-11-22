import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:half_percent_admin/ui/addImages.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'home.dart';
class AddItem extends StatefulWidget {
  String type;
  String userToken;

  AddItem(this.type,this.userToken);

  @override
  State<StatefulWidget> createState() {
    return AddItemState(type,userToken);
  }
}
class AddItemState extends State<AddItem> {
  String type;
  String userToken;
  File imageAdv;
  File imageService;
  List <File> imagesEstate;
  String estateId;
  String carId;

  TextEditingController advDetail=new TextEditingController();
  TextEditingController serviceDetail=new TextEditingController();
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
  GlobalKey<FormState>formStateAddItem=new GlobalKey<FormState>();
  AddItemState(this.type,this.userToken);
  String advDetailValidator(String val){
    if (val.trim().isEmpty)
      return'تفاصيل الإعلان لا يجب أن يكون فارغاً';
  }
  String serviceDetailValidator(String val){
    if (val.trim().isEmpty)
      return'اسم الخدمة لا يجب أن يكون فارغاً';
  }
  String estateOwnerNameValidator(String val){
    if (val.trim().isEmpty)
      return'اسم المالك لا يجب أن يكون فارغاً';
  }
  String estateOwnerPhoneValidator(String val){
    if (val.trim().isEmpty)
      return'رقم الهاتف الجوال لا يجب أن يكون فارغاً';
    if (val.trim().length<10)
      return 'رقم الهاتف الجوال غير صالح ';
    if(val.trim().length>10)
      return 'رقم الهاتف الجوال غير صالح ';
    if(val.trim().trim().substring(0,2)!="09")
      return 'رقم الهاتف الجوال يحب أن يبدأ ب 09 ';
  }
  String estateTypeValidator(String val){
    if (val.trim().isEmpty)
      return'نوع الشقة لا يجب أن يكون فارغاً';

  }
  String estateStateValidator(String val){
    if (val.trim().isEmpty)
      return'وضع الشقة لا يجب أن يكون فارغاً';

    if (val.trim()!='بيع'&&val.trim()!='اجار') {
     print(val.trim());
      return 'وضع الشقة يجب أن يكون حصراً أما (بيع) أو (اجار)';
    }
  }
  String estateSpaceValidator(String val){
    if (val.trim().isEmpty)
      return'مساحة الشقة لا يجب أن يكون فارغاً';
  }
  String roomNumValidator(String val){
    if (val.trim().isEmpty)
      return'عدد الغرف لا يجب أن يكون فارغاً';
  }
  String bathNumValidator(String val){
    if (val.trim().isEmpty)
      return'عدد الحمامات لا يجب أن يكون فارغاً';
  }
  String estateLocationValidator(String val){
    if (val.trim().isEmpty)
      return'الموقع لا يجب أن يكون فارغاً';
  }
  String estateDescriptionValidator(String val){
    if (val.trim().isEmpty)
      return'الوصف لا يجب أن يكون فارغاً';
  }
  String estatePriceValidator(String val){
    if (val.trim().isEmpty)
      return'السعر لا يجب أن يكون فارغاً';
  }
  String carOwnerNameValidator(String val){
    if (val.trim().isEmpty)
      return'اسم المالك لا يجب أن يكون فارغاً';
  }
  String carOwnerPhoneValidator(String val){
    if (val.trim().isEmpty)
      return'رقم الهاتف الجوال لا يجب أن يكون فارغاً';
    if (val.trim().length<10)
      return 'رقم الهاتف الجوال غير صالح ';
    if(val.trim().length>10)
      return 'رقم الهاتف الجوال غير صالح ';
    if(val.trim().trim().substring(0,2)!="09")
      return 'رقم الهاتف الجوال يحب أن يبدأ ب 09 ';
  }
  String carTypeValidator(String val){
    if (val.trim().isEmpty)
      return'نوع السيارة لا يجب أن يكون فارغاً';
  }
  String carModelValidator(String val){
    if (val.trim().isEmpty)
      return'موديل السيارة لا يجب أن يكون فارغاً';
  }
  String carYearValidator(String val){
    if (val.trim().isEmpty)
      return'سنة صنع السيارة لا يجب أن يكون فارغاً';
  }
  String carColorValidator(String val){
    if (val.trim().isEmpty)
      return'لون السيارة لا يجب أن يكون فارغاً';
  }
  String carTransmissionValidator(String val){
    if (val.trim().isEmpty)
      return'ناقل حركة السيارة لا يجب أن يكون فارغاً';
  }
  String carCityValidator(String val){
    if (val.trim().isEmpty)
      return'المدينة  لا يجب أن يكون فارغاً';
  }
  String carDescriptionValidator(String val){
    if (val.trim().isEmpty)
      return'وصف السيارة لا يجب أن يكون فارغاً';
  }
  String carEngineValidator(String val){
    if (val.trim().isEmpty)
      return'محرك السيارة لا يجب أن يكون فارغاً';
  }
  String carPriceValidator(String val){
    if (val.trim().isEmpty)
      return'سعر السيارة لا يجب أن يكون فارغاً';
  }
  String carMileAgeValidator(String val){
    if (val.trim().isEmpty)
      return'عدد الكيلومترات لا يجب أن يكون فارغاً';
  }
  String workShopPhoneValidator(String val){
    if (val.trim().isEmpty)
      return'رقم الهاتف الجوال لا يجب أن يكون فارغاً';
    if (val.trim().length<10)
      return 'رقم الهاتف الجوال غير صالح ';
    if(val.trim().length>10)
      return 'رقم الهاتف الجوال غير صالح ';
    if(val.trim().trim().substring(0,2)!="09")
      return 'رقم الهاتف الجوال يحب أن يبدأ ب 09 ';
  }
  String workShopNameValidator(String val){
    if (val.trim().isEmpty)
      return'عدد الكيلومترات لا يجب أن يكون فارغاً';
  }
  String workShopOwnerNameValidator(String val){
    if (val.trim().isEmpty)
      return'عدد الكيلومترات لا يجب أن يكون فارغاً';
  }
  String workShopAreaValidator(String val){
    if (val.trim().isEmpty)
      return'عدد الكيلومترات لا يجب أن يكون فارغاً';
  }
String estateStateNumber(String estateStateController){
 if(estateStateController=="بيع")
   return '1';
 else
   return '0';
}

  Future<Widget>addItemAlert() async {


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("لم تتم عملية الإضافة بنجاح تأكد من جودة الاتصال بلانترنت"),
          actions: <Widget>[
            TextButton(
              child: new Text('حسناً'),
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
  Future<void> addAdvToServer() async {
    var formData=formStateAddItem.currentState;

    if(formData.validate()) {
      formData.save();
      String myurl = 'http://10.0.2.2:8000/api/advertisement/save';
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
          case"500":addItemAlert();break;

        }
      }
      catch (e) {
        addItemAlert();
      }
    }
  }
  Future<void> addServiceToServer() async {
    var formData=formStateAddItem.currentState;

    if(formData.validate()) {
      formData.save();
      String myurl = 'http://10.0.2.2:8000/api/Service/save';
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
          case '200' :
            Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(
              builder: (BuildContext context) =>
                  Home(userToken)
          ), (route) => false);
            break;
          case"500":  addItemAlert() ;break;
        }
      }
      catch (e) {
        addItemAlert();

      }
    }
  }
  Widget addService(){
    return Form(
        key: formStateAddItem,
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
                                  'تحميل صورة ',
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
                      child: imageService==null?Center(child: Text("لا يوجد صورة")):Image.file(imageService),)),
                Padding(padding: EdgeInsets.only(top: 10)),
                Card(
                  child: TextFormField(
                    validator: serviceDetailValidator,
                    controller: serviceDetail,
                    decoration: InputDecoration(
                        labelText: 'وصف الخدمة',
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
                          addServiceToServer();
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  child: Text(
                                    'اضافة خدمة',
                                    style: TextStyle(color: Colors.white),
                                  )),
                              Padding(padding: EdgeInsets.only(left: 7)),
                              Icon(Icons.add_business_rounded)
                            ]))),
              ],
            )));
  }
  Widget addWorkshop(){
    return Form(
        key: formStateAddItem,
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
                        labelText: 'نوع الورشة',
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
                        labelText: 'صاحب الورشة',
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
                        labelText: 'رقم صاحب الورشة',
                        icon: Icon(Icons.description_outlined),
                        border: InputBorder.none),
                  ),
                  elevation: 5,
                ),
                Card(
                  child: TextFormField(
                    validator: workShopAreaValidator,
                    controller: workShoparea,
                    keyboardType: TextInputType.text ,
                    decoration: InputDecoration(
                        labelText: 'المنطقة',
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
                         addWorkshopToServer();
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  child: Text(
                                    'اضافة ورشة',
                                    style: TextStyle(color: Colors.white),
                                  )),
                              Padding(padding: EdgeInsets.only(left: 7)),
                              Icon(Icons.add_business_rounded)
                            ]))),
              ],
            )));
  }
  Widget addAdv(){
    return Form(
        key: formStateAddItem,
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
                          'تحميل صورة ',
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
            child: imageAdv==null?Center(child: Text("لا يوجد صورة")):Image.file(imageAdv),)),
        Padding(padding: EdgeInsets.only(top: 10)),
        Card(
          child: TextFormField(
            validator: advDetailValidator,
            controller: advDetail,
            decoration: InputDecoration(
                labelText: 'وصف الإعلان',
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
                  addAdvToServer();
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Text(
                            'اضافة إعلان',
                            style: TextStyle(color: Colors.white),
                          )),
                      Padding(padding: EdgeInsets.only(left: 7)),
                      Icon(Icons.add_business_rounded)
                    ]))),
      ],
    )));
  }
  Future<void>addEstateToServer () async{
    var formData=formStateAddItem.currentState;
    var response;
    if(formData.validate()) {
      formData.save();
      String myurl = 'http://10.0.2.2:8000/api/Estate/save';
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
                    AddImages(userToken,type,estateId,carId)
            ), (route) => false);break;
          case"500":addItemAlert();break;

        }

      }

      catch (e) {
addItemAlert();
      }
    }
  }
  Widget addEstate() {
    return Card(
        color: Colors.white,
        elevation: 3,
        child: Form(
          key:formStateAddItem,
            child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 5)),

              Card(
                child: TextFormField(
                  controller: estateOwnerName,
                  validator:estateOwnerNameValidator ,
                  decoration: InputDecoration(
                      labelText: 'اسم المالك',
                      icon: Icon(Icons.person),
                      border: InputBorder.none),
                ),
                elevation: 5,
              ),

              Card(
                child: TextFormField(
                  validator: estateOwnerPhoneValidator,
                  controller: estateOwnerPhone,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      icon: Icon(Icons.phone),
                      border: InputBorder.none,
                      labelText: 'رقم هاتف المالك'),
                ),
                elevation: 5,
              ),
              Card(
                child: TextFormField(
                  validator:estateTypeValidator ,
                  controller: estateType,
                  decoration: InputDecoration(
                      labelText: 'نوع العقار',
                      icon: Icon(Icons.home_outlined),
                      border: InputBorder.none),
                ),
                elevation: 5,
              ),

              Card(
                child: TextFormField(
   validator: estateStateValidator,
                  controller: estateState,
                  decoration: InputDecoration(
                      icon: Icon(Icons.home_work),
                      border: InputBorder.none,
                      labelText: 'وضع الشقة'),
                ),
                elevation: 5,
              ),
              Card(
                child: TextFormField(
              validator: estateSpaceValidator,
                  keyboardType: TextInputType.number,
                  controller: estateSpace,
                  decoration: InputDecoration(
                      labelText: 'المساحة',
                      icon: Icon(Icons.space_bar),
                      border: InputBorder.none),
                ),
                elevation: 5,
              ),

              Card(
                child: TextFormField(
                  validator: bathNumValidator,
                  controller: bathNum,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      icon: Icon(Icons.bathtub_outlined),
                      border: InputBorder.none,
                      labelText: 'عدد الحمامات'),
                ),
                elevation: 5,
              ),
              Card(
                child: TextFormField(
                  validator: roomNumValidator,
                  controller: roomNum,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'عدد الغرف',
                      icon: Icon(Icons.meeting_room_outlined),
                      border: InputBorder.none),
                ),
                elevation: 5,
              ),
              Card(
                child: TextFormField(
                  validator: estateLocationValidator,
                  controller: estateLocation,
                  decoration: InputDecoration(
                      icon: Icon(Icons.location_on_rounded),
                      border: InputBorder.none,
                      labelText: 'الموقع'),
                ),
                elevation: 5,
              ),
              Card(
                child: TextFormField(
                  validator: estateDescriptionValidator,
                  controller: estateDescription,
                  decoration: InputDecoration(
                      labelText: 'الوصف',
                      icon: Icon(Icons.description_outlined),
                      border: InputBorder.none),
                ),
                elevation: 5,
              ),
              Card(
                child: TextFormField(
                 validator:estatePriceValidator ,
                  controller: estatePrice,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'السعر',
                      icon: Icon(Icons.price_change_outlined),
                      border: InputBorder.none),
                ),
                elevation: 5,
              ),
              Padding(padding: EdgeInsets.only(top: 20)),

              SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.purple.shade900),
                      ),
                      onPressed: () {
                        addEstateToServer();
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (BuildContext context) =>
                        //             AddImages(type,userToken)));
                     //    addEstateToServer();
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: Text(
                              'اضافة عقار',
                              style: TextStyle(color: Colors.white),
                            )),
                            Padding(padding: EdgeInsets.only(left: 7)),
                            Icon(Icons.add_business_rounded)
                          ]))),
              Padding(padding: EdgeInsets.only(top: 20)),
            ],
          ),
        )));
  }
  Future<void>addCarToServer () async{
    print("hi");
    var formData=formStateAddItem.currentState;
    var response;
    if(formData.validate()) {
      formData.save();
      String myurl = 'http://10.0.2.2:8000/api/Car/save';
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
                  AddImages(userToken,type,estateId,carId)
          ), (route) => false);break;
          case"500":addItemAlert();break;
        }
      }

      catch (e) {
        addItemAlert();
      }
    }
  }
  Future<void>addWorkshopToServer () async{
    var formData=formStateAddItem.currentState;
    if(formData.validate()) {
      formData.save();
      String myurl = 'http://10.0.2.2:8000/api/Workshop/save';
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
          case"500":addItemAlert();break;

        }

      }

      catch (e) {
addItemAlert();
      }
    }
  }
  Widget addCar(){
    return  Card(
        color: Colors.white,
        elevation: 3,
        child: Form(
            key:formStateAddItem,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 5)),
                  Card(
                    child: TextFormField(
                      validator: carOwnerNameValidator,
                      controller:carOwnerName ,
                      decoration: InputDecoration(
                          labelText: 'اسم المالك',
                          icon: Icon(Icons.person),
                          border: InputBorder.none),
                    ),
                    elevation: 5,
                  ),

                  Card(
                    child: TextFormField(
                       controller: carOwnerPhone,
                      keyboardType: TextInputType.phone,
                      validator:carOwnerPhoneValidator ,
                      decoration: InputDecoration(
                          icon: Icon(Icons.phone),
                          border: InputBorder.none,
                          labelText: 'رقم هاتف المالك'),
                    ),
                    elevation: 5,
                  ),
                  Card(
                    child: TextFormField(
                      validator: carTypeValidator,
                      controller: carType,
                      decoration: InputDecoration(
                          labelText: 'نوع السيارة',
                          icon: Icon(Icons.directions_car),
                          border: InputBorder.none),
                    ),
                    elevation: 5,
                  ),

                  Card(
                    child: TextFormField(
                      controller:carModel ,
                      validator: carModelValidator,
                      decoration: InputDecoration(
                          icon: Icon(Icons.local_car_wash_sharp),
                          border: InputBorder.none,
                          labelText: 'الموديل'),
                    ),
                    elevation: 5,
                  ),
                  Card(
                    child: TextFormField(
                      validator: carYearValidator,
                      controller: carYear,
                        keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'سنة الصنع',
                          icon: Icon(Icons.date_range_outlined),
                          border: InputBorder.none),
                    ),
                    elevation: 5,
                  ),

                  Card(
                    child: TextFormField(
                      controller: carColor,
                      validator: carColorValidator,
                      decoration: InputDecoration(
                          icon: Icon(Icons.color_lens_sharp),
                          border: InputBorder.none,
                          labelText: 'اللون'),
                    ),
                    elevation: 5,
                  ),
                  Card(
                    child: TextFormField(
                      validator: carTransmissionValidator,
                      controller:carTransmission ,
                      decoration: InputDecoration(
                          labelText: 'ناقل الحركة',
                          icon: Icon(Icons.car_repair),
                          border: InputBorder.none),
                    ),
                    elevation: 5,
                  ),
                  Card(
                    child: TextFormField(
                      validator: carMileAgeValidator,
                      controller:carMileAge ,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: '  عدد الكيلومترات',
                          icon: Icon(Icons.space_bar),
                          border: InputBorder.none),
                    ),
                    elevation: 5,
                  ),
                  Card(
                    child: TextFormField(
                      controller: carCity,
                      validator: carCityValidator,
                      decoration: InputDecoration(
                          icon: Icon(Icons.location_on_rounded),
                          border: InputBorder.none,
                          labelText: 'المدينة'),
                    ),
                    elevation: 5,
                  ),
                  Card(
                    child: TextFormField(
                      validator: carDescriptionValidator,
                      controller: carDescription,
                      decoration: InputDecoration(
                          labelText: 'الوصف',
                          icon: Icon(Icons.description_outlined),
                          border: InputBorder.none),
                    ),
                    elevation: 5,
                  ),
                  Card(
                    child: TextFormField(
                      controller:carEngine ,
                      validator: carEngineValidator,
                      keyboardType:TextInputType.number ,
                      decoration: InputDecoration(
                          labelText: 'سعة المحرك',
                          icon: Icon(Icons.cancel_schedule_send_rounded),
                          border: InputBorder.none),
                    ),
                    elevation: 5,
                  ),
                  Card(
                    child: TextFormField(
                      validator:carPriceValidator ,
                      keyboardType: TextInputType.number,
                      controller: carPrice,
                      decoration: InputDecoration(
                          labelText: 'السعر',
                          icon: Icon(Icons.price_change_outlined),
                          border: InputBorder.none),
                    ),
                    elevation: 5,
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),

                  SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.purple.shade900),
                          ),
                          onPressed: () {
                           addCarToServer();
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    child: Text(
                                      'اضافة سيارة',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                Padding(padding: EdgeInsets.only(left: 7)),
                                Icon(Icons.electric_car)
                              ]))),
                  Padding(padding: EdgeInsets.only(top: 20)),
                ],
              ),
            )));
  }
 Widget addItemPage(){
    if(type=='عقارات')
      {
        return addEstate();
      }
    if (type=='سيارات')
      {
        return addCar();
      }
    if(type=='إعلانات'){
      return addAdv();
    }
    if(type=='خدمات'){
      return addService();
    }
    if(type=='ورشات'){
      return addWorkshop();
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
          child: addItemPage(),
        ),
      ),
    );
  }
}
