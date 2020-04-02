import 'package:flutter/material.dart';
import 'package:gankclient/redux/theme_redux.dart';
import 'package:redux/redux.dart';

class ApplicationState {
  ///主题数据
  ThemeData themeData;

  ApplicationState({this.themeData});
}

/// 创建 Reducer
ApplicationState appReducer(ApplicationState state, action) {
  return ApplicationState(
    themeData: ThemeDataReducer(state.themeData, action),
  );
}

final List<Middleware<ApplicationState>> middleware = [];
