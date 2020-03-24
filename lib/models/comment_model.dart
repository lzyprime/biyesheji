import 'package:client/datas/result_data.dart';
import 'package:client/globals/cache.dart';
import 'package:client/globals/net.dart';

class CommentModel {
  static final _instance = CommentModel._();

  factory CommentModel() => _instance;

  CommentModel._();

  static const url = "/comments";

  Stream<ResultData> newComment(String content, int postId) =>
      Net().get("$url/new_comment", {
        "uid": Cache().userData.id,
        "auth": Cache().authCode,
        "postId": postId,
        "content": content,
      });

  Stream<ResultData> getComments(int postId) =>
      Net().get("$url/get_post_comments", {"postId": postId});

  Stream<ResultData> getUserComments(int uid) =>
      Net().get("$url/get_user_comments", {"uid": uid});

  Stream<ResultData> removeComment(int commentId) =>
      Net().get("$url/remove_comment", {
        "uid": Cache().userData.id,
        "auth": Cache().authCode,
        "commentId": commentId,
      });
}
