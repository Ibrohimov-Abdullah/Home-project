import 'dart:convert';

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  String? fullName;
  String? avatar;
  String? email;
  String? phoneNumber;
  String? password;
  String? id;

  UserModel({
    this.fullName,
    this.avatar,
    this.email,
    this.phoneNumber,
    this.password,
    this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    fullName: json["fullName"],
    avatar: json["avatar"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    password: json["password"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "avatar": avatar,
    "email": email,
    "phoneNumber": phoneNumber,
    "password": password,
    "id": id,
  };
}
