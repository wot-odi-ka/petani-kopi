import 'dart:convert';

import 'package:petani_kopi/model/users.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DBkey.dart';

class DB {
  static saveUser(Users user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map loginMap = user.toMap();
    String jsonBody = json.encode(loginMap);
    await prefs.setString(DBkey.user, jsonBody);
  }

  static getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Users user = Users();
    try {
      String? jsonBody = prefs.getString(DBkey.user);
      if (jsonBody != null) {
        final map = json.decode(jsonBody) as Map<String, dynamic>;
        user = Users.map(map);
      }
    } catch (e) {
      throw DBkey.expired;
    }
    return user;
  }

  // static getProduct() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   Product product = Product();
  //   try {} catch (e) {}
  // }

  static clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? check = pref.getString(DBkey.user);
    return check != null;
  }
}
