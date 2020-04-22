import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gankclient/localization/default_localizations.dart';
import 'package:gankclient/model/cookie_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginWebView extends StatefulWidget {
  final String url;
  final String title;

  LoginWebView(this.url, this.title);

  @override
  _LoginWebViewState createState() => _LoginWebViewState();
}

class _LoginWebViewState extends State<LoginWebView> {
  _renderTitle() {
    if (widget.url == null || widget.url.length == 0) {
      return new Text(widget.title);
    }
    return new Row(children: [
      new Expanded(
          child: new Container(
        child: new Text(
          widget.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      )),
    ]);
  }

  final FocusNode focusNode = new FocusNode();

  static final domain = "http://gank.io/";

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: _renderTitle(),
      ),
      body: new Stack(
        children: <Widget>[
          TextField(
            focusNode: focusNode,
          ),
          WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
              navigationDelegate: (NavigationRequest navigation) {
                if (navigation.url != null &&
                    navigation.url.compareTo(domain) == 0 &&
                    navigation.isForMainFrame) {
                  searchCookie();
                  return NavigationDecision.navigate;
                }
                return NavigationDecision.navigate;
              },
              onPageFinished: (_) {
                setState(() {
                  isLoading = false;
                });
              }),
          if (isLoading)
            new Center(
              child: new Container(
                width: 200.0,
                height: 200.0,
                padding: new EdgeInsets.all(4.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new SpinKitDoubleBounce(
                        color: Theme.of(context).primaryColor),
                    new Container(width: 10.0),
                    new Container(
                        child: new Text(
                            GSYLocalizations.i18n(context).loading_text)),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }

  void searchCookie() async {
    var cookieManager = CookieManager();
    var cookies = await cookieManager.getCookies(domain);
    if (cookies != null) {
      var list = cookies.map((c) {
        var cookieModel = CookieModel(c.name, c.value, c.expires, c.maxAge,
            c.domain, c.path, c.secure, c.httpOnly);
        return cookieModel;
      }).toList();
      var str = "";
      for (var i = 0; i < list.length; i++) {
        var m = list[i];
        if (i == 0) {
          str += "[${json.encode(m.toJson())},";
        } else if (i == list.length - 1) {
          str += "${json.encode(m.toJson())}]";
        } else {
          str += "${json.encode(m.toJson())},";
        }
      }
      print(str);
    }
  }
}
