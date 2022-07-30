import 'dart:convert';

CategoryAllResponse categoryAllResponseFromJson(String str) =>
    CategoryAllResponse.fromJson(json.decode(str));

String categoryAllResponseToJson(CategoryAllResponse data) =>
    json.encode(data.toJson());

class CategoryAllResponse {
  bool success;
  String msg;
  List<Category> categories;

  CategoryAllResponse({
    required this.success,
    required this.msg,
    required this.categories,
  });

  factory CategoryAllResponse.fromJson(Map<String, dynamic> json) =>
      CategoryAllResponse(
        success: json["success"],
        msg: json["msg"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resp": success,
        "msg": msg,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Category {
  String id;
  String name;
  String description;

  Category({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };
}
