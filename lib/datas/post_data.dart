import 'package:client/datas/user_data.dart';

class PostData {
  int id = 0;
  String title;
  String content;
  String createTime;
  String updateTime;
  UserData userData;

  PostData({
    this.id = 0,
    this.title = "",
    this.content = "",
    this.createTime,
    this.updateTime,
    this.userData,
  });

  PostData.fromJson(Map<String, dynamic> json)
      : id = json["id"] ?? 0,
        title = json["title"] ?? "",
        content = json["content"] ?? "",
        createTime = json["createTime"],
        updateTime = json["updateTime"],
        userData =
            json["user"] != null ? UserData.fromJson(json["user"]) : null;
}
