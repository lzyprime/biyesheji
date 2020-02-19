import 'package:client/datas/result_data.dart';
import 'package:client/globals/net.dart';

class FavoriteModel {
  factory FavoriteModel() => _instance;
  static const _instance = FavoriteModel._();
  static const url = "/favorite";

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
}
