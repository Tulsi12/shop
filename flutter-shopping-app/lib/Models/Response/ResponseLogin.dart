import 'dart:convert';

ResponseLogin responseLoginFromJson(String str) =>
    ResponseLogin.fromJson(json.decode(str));

String responseLoginToJson(ResponseLogin data) => json.encode(data.toJson());

class ResponseLogin {
  bool? success;
  String? error;
  User? user;
  String? token;

  ResponseLogin({
    required this.success,
    required this.error,
    this.user,
    this.token,
  });

  factory ResponseLogin.fromJson(Map<String, dynamic> json) => ResponseLogin(
        success: json["success"],
        error: json["error"],
        user: User.fromJson(json["user"] != null ? json["user"] : Map()),
        token: json["token"] != null ? json["token"] : '',
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "error": error,
        "user": user!.toJson(),
        "token": token,
      };
}

class User {
  String? id;
  String? name;
  String? email;
  bool? isAdmin;
  String? notificationToken;

  User({this.id, this.name, this.email, this.isAdmin, this.notificationToken});

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["_id"] != null ? json["_id"] : 0,
      name: json["name"] != null ? json["name"] : '',
      email: json["email"] != null ? json["email"] : '',
      isAdmin: json["isAdmin"] != false ? json["isAdmin"] : false,
      notificationToken:
          json["notification_token"] != null ? json["notification_token"] : '');

  Map<String, dynamic>? toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "isAdmin": isAdmin,
        "notification_token": notificationToken
      };
}
