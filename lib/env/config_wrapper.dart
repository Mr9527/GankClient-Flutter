import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gankclient/config/config.dart';
import 'package:gankclient/env/env_config.dart';


class ConfigWrapper extends StatelessWidget {
  ConfigWrapper({Key key, this.child, this.config});

  final Widget child;
  final EnvConfig config;

  @override
  Widget build(BuildContext context) {
    Config.DEBUG = this.config.debug;
    return new _InheritedConfig(
      config: this.config,
      child: this.child,
    );
  }

  static EnvConfig of(BuildContext context) {
    final _InheritedConfig inheritedConfig = context
        .dependOnInheritedWidgetOfExactType(aspect: _InheritedConfig);
    return inheritedConfig.config;
  }
}


class _InheritedConfig extends InheritedWidget {
  final EnvConfig config;

  const _InheritedConfig(
      {Key key, @required this.config, @required Widget child})
      : assert(child != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedConfig oldWidget) =>
      config != oldWidget.config;
}
