import 'dart:convert';

enum EnumSex { male, female, obscure }

class UserData {
  int id;
  String username;
  String email;
  EnumSex sex;
  String avatar;

  UserData({this.id, this.username, this.email, this.sex, this.avatar});

  UserData.fromJson(Map<String, dynamic> json)
      : id = json["id"] ?? 0,
        username = json["username"] ?? "",
        email = json["email"] ?? "",
        sex = EnumSex.values[json["sex"] ?? 2],
        avatar = json["avatar"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "sex": sex.index,
        "avatar": avatar,
      };
}
