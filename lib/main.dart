import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gankclient/app.dart';
import 'package:gankclient/env/config_wrapper.dart';
import 'package:gankclient/env/dev.dart';
import 'package:gankclient/env/env_config.dart';
import 'package:gankclient/page/error_page.dart';

void main() {
  // 通过沙盒来捕获全局的错误
  runZoned(() {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      Zone.current.handleUncaughtError(details.exception, details.stack);
      return ErrorPage(
          details.exception.toString() + "\n " + details.stack.toString(),
          details);
    };
    runApp(ConfigWrapper(
      child: Application(),
      config: EnvConfig.fromJson(config),
    ));
  }, onError: (Object obj, StackTrace stack) {
    print(obj);
    print(stack);
  });
}
