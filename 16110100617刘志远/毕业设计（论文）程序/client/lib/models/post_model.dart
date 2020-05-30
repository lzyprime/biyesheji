import 'package:client/globals/cache.dart';
import 'package:client/globals/net.dart';

import 'package:client/datas/result_data.dart';

class PostModel {
  static const _instance = PostModel._();

  factory PostModel() => _instance;

  const PostModel._();

  static const url = "/post";

  Stream<ResultData> editPost(int id, String title, String content) =>
      Net().get("$url/edit_post",{
        "id": id,
        "title": title,
        "content": content,
        "uid": Cache().userData?.id,
        "auth": Cache().authCode,
      });

  Stream<ResultData> postList() => Net().get("$url/post_list", {
        "current": 0,
        "type": 0,
      });

  Stream<ResultData> removePost(int postId) => Net().get("$url/remove_post", {
        "uid": Cache().userData?.id,
        "auth": Cache().authCode,
        "postId": postId,
      });
}
