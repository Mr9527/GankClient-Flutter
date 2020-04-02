import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gankclient/net/address.dart';
import 'package:gankclient/net/api.dart';
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
    controller.addListener((){});
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
    Map<String, dynamic> map = {
      "action": "ajax_refresh_random_post",
      "id": "1"
    };
    var response = await httpManager.client().request(
        Address.randomGirlHtmlUrl(),
        data: map,
        options: HttpManager.fromHtmlOptions());

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      var htmlString = response.data;
      var dom = Document.html(htmlString);
      var element = dom.querySelector(".media-content");
      var attribute = element.attributes["style"];
      var url;
      url = Address.domain +
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
}
