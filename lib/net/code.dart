import 'package:dio/dio.dart';
import 'package:gankclient/event/http_error_event.dart';
import 'package:gankclient/event/index.dart';

import 'result_data.dart';

///错误编码
class Code {
  ///网络错误
  static const NETWORK_ERROR = -1;

  ///网络超时
  static const NETWORK_TIMEOUT = -2;

  ///网络返回数据格式化一次
  static const NETWORK_JSON_EXCEPTION = -3;

  static const SUCCESS = 1;

  static errorHandleFunction(code, message, noTip) {
    eventBus.fire(new HttpErrorEvent(code, message, noTip: noTip));
    return message;
  }

  static ResultData errorHandleAndConvertFunction(Response response, noTip) {
    if (response != null &&
        response.statusCode == 200 &&
        response.statusCode < 300) {
      if (response.data is ResultData) {
        return response.data;
      }
      if (response.data["data"] != null &&
          response.data["code"] != null &&
          response.data["message"] != null) {
        var code = response.data["code"];
        return ResultData(response.data["data"], code == 1, status: code);
      }
      return ResultData(response.data, true);
    } else if (response.data is DioError) {
      var error = response.data as DioError;
      return dioError(error, response, noTip);
    } else {
      return new ResultData(
          errorHandleFunction(
              response.statusCode, response.statusMessage, noTip),
          false,
          status: response.statusCode);
    }
  }

  static ResultData dioError(DioError error, Response response, noTip) {
    if (error.type == DioErrorType.CONNECT_TIMEOUT ||
        error.type == DioErrorType.RECEIVE_TIMEOUT) {
      response.statusCode = Code.NETWORK_TIMEOUT;
    }
    if (response.data != null &&
        response.data["data"] != null &&
        response.data["code"] != null &&
        response.data["message"] != null) {
      var code = response.data["code"];
      return ResultData(
          errorHandleFunction(code, response.data["message"], noTip), code == 1,
          status: code);
    }
    return new ResultData(
        errorHandleFunction(response.statusCode, error.message, noTip), false,
        status: response.statusCode);
  }
}
