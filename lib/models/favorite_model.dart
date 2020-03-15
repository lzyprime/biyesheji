import 'package:client/datas/result_data.dart';
import 'package:client/globals/net.dart';

class FavoriteModel {
  factory FavoriteModel() => _instance;
  static const _instance = FavoriteModel._();
  static const url = "/favorite_attention";

  const FavoriteModel._();

  Stream<ResultData> postFavoriteStatus(int uid, int pid) =>
      Net().get("$url/post", {
        "uid": uid,
        "pid": pid,
        "inquire": true,
      });

  Stream<ResultData> changePostFavorite(int uid, int pid) =>
      Net().get("$url/post", {
        "uid": uid,
        "pid": pid,
      });

  Stream<ResultData> attentionStatus(int uid, int otherUid) =>
      Net().get("$url/user", {
        "uid": uid,
        "otherUid": otherUid,
        "inquire": true,
      });

  Stream<ResultData> changeAttention(int uid, int otherUid) =>
      Net().get("$url/user", {
        "uid": uid,
        "otherUid": otherUid,
      });
}
