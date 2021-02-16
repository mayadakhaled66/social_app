import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:preventia_app/features/Utilities/UserInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  Future<String> authenticate({@required username, @required password}) async {
    final url = "https://reqres.in/api/login";
    try {
      final response = await http.post(
        url,
        body: {
          "email": username,
          "password": password
        },
      );

      if (response.statusCode == 201||response.statusCode == 200) {
        return UserInfo.fromJson(jsonDecode(response.body)).token;
      } else {
        throw Exception('Failed to login this is user not Exist');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> deleteToken({String token}) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
   bool loggedOut = await prefs.remove("token");
    return loggedOut;
  }

  Future<void> persistToken({@required String token,String userName}) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setString("token", token);
    prefs.setString("userName", userName);
    return;
  }

  Future<bool> hasToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token")!=null ? true : false;
  }
}
