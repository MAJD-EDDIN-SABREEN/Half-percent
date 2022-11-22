import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:half_percent_admin/ui/add_item.dart';
import 'package:image_picker/image_picker.dart';
import 'home.dart';
import 'package:http/http.dart' as http;
class AddImages extends StatefulWidget{
  String type;
  String estateId;
  String carId;
  String userToken;
  AddImages(this.userToken,this.type, this.estateId, this.carId);


  @override
  State<StatefulWidget> createState() {
  return AddImagesState(this.userToken,this.type, this.estateId, this.carId);
  }
}
class AddImagesState extends State<AddImages>{
  String type;
  String estateId;
  String carId;
  String userToken;
  AddImagesState(this.userToken,this.type, this.estateId, this.carId);
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList=[] ;
  void selectImages() async {
    final List<XFile> selectedImages = await
    imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList.addAll(selectedImages);
    }
    setState((){


    });
  }
  Future<Widget>addImageAlert() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("حدثت مشكلة في اضافة الصور"),
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
  Future<void> addEstateImagesToServer() async {

      String myurl = 'http://10.0.2.2:8000/api/Estate/uploadImage/$estateId';

      for(int i=0;i<imageFileList.length;i++) {
        var request = http.MultipartRequest(
            'POST', Uri.parse(myurl)
        );
        request.headers['Accept'] = 'application/json';
        request.headers['Authorization'] = 'Bearer $userToken';

        request.files.add(await http.MultipartFile.fromPath(
            'imageName',
           imageFileList[i].path
        )
        );
        try {
          var response = await request.send();
          final res = await http.Response.fromStream(response);
        }
        catch (e) {
addImageAlert();
        }
      }
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(
                    builder: (BuildContext context) =>
                       Home(userToken))
          , (route) => false);
    }
  Future<void> addCarImagesToServer() async {
    String myurl = 'http://10.0.2.2:8000/api/Car/uploadImage/$carId';
    for(int i=0;i<imageFileList.length;i++) {
      var request = http.MultipartRequest(
          'POST', Uri.parse(myurl)
      );
      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] = 'Bearer $userToken';

      request.files.add(await http.MultipartFile.fromPath(
          'imageName',
          imageFileList[i].path
      )
      );
      try {
        var response = await request.send();
        final res = await http.Response.fromStream(response);
      }
      catch (e) {
       addImageAlert();
      }
    }
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                Home(userToken))
        , (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return
      Material(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.purple,
            ),
              body: ListView(
      children: [
        TextButton(
          child: new Text('اضافة صورة'),
          onPressed: (){
           selectImages();
          },
        ),
        imageFileList.length==0?Center(child: Text("لم يتم اختيار اي صورة")) :

Container(height:500,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount:imageFileList.length,
            itemBuilder:(BuildContext context, int postion) {
              return
              Container(
                padding: EdgeInsets.only(left: 10,right: 10),
                  height: 400,
             child:  Column(children: [
               SizedBox(
                   height: 350,
                child:Image.file(File(imageFileList[postion].path),
                fit: BoxFit.fill,)
               ),
                IconButton(onPressed:(){
                  setState(() {
                    imageFileList.removeAt(postion);
                  });
                }, icon:Icon(Icons.delete))
              ]
              ));
            }
        ))
           ,
          TextButton(
            child: new Text('رفع الصور'),
            onPressed: (){
              if(type=="عقارات")
              addEstateImagesToServer();
              else if(type=="سيارات")
                addCarImagesToServer();
            },
          ),
      ],
    )));
  }

}