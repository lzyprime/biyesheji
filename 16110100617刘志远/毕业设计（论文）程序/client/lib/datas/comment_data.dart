import 'package:client/datas/post_data.dart';
import 'package:client/datas/user_data.dart';

class CommentData {
  int id;
  PostData post;
  UserData userData;
  String content;
  String dateTime;

  CommentData({
    this.id,
    this.post,
    this.userData,
    this.content,
    this.dateTime,
  });

  CommentData.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        post = PostData.fromJson(json["post"]),
        userData = UserData.fromJson(json["user"]),
        content = json["content"],
        dateTime = json["dateTime"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "postId": post.toJson(),
        "user": userData.toJson(),
        "content": content,
        "dateTime": dateTime,
      };
}
