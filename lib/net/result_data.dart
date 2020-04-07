import 'package:dio/dio.dart';

class ResultData {
  var data;
  int status;
  bool success;

  ResultData(this.data, this.success, {this.status = 100});

  static ResultData convert(Response response) {
    if (response.data['data'] != null &&
        response.data["status"] != null) {
      return ResultData(response.data['data'],  response.data["status"] == 100,
          status: response.data['status']);
    } else {
      return ResultData(response.data, true);
    }
  }
}
