import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:half_percent_admin/ui/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'log_in.dart';

class AuthContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AuthContainerState();
  }
}

class AuthContainerState extends State<AuthContainer> {
  String token;
  bool initial = true;
  @override
  Widget build(BuildContext context) {
    if (initial) {
      SharedPreferences.getInstance().then((sharedPreferenceValue) {
        setState(() {
          initial = false;
          token = sharedPreferenceValue.getString('token');
        });
      });
      return Center(child: CircularProgressIndicator());
    } else {
      if (token == null) {
        return Login();
      } else {
        return Home(token);
      }
    }
  }
}
