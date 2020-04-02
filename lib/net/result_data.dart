import 'package:dio/dio.dart';

class ResultData {
  var data;
  int code;
  String message;
  bool success;

  ResultData(this.data, this.success, {this.code = 1, this.message});


  static ResultData convert(Response response) {
    if(response.data['data']!=null&&response.data["code"]!=null) {
      return ResultData(response.data['data'], true,code: response.data['code'],message: response.data['message']);
    }else {
      return ResultData(response.data, true);
    }
  }
}
