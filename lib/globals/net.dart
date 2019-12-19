import 'package:dio/dio.dart';

// server address
class Net {
  static const baseUrl = 'http://172.20.88.50:8080';

  final dio = Dio(BaseOptions(connectTimeout: 5000, receiveTimeout: 3000, baseUrl: baseUrl));
}
