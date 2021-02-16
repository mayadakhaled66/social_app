
import 'dart:convert';

class TagModel {
  TagModel({
    this.data,
    this.total,
    this.page,
    this.limit,
    this.offset,
  });

  List<String> data;
  int total;
  int page;
  int limit;
  int offset;

  factory TagModel.fromRawJson(String str) => TagModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TagModel.fromJson(Map<String, dynamic> json) => TagModel(
    data: json["data"] == null ? null : List<String>.from(json["data"].map((x) => x)),
    total: json["total"] == null ? null : json["total"],
    page: json["page"] == null ? null : json["page"],
    limit: json["limit"] == null ? null : json["limit"],
    offset: json["offset"] == null ? null : json["offset"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x)),
    "total": total == null ? null : total,
    "page": page == null ? null : page,
    "limit": limit == null ? null : limit,
    "offset": offset == null ? null : offset,
  };
}
