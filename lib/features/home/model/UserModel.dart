
import 'dart:convert';

class UserModel {
  UserModel({
    this.data,
    this.total,
    this.page,
    this.limit,
    this.offset,
  });

  List<UsersData> data;
  int total;
  int page;
  int limit;
  int offset;

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    data: json["data"] == null ? null : List<UsersData>.from(json["data"].map((x) => UsersData.fromJson(x))),
    total: json["total"] == null ? null : json["total"],
    page: json["page"] == null ? null : json["page"],
    limit: json["limit"] == null ? null : json["limit"],
    offset: json["offset"] == null ? null : json["offset"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "total": total == null ? null : total,
    "page": page == null ? null : page,
    "limit": limit == null ? null : limit,
    "offset": offset == null ? null : offset,
  };
}

class UsersData {
  UsersData({
    this.id,
    this.email,
    this.title,
    this.firstName,
    this.picture,
    this.lastName,
  });

  String id;
  String email;
  String title;
  String firstName;
  String picture;
  String lastName;

  factory UsersData.fromRawJson(String str) => UsersData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UsersData.fromJson(Map<String, dynamic> json) => UsersData(
    id: json["id"] == null ? null : json["id"],
    email: json["email"] == null ? null : json["email"],
    title: json["title"] == null ? null : json["title"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    picture: json["picture"] == null ? null : json["picture"],
    lastName: json["lastName"] == null ? null : json["lastName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "email": email == null ? null : email,
    "title": title == null ? null : title,
    "firstName": firstName == null ? null : firstName,
    "picture": picture == null ? null : picture,
    "lastName": lastName == null ? null : lastName,
  };
}
