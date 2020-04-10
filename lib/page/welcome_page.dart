import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gankclient/config/config.dart';
import 'package:gankclient/local/local_storage.dart';
import 'package:gankclient/net/address.dart';
import 'package:gankclient/net/api.dart';
import 'package:gankclient/redux/application_state.dart';
import 'package:gankclient/utils/common_utils.dart';
import 'package:gankclient/utils/navigator_utils.dart';
import 'package:html/dom.dart';

class WelcomePage extends StatefulWidget {
  static final String sName = "/";

  @override
  State<StatefulWidget> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    //创建AnimationController
    controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));
    controller.addListener(() {});
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        NavigatorUtils.goHome(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return new Container(
      color: Colors.white,
      child: FutureBuilder<String>(
          future: _getImageUrl(),
          builder: (context, result) {
            if (result.data != null) {
              controller.forward();
              return ScaleTransition(
                  scale: new Tween(begin: 1.0, end: 1.2).animate(controller),
                  child: Image.network(result.data,
                      width: mediaSize.width,
                      height: mediaSize.height,
                      fit: BoxFit.fill));
            } else {
              return Container();
            }
          }),
    );
  }

  Future<String> _getImageUrl() async {
    var store = StoreProvider.of<ApplicationState>(context);
    var themeColor = await LocalStorage.get(Config.THEME_COLOR);
    var index = int.parse(themeColor ?? 0);
    var storeBrightness = index == 0 ? Brightness.light : Brightness.dark;
    if (Theme.of(context).brightness != storeBrightness) {
      CommonUtils.pushTheme(store, index);
      return null;
    }

    readTheme();
    Map<String, dynamic> map = {
      "action": "ajax_refresh_random_post",
      "id": "1"
    };
    var response = await httpManager.client().request(API.randomGirlHtmlUrl(),
        data: map, options: HttpManager.fromHtmlOptions());

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      var htmlString = response.data;
      var dom = Document.html(htmlString);
      var element = dom.querySelector(".media-content");
      var attribute = element.attributes["style"];
      var url;
      url = API.domain +
          attribute.toString().substring(
              attribute.indexOf("'") + 1, attribute.lastIndexOf("'"));
      return url;
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  void readTheme() async {

  }
}
