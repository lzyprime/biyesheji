import 'package:client/datas/user_data.dart';

class PostData extends Comparable<PostData> {
  int id = 0;
  String title;
  String content;
  String createTime;
  String updateTime;
  UserData userData;
  int sortValue;

  PostData({
    this.id = 0,
    this.title = "",
    this.content = "",
    this.createTime,
    this.updateTime,
    this.userData,
    this.sortValue,
  });

  PostData.fromJson(Map<String, dynamic> json)
      : id = json["id"] ?? 0,
        title = json["title"] ?? "",
        content = json["content"] ?? "",
        createTime = json["createTime"],
        updateTime = json["updateTime"],
        userData =
        json["user"] != null ? UserData.fromJson(json["user"]) : null,
        sortValue = json["sort_value"] ?? 0;

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "title": title,
        "content": content,
        "createTime": createTime,
        "updateTime": updateTime,
        "user": userData.toJson(),
        "sort_value": sortValue,
      };

  @override
  int compareTo(PostData other) => sortValue.compareTo(other.sortValue);
}
