import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gankclient/config/config.dart';
import 'package:gankclient/local/local_storage.dart';
import 'package:gankclient/model/article_detail_model.dart';
import 'package:gankclient/model/article_model.dart';
import 'package:gankclient/net/address.dart';
import 'package:gankclient/net/api.dart';

import 'dart:async';
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';

class GankArticleDetailPage extends StatefulWidget {
  final ArticleModel indexModel;

  const GankArticleDetailPage({Key key, this.indexModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GankArticleDetailPageState();
}

class _GankArticleDetailPageState extends State<GankArticleDetailPage> {
  final CookieManager cookieManager = CookieManager();

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        return WebView(
          debuggingEnabled: Config.DEBUG,
          initialUrl: widget.indexModel.id != ""
              ? "${API.host}/post/${widget.indexModel.id}"
              : widget.indexModel.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          javascriptChannels: <JavascriptChannel>[
            _toasterJavascriptChannel(context),
          ].toSet(),
          navigationDelegate: (NavigationRequest request) {
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
            _checkCookie();
          },
        );
      }),
      floatingActionButton: favoriteButton(),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  Widget favoriteButton() {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          if (controller.hasData) {
            return FloatingActionButton(
              onPressed: () async {
                /* final String url = await controller.data.currentUrl();
                Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Favorited $url')),
                );*/
                await controller.data.evaluateJavascript(
                    'document.querySelector(".nav-switch-dark-mode").click();');

//                controller.data.loadUrl();
              },
              child: const Icon(Icons.favorite),
            );
          }
          return Container();
        });
  }

  _renderHtml(html) {
    String _html = '''
          <html>
            <head>
              <meta charset="UTF-8">
            </head>
            <body ">
              $html
            </body>
        </html>
    ''';
    String _S =
        "data:text/html;charset=utf-8;base64,${base64Encode(const Utf8Encoder().convert(_html))}";
    return _S;
  }

  Future<ArticleDetailModel> _getDetail() async {
    var res = await httpManager
        .fetch(API.gankContentDetail("5e51fd596c46d230caaf5724"), {});
    if (res != null && res.success) {
      ArticleDetailModel model = ArticleDetailModel.fromJson(res.data);
      return model;
    } else {
      Fluttertoast.showToast(msg: "加载失败");
      return null;
    }
  }

  void _switchHtmlTheme(WebViewController webViewController) async {
    var controller = await _controller.future;
  }

  /// 检查主题设置是否同步。
  /// 目前版本的 WebView无法管理 Cookie，只能页面加载完成后通过脚本命令去检查更新，等待后续的更新。
  void _checkCookie() async {
    if (lazyFuture == null) {
      // 等待网页的最终状态
      lazyFuture = Future.delayed(Duration(seconds: 3), () {
        _invokeCheckTheme();
        lazyFuture = null;
      });
    }
  }

  Future lazyFuture;

  void _matchTheme(WebViewController webViewController, String element) async {
    var htmlDarkMode = element.split("=")[1];
    var source = await LocalStorage.get(Config.THEME_COLOR);
    var themeStatus = int.parse(source);
    var status = themeStatus == 0 ? "off" : "on";
    //检查 Cookie 中的 mode 配置是否匹配
    var cookieMatch = status.compareTo(htmlDarkMode) != 0;
    if (!cookieMatch) {
      await webViewController
          .evaluateJavascript('document.cookie="dark_model=$status";');
    }
    var darkModeClassNameIndex = await webViewController.evaluateJavascript(
        "document.querySelector('body').className.search('nice-dark-mode')");
    var cssDarkMode = darkModeClassNameIndex == "-1" ? "off" : "on";
    // 检查主题元素 style 是否匹配
    var styleMatch = cssDarkMode.compareTo(status) != 0;
    if (!styleMatch) {
      webViewController.evaluateJavascript('toggleDarkMode()');
    }
  }

  void _invokeCheckTheme() async {
    var controller = await _controller.future;
    final String cookies =
        await controller.evaluateJavascript('document.cookie');
    final List<String> cookieList = cookies.split(';');
    cookieList.forEach((element) {
      if (element.contains("dark_mode")) {
        _matchTheme(controller, element);
        return;
      }
    });
  }
}
