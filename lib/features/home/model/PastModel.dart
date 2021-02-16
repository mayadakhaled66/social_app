
import 'dart:convert';

class PostModel {
  PostModel({
    this.data,
    this.total,
    this.page,
    this.limit,
    this.offset,
  });

  List<Datum> data;
  int total;
  int page;
  int limit;
  int offset;

  factory PostModel.fromRawJson(String str) => PostModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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

class Datum {
  Datum({
    this.owner,
    this.id,
    this.image,
    this.publishDate,
    this.text,
    this.tags,
    this.link,
    this.likes,
  });

  Owner owner;
  String id;
  String image;
  DateTime publishDate;
  String text;
  List<String> tags;
  String link;
  int likes;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
    id: json["id"] == null ? null : json["id"],
    image: json["image"] == null ? null : json["image"],
    publishDate: json["publishDate"] == null ? null : DateTime.parse(json["publishDate"]),
    text: json["text"] == null ? null : json["text"],
    tags: json["tags"] == null ? null : List<String>.from(json["tags"].map((x) => x)),
    link: json["link"] == null ? null : json["link"],
    likes: json["likes"] == null ? null : json["likes"],
  );

  Map<String, dynamic> toJson() => {
    "owner": owner == null ? null : owner.toJson(),
    "id": id == null ? null : id,
    "image": image == null ? null : image,
    "publishDate": publishDate == null ? null : publishDate.toIso8601String(),
    "text": text == null ? null : text,
    "tags": tags == null ? null : List<dynamic>.from(tags.map((x) => x)),
    "link": link == null ? null : link,
    "likes": likes == null ? null : likes,
  };
}

class Owner {
  Owner({
    this.id,
    this.email,
    this.title,
    this.picture,
    this.firstName,
    this.lastName,
  });

  String id;
  String email;
  Title title;
  String picture;
  String firstName;
  String lastName;

  factory Owner.fromRawJson(String str) => Owner.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
    id: json["id"] == null ? null : json["id"],
    email: json["email"] == null ? null : json["email"],
    title: json["title"] == null ? null : titleValues.map[json["title"]],
    picture: json["picture"] == null ? null : json["picture"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "email": email == null ? null : email,
    "title": title == null ? null : titleValues.reverse[title],
    "picture": picture == null ? null : picture,
    "firstName": firstName == null ? null : firstName,
    "lastName": lastName == null ? null : lastName,
  };
}

enum Title { MRS, MR, MS, MISS }

final titleValues = EnumValues({
  "miss": Title.MISS,
  "mr": Title.MR,
  "mrs": Title.MRS,
  "ms": Title.MS
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
