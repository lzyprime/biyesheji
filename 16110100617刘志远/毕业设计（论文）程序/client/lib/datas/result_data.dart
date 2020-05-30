class ResultData {
  int result;
  String msg;
  var data;

  ResultData({this.result, this.msg, this.data});

  ResultData.fromJson(json)
      : result = json["result"],
        msg = json["msg"],
        data = json["data"];
}
