import 'dart:io';
import 'package:dio/dio.dart';

import 'package:client/globals/localizations.dart';
import 'package:client/datas/result_data.dart';

class Net {
  factory Net() => _instance;
  static final _instance = Net._();
  Dio dio = Dio();

  Net._() {
    dio.options.baseUrl = "http://192.168.2.233:8080";
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 3000;
  }

  Stream<ResultData> get(String url, [Map<String, dynamic> query]) =>
      dio.get(url, queryParameters: query ?? {}).then((res) {
        print(res.data.toString());
        if (res.statusCode == HttpStatus.ok)
          return ResultData.fromJson(res.data);
        return ResultData(result: res.statusCode, msg: res.statusMessage);
      }, onError: (e) {
        print((e as DioError).response.toString());
        return ResultData(
            result: HttpStatus.badRequest, msg: S.current.netError);
      }).asStream();
}
