import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Signup extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return SignupState();
  }
}

class SignupState extends State<Signup> {
TextEditingController userName=new TextEditingController();
TextEditingController mobile=new TextEditingController();
TextEditingController password=new TextEditingController();
GlobalKey<FormState>formStateSignup=new GlobalKey<FormState>();
String userNameValidator(String val) {
  if (val
      .trim()
      .isEmpty) return  'اسم المستخدم لا يجب أن يكون فارغاً';
}

String mobileValidator(String val){
  if (val.trim().isEmpty)
    return'رقم الهاتف الجوال لا يجب أن يكون فارغاً';
  //"Phone number can't empty";
  if (val.trim().length<10)
    return 'رقم الهاتف الجوال غير صالح ';
  if(val.trim().length>10)
    return 'رقم الهاتف الجوال غير صالح ';
  if(val.trim().trim().substring(0,2)!="09")
    return 'رقم الهاتف الجوال يحب أن يبدأ ب 09 ';

}
String passwordValidator(String val){
  if (val.trim().isEmpty)
    return 'كلمة السر لا يجب أن تكون فارغة';
  if (val.trim().length<8)
    return 'كلمة السر لا يجب أن تكون أقل من 8 حروف';
  if(val.trim().length>12)
    return ' كلمة السر  لا يجب أن تكون أكثر من 12 حرفاً';

}

Future<Widget>signUpAlert(String msg) async {


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






  void signup () async{
    var formData=formStateSignup.currentState;
    if(formData.validate()) {
      formData.save();

    var response;
    String myurl='http://10.0.2.2:8000/api/register';
      Uri myUri=Uri.parse(myurl);
    try {
       response = await http.post(Uri.parse("http://10.0.2.2:8000/api/register"),
          headers: {'Accept': 'application/json',
          },
          body: {
            "name": userName.text,
            "mobile": mobile.text,
            "role": "Admin",
            "password": password.text
          });
       switch(response.statusCode.toString())
       {
         case '200':  Navigator.pushNamed(context, '/Login');break;
         case '500':signUpAlert('هذا الحساب موجود مسبقاً');break;
         default : signUpAlert('تحقق من الاتصال بلانترنت');break;
       }
       print(response.body.toString());
       print(response.statusCode.toString());
    }
    catch(e)
    {

      signUpAlert('لا يوجد اتصال بالانترنت');
    }
  }}

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('انشاء حساب'),
            backgroundColor: Colors.purple.shade900,
          ),
          body:
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/login.jpg'),
                    fit: BoxFit.fill)
            )
            ,  height: MediaQuery.of(context).size.height,
            child: Form(
                key:formStateSignup,
                child:SingleChildScrollView(
                    child:Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/4,left: MediaQuery.of(context).size.width/20,right: MediaQuery.of(context).size.width/20),
                      child: Column(
                        children: <Widget>[

                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                          Color.fromRGBO(143, 148, 251, .2),
                                          blurRadius: 20.0,
                                          offset: Offset(0, 10))
                                    ]),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey.shade100))),
                                      child: TextFormField(
                                        validator: userNameValidator,
                                        controller: userName,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText:"اسم المستخدم",
                                          hintStyle:
                                          TextStyle(color: Colors.grey[400]),
                                          icon: Icon(Icons.account_box),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey.shade100))),
                                      child: TextFormField(
                                        validator: mobileValidator,
                                        controller: mobile,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText:"رقم الهاتف الجوال",
                                          hintStyle:
                                          TextStyle(color: Colors.grey[400]),
                                          icon: Icon(Icons.call),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        validator: passwordValidator,
                                        controller: password,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "كلمة السر",
                                            hintStyle: TextStyle(
                                                color: Colors.grey[400]),
                                            icon: Icon(Icons.lock)),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                          SizedBox(
                            height: 30,
                          ),

                              Container(
                                  height: 50,
                                  child: Center(
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all<Color>(
                                                Colors.purple.shade900)),

                                        onPressed: () {
                                          signup();
                                         // Navigator.pushNamed(context, '/home');
     },
                                        child: Text(
                                          'انشاء حساب',
                                          style: TextStyle(
                                              color: Colors.white),
                                        ),

                                        //shape: StadiumBorder()
                                        //color: Colors.indigoAccent
                                      ))
                              )
                          ,


                        ],
                      ),)
                )


            ),
          ),
        )
    );

  }
}
