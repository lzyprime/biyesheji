import 'package:client/globals/localizations.dart';

enum EnumSex { obscure, male, female }

class UserData {
  int id;
  String username;
  String email;
  EnumSex sex;
  String avatar;
  int postNum;
  int favoriteNum;
  int attentionNum;
  int followerNum;
  int commentNum;

  String get sexStr {
    if (sex == EnumSex.male) return S.current.male;
    if (sex == EnumSex.female) return S.current.female;
    return S.current.obscure;
  }

  UserData({
    this.id = 0,
    this.username,
    this.email,
    this.sex,
    this.avatar = "",
    this.postNum = 0,
    this.favoriteNum = 0,
    this.attentionNum = 0,
    this.followerNum = 0,
    this.commentNum = 0,
  });

  UserData.fromJson(Map<String, dynamic> json)
      : id = json["id"] ?? 0,
        username = json["username"] ?? "",
        email = json["email"] ?? "",
        sex = EnumSex.values[json["sex"] ?? 0],
        avatar = json["avatar"] ?? "",
        postNum = json["postNum"] ?? 0,
        favoriteNum = json["favoriteNum"] ?? 0,
        attentionNum = json["attentionNum"] ?? 0,
        followerNum = json["followerNum"] ?? 0,
        commentNum = json["commentNum"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "sex": sex.index,
        "avatar": avatar,
        "postNum": postNum,
        "favoriteNum": favoriteNum,
        "attentionNum": attentionNum,
        "followerNum": followerNum,
        "commentNum": commentNum,
      };
}
