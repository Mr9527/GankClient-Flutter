import 'package:dio/dio.dart';

import '../code.dart';
import '../result_data.dart';

class ResponseInterceptors extends InterceptorsWrapper {
  @override
  Future onResponse(Response response) {
    RequestOptions option = response.request;
    var value;
    try {
      if (response.data is DioError) {
        value = Code.errorHandleAndConvertFunction(response, true);
      }
    } catch (e) {
      print(e.toString() + option.path);
      value = new ResultData(response.data, false,
          status: response.statusCode);
    }
    return value;
  }
}
