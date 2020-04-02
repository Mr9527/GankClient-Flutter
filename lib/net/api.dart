import 'dart:collection';
import 'dart:io';

import 'package:dio/dio.dart';

import 'code.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/header_interceptor.dart';
import 'interceptors/log_interceptor.dart';
import 'interceptors/token_interceptor.dart';
import 'result_data.dart';

class HttpManager {
  static const CONTENT_TYPE_JSON = "application/json";
  static const ACCEPT_HTML = "text/html";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

  final TokenInterceptors _tokenInterceptors = new TokenInterceptors();

  static final Options postFromOptions = Options(method: 'post', headers: {
    'accpet': CONTENT_TYPE_JSON, "content-type": CONTENT_TYPE_FORM
  });

  static Options fromHtmlOptions() {
    var options = Options(method: 'post', headers: {'accpet': ACCEPT_HTML});
    options.contentType = ContentType.parse(CONTENT_TYPE_FORM).toString();
    return options;
  }

  Dio _dio = new Dio(); // 使用默认配置
  HttpManager() {
    var interceptors = _dio.interceptors;
    interceptors.add(new HeaderInterceptors());
    interceptors.add(_tokenInterceptors);
    interceptors.add(new LogsInterceptors());
    interceptors.add(new ErrorInterceptors(_dio));
//      interceptors.add(new ResponseInterceptors());
  }

  Future<ResultData> fetch(url, params,
      {Map<String, dynamic> header, Options options}) async {
    options = assemblyOptions(header, options);

    Response response;
    try {
      response = await _dio.request(url, data: params, options: options);
    } on DioError catch (e) {
      return Code.dioError(e, e.response, true);
    }
    if (response.data is DioError) {
      return Code.errorHandleAndConvertFunction(response, true);
    }
    return ResultData.convert(response);
  }

  Options assemblyOptions(Map<String, dynamic> header, Options options) {
    Map<String, dynamic> headers = new HashMap();
    if (header != null) {
      headers.addAll(header);
    }

    if (options != null) {
      options.headers.addAll(headers);
    } else {
      options = new Options(method: "get");
      options.headers.addAll(headers);
    }
    return options;
  }

  Dio client() => _dio;

  ///清除授权
  clearAuthorization() {
    _tokenInterceptors.clearAuthorization();
  }

  ///获取授权token
  getAuthorization() async {
    return _tokenInterceptors.getAuthorization();
  }
}

final HttpManager httpManager = new HttpManager();
