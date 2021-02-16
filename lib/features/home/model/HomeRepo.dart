import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:preventia_app/features/home/model/PastModel.dart';
import 'package:preventia_app/features/home/model/TagModel.dart';
import 'package:preventia_app/features/home/model/UserModel.dart';

class HomeRepo {
  //app-id : 602ac221ac5aaa7e77047aa2
  // https://dummyapi.io/data/api/user
  // https://dummyapi.io/data/api//post
  // https://dummyapi.io/data/api/user/{8YL1aG0vwRBXTzeZ0jRC}/post
  // https://dummyapi.io/data/api/user?page=1&limit=10
  // https://dummyapi.io/data/api/tag
  Future<UserModel> getUsers() async {
    final url = "https://dummyapi.io/data/api/user";
    try {
      final response = await http.get(
        url,headers: {"app-id" : "602ac221ac5aaa7e77047aa2"},
        // body: {
        //   "email": username,
        //   "password": password
        // },
      );

      if (response.statusCode == 201||response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to with response code state ${response.statusCode}');
      }
    } catch (error) {
      rethrow;
    }
  }
  Future<TagModel> getTags() async {
    final url = "https://dummyapi.io/data/api/tag";
    try {
      final response = await http.get(
        url,headers: {"app-id" : "602ac221ac5aaa7e77047aa2"},
        // body: {
        //   "email": username,
        //   "password": password
        // },
      );

      if (response.statusCode == 201||response.statusCode == 200) {
        return TagModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to with response code state ${response.statusCode}');
      }
    } catch (error) {
      rethrow;
    }
  }
  Future<PostModel> getPosts() async {
    final url = "https://dummyapi.io/data/api//post";
    try {
      final response = await http.get(
        url,headers: {"app-id" : "602ac221ac5aaa7e77047aa2"},
        // body: {
        //   "email": username,
        //   "password": password
        // },
      );

      if (response.statusCode == 201||response.statusCode == 200) {
        return PostModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to with response code state ${response.statusCode}');
      }
    } catch (error) {
      rethrow;
    }
  }
  Future<PostModel> getPostsPerUserId({@required String userId}) async {
    final url = "https://dummyapi.io/data/api/user/$userId/post";
    try {
      final response = await http.get(
        url,headers: {"app-id" : "602ac221ac5aaa7e77047aa2"},
        // body: {
        //   "email": username,
        //   "password": password
        // },
      );

      if (response.statusCode == 201||response.statusCode == 200) {
        return PostModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to with response code state ${response.statusCode}');
      }
    } catch (error) {
      rethrow;
    }
  }
}
