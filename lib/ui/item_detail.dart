import 'package:circle_button/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
class ItemDetail extends StatefulWidget {
  String type;
  List data;
  int pos;

  ItemDetail(this.type, this.data, this.pos);

  @override
  State<StatefulWidget> createState() {
    return ItemDetailState(this.type, this.data, this.pos);

  }
}
class ItemDetailState extends State<ItemDetail>{
  String type;
  List data;
  int pos;

  ItemDetailState(this.type, this.data, this.pos);
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

  Widget cardDetail(String text1,String text2,IconData icon){
   return Container(

        padding: EdgeInsets.only(left: 3, right: 3),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.grey.shade500))),
        child: Card(
          color: Colors.white,
            elevation: 5,
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                child:  Padding(padding:EdgeInsets.only(left: 10),
            child: Text(text2,
                      style: TextStyle(
                        fontSize: 22.0,
fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )))),
      Text(text1,
                style: TextStyle(
                  fontSize: 22.0,
fontWeight: FontWeight.bold,
                  color: Colors.purple.shade900,
                ))
       ,Padding(padding:EdgeInsets.only(left: 10),
                       child :Icon(icon))
                  ]))
        );
  }

  Widget carDetail(
      context,
      String text1,
      String text2,
      String text3,
      String text4,
      String text5,
      String text6,
      String text7,
      String text8,
      String text9,
      String text10,
      String text11,
      String text12,
      String text13,
      String text14,
      String text15,
      String text16,
      String text17,
      String text18,
      String text19,
      String text20,
      String text21,
      String text22,
      String text23,
      String text24,
      IconData icon1,
      IconData icon2,
      IconData icon3,
      IconData icon4,
      IconData icon5,
      IconData icon6,
      IconData icon7,
      IconData icon8,
      IconData icon9,
      IconData icon10,
      IconData icon11,
      IconData icon12,
      List imagespaths
) {
    return Container(
      color: Colors.white,
      child: ListView(children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child:   ImageSlideshow(
            width: double.infinity,
            height: 200,
            initialPage: 0,
            indicatorColor: Colors.blue,
            indicatorBackgroundColor: Colors.grey,
            onPageChanged: (value) {},
            autoPlayInterval: 3000,
            isLoop: true,
            children: showCarsImages(imagespaths))),
        SizedBox(height: 20.0),
        Container(
            //padding: EdgeInsets.only(left: 40, right: 15),
            child:
    Column(children: [
      cardDetail(text1, text2, icon1),
      cardDetail(text3, text4, icon2),
    cardDetail(text5, text6, icon3),
    cardDetail(text7, text8, icon4),
    cardDetail(text9, text10, icon5),
    cardDetail(text11, text12, icon6),
    cardDetail(text13, text14, icon7),
    cardDetail(text15, text16, icon8),
    cardDetail(text17, text18, icon9),
      cardDetail(text19, text20, icon10),
      cardDetail(text21, text22, icon11),
      cardDetail(text23, text24, icon12),
           SizedBox(height: 20,)
, Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {

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
    //  SizedBox(height: 20,)
    ])),


      ]),
    );
  }
  Widget estateDetail(
      context,
      String text1,
      String text2,
      String text3,
      String text4,
      String text5,
      String text6,
      String text7,
      String text8,
      String text9,
      String text10,
      String text11,
      String text12,
      String text13,
      String text14,
      String text15,
      String text16,
      String text17,
      String text18,
      String text19,
      String text20,

      IconData icon1,
      IconData icon2,
      IconData icon3,
      IconData icon4,
      IconData icon5,
      IconData icon6,
      IconData icon7,
      IconData icon8,
      IconData icon9,
      IconData icon10,
      List imagespaths
      ) {
    return Container(
      color: Colors.white,
      child: ListView(children: [
        Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child:   ImageSlideshow(
                width: double.infinity,
                height: 200,
                initialPage: 0,
                indicatorColor: Colors.blue,
                indicatorBackgroundColor: Colors.grey,
                onPageChanged: (value) {},
                autoPlayInterval: 3000,
                isLoop: true,
                children: showEstatesImages(imagespaths))),
        SizedBox(height: 20.0),
        Container(
          //padding: EdgeInsets.only(left: 40, right: 15),
            child:
            Column(children: [
              cardDetail(text1, text2, icon1),
              cardDetail(text3, text4, icon2),
              cardDetail(text5, text6, icon3),
              cardDetail(text7, text8, icon4),
              cardDetail(text9, text10, icon5),
              cardDetail(text11, text12, icon6),
              cardDetail(text13, text14, icon7),
              cardDetail(text15, text16, icon8),
              cardDetail(text17, text18, icon9),
              cardDetail(text19, text20, icon10),
              SizedBox(height: 20,)
              ,     Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {

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
              //  SizedBox(height: 20,)
            ])),


      ]),
    );
  }

  String estateState(String val){
    if (val=='0')
      return('آجار');
    else
      return('بيع');

  }
  Widget showItemDetail(String type, context) {
    if (type == 'estate') {
      return estateDetail(
          context,
          'اسم المالك :',
          '${data[pos]['estateOwnerName']}',
          'هاتف المالك :',
          '${data[pos]['estateOwnerPhoneNumber']}',
          ' : وضع العقار ',
          estateState('${data[pos]['state']}'),
          '  : نوع العقار ',
          '${data[pos]['type']}',
          ' : المساحة ',
          '${data[pos]['space']}'+" م ",
          ' : عدد الغرف',
          '${data[pos]['numberOfRooms']}',
          ' : عدد الحمامات',
          '${data[pos]['numberOfBathrooms']}',

          ' : المنطقة',
          '${data[pos]['area']}',

          ' : السعر',
          '${data[pos]['price']}'+   "   ل.س"   ,
          ' : الوصف',
          '${data[pos]['describe']}',
          Icons.person,
          Icons.phone,
          Icons.home_work_outlined,
          Icons.home_outlined,
          Icons.space_bar,
          Icons.meeting_room_rounded,
          Icons.bathtub,
          Icons.location_on_rounded,
          Icons.price_change_outlined,
          Icons.description_outlined,
          data[pos]['image_estate']
      );
    } else if (type == 'car') {
      return carDetail(
          context,
          'اسم المالك',
          '${data[pos]['carOwnerName']}',
          'هاتف المالك',
          '${data[pos]['carOwnerPhoneNumber']}',
          ' : الطراز',
          '${data[pos]['name']}',
          ' : الموديل',
          '${data[pos]['model']}',
          ': سنة الصنع',
          '${data[pos]['manufacturingYear']}',
          ' : عدد الكيلومترات',
          'كم ${data[pos]['mileage']}',
          ' : اللون',
          '${data[pos]['color']}',
          ' : ناقل الحركة',
          '${data[pos]['motionVector']}',
          ' : المدينة',
          '${data[pos]['city']}',
          ' : المحرك',
          '${data[pos]['engineCapacity']}'+ "cc",
          ' : السعر',
          ' ${data[pos]['price']} '+" ل.س"   ,

          ' :  الوصف ',
          '${data[pos]['describe']}',
          Icons.person,
          Icons.phone,
          Icons.directions_car,
          Icons.local_car_wash_sharp,
          Icons.date_range_outlined,
          Icons.album_outlined,
          Icons.color_lens_sharp,
          Icons.car_repair,
          Icons.location_on_rounded,
          Icons.cancel_schedule_send_rounded,
          Icons.price_change_outlined,
          Icons.description_outlined,
          data[pos]['image_car']
         );
    }
    else if (type == 'service') {
      return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/serviceBackground.jpg'),
                fit: BoxFit.fill)),
        child: ListView(
          children: [
            Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 6,
                    right: MediaQuery.of(context).size.width / 6,
                    top: 20),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom: BorderSide(color: Colors.grey.shade100))),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "رقم الهاتف الجوال",
                        labelStyle:
                            TextStyle(color: Colors.grey[400], fontSize: 20),
                        icon: Icon(Icons.call),
                      ),
                    ))),
            Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 6,
                    right: MediaQuery.of(context).size.width / 6,
                    top: 20),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom: BorderSide(color: Colors.grey.shade100))),
                    child: TextFormField(
                      maxLines: 10,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "اوصف المشكلة",
                        labelStyle:
                            TextStyle(color: Colors.grey[400], fontSize: 20),
                        icon: Icon(
                          Icons.rate_review_outlined,
                          size: 60,
                        ),
                      ),
                    ))),
            Padding(padding: EdgeInsets.only(top: 40)),
            Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.purple.shade900)),
                        onPressed: () {
                          Navigator.pushNamed(context, '/home');
                        },
                        child: Text(
                          'ارسال طلب',
                          style: TextStyle(color: Colors.white),
                        ))))
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple.shade800,
          elevation: 0.0,
        ),
        body: showItemDetail(type, context));
  }
}
