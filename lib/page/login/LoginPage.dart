import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gankclient/page/web_page/web_view_page.dart';
import 'package:gankclient/style/style.dart';
import 'package:gankclient/utils/common_utils.dart';
import 'package:gankclient/widget/native_image.dart';
import 'package:gankclient/widget/tab_indication_paint.dart';

class LoginPage extends StatefulWidget {
  static Color loginGradientStart = Colors.blue[200];

  static Color loginGradientEnd = Colors.blue[500];

  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Color left = Colors.black;
  Color right = Colors.white;

  PageController _pageController;

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  TextEditingController registerEmailController = new TextEditingController();
  TextEditingController registerPasswordController =
      new TextEditingController();
  TextEditingController registerConfirmPasswordController =
      new TextEditingController();

  bool _obscureTextLogin = true;
  bool _obscureTextSignupConfirm = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowGlow();
          return false;
        },
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                NativeImage("gank_head_persona_background"),
                Padding(
                  padding: EdgeInsets.only(top: 75),
                  child: _buildTabBar(context),
                ),
                Expanded(
                  flex: 2,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (i) {
                      if (i == 0) {
                        setState(() {
                          right = Colors.white;
                          left = Colors.black;
                        });
                      } else if (i == 1) {
                        setState(() {
                          right = Colors.black;
                          left = Colors.white;
                        });
                      }
                    },
                    children: <Widget>[
                      new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: _buildSignIn(context),
                      ),
                      new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: _buildSignUp(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Container(
        width: 300.0,
        height: 50.0,
        decoration: BoxDecoration(
            color: ThemeColors.darkCardBackground,
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        child: CustomPaint(
          painter: TabIndicatorPainter(pageController: _pageController),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: _onSignInButtonPress,
                  child: Text("Sign In",
                      style: TextStyle(
                          color: left,
                          fontSize: 16.0,
                          fontFamily: "WorkSansSemiBold")),
                ),
              ),
              Expanded(
                child: FlatButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: _onSignUpButtonPress,
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        color: right,
                        fontSize: 16.0,
                        fontFamily: "WorkSansSemiBold"),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildSignIn(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 400.0,
                  height: 190.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 0),
                        child: TextField(
                          controller: loginEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: editTextStyle(),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(Icons.email, size: 22.0),
                              hintText: "Email Address",
                              hintStyle: hideTextStyle()),
                        ),
                      ),
                      Divider(
                        indent: 50,
                        height: 1.0,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 0),
                        child: TextField(
                          controller: loginPasswordController,
                          obscureText: _obscureTextLogin,
                          style: TextStyle(
                            fontFamily: "WorkSansSemiBold",
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                Icons.lock,
                                size: 22.0,
                              ),
                              hintText: "Password",
                              hintStyle: hideTextStyle(),
                              suffixIcon: GestureDetector(
                                onTap: _toggleLogin,
                                child: Icon(
                                  _obscureTextLogin
                                      ? Icons.remove_red_eye
                                      : Icons.panorama_fish_eye,
                                  size: 16.0,
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 170.0),
                decoration: shadowBoxDecoration(),
                child: MaterialButton(
                  highlightColor: Colors.transparent,
                  splashColor: LoginPage.loginGradientEnd,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 42.0),
                    child: Text("Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontFamily: "WorkSansBold")),
                  ),
                  onPressed: () {
                    functionNotImplement();
                  },
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: FlatButton(
              onPressed: () {
                CommonUtils.pushPage(context, WebViewPage("https://github.com/login/oauth/authorize?client_id=2d7e4dcd9ee311d6a4ad",""));
              },
              child: Text("Github 授权登录",
                  style: TextStyle(fontSize: 16.0, fontFamily: "WorkSans")),
            ),
          )
        ],
      ),
    );
  }

  BoxDecoration shadowBoxDecoration() {
    return new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: LoginPage.loginGradientStart,
              offset: Offset(1.0, 6.0),
              blurRadius: 20.0),
          BoxShadow(
              color: LoginPage.loginGradientEnd,
              offset: Offset(1.0, 6.0),
              blurRadius: 20.0)
        ],
        gradient: new LinearGradient(
            colors: [LoginPage.loginGradientEnd, LoginPage.loginGradientStart],
            begin: const FractionalOffset(0.2, 0.2),
            end: const FractionalOffset(1.0, 1.0),
            tileMode: TileMode.clamp));
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  Widget _buildSignUp(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Stack(
        alignment: Alignment.topCenter,
        overflow: Overflow.visible,
        children: <Widget>[
          Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: Container(
              width: 400.0,
              height: 230.0,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(25.0, 20, 25.0, 0.0),
                    child: TextField(
                      controller: registerEmailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.email, size: 22.0),
                          hintText: "Email Adderss",
                          hintStyle: hideTextStyle()),
                      style: editTextStyle(),
                    ),
                  ),
                  Divider(
                    indent: 50,
                    height: 1.0,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 0.0),
                    child: TextField(
                      controller: registerPasswordController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.lock, size: 22.0),
                          hintText: "Password",
                          hintStyle: hideTextStyle()),
                      style: editTextStyle(),
                    ),
                  ),
                  Divider(
                    indent: 50,
                    height: 1.0,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 0.0),
                    child: TextField(
                      controller: registerConfirmPasswordController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.lock, size: 22.0),
                          hintText: "Confirmation",
                          hintStyle: hideTextStyle()),
                      style: editTextStyle(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 208.0),
            decoration: shadowBoxDecoration(),
            child: MaterialButton(
              highlightColor: Colors.transparent,
              splashColor: LoginPage.loginGradientEnd,
              onPressed: () {
                functionNotImplement();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 42.0),
                child: Text(
                  "Sure",
                  style: TextStyle(
                      fontFamily: "WorkSansemiBold",
                      fontSize: 24.0,
                      color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  functionNotImplement() {
  }

  TextStyle editTextStyle() {
    return TextStyle(
        fontFamily: "WorkSansSemiBold",
        fontSize: 16.0,
        color: Theme.of(context).textTheme.display3.color);
  }

  TextStyle hideTextStyle() {
    return TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 18.0);
  }

  void _onSignInButtonPress() {
    _pageController.jumpToPage(0);
  }

  void _onSignUpButtonPress() {
    _pageController.jumpToPage(1);
  }
}
