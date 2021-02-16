import 'dart:io';

class UserInfo {
  String firstName;
  String password;
  String email;
  String details;
  String token;
  File photo;

  UserInfo({this.photo,this.firstName, this.password, this.email, this.details,this.token});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      firstName: json['firstName']!=null ? json['firstName']: null,
      password: json['password']!=null ? json['password']: null,
      email: json['email']!=null ? json['email']: null,
      token: json['token']!=null ? json['token']: null,
    );
  }
}