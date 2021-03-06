import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../../style/theme.dart' as Theme;
import '../../utils/functions.dart' as tool;

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  checkStatus() async {
    var box = await Hive.openBox('app_data');
    if (box.get('token') != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  bool submit = false;
  bool _obscureTextLogin = true;

  PageController _pageController;

  Color left = Colors.black;
  Color right = Colors.white;

  Map data;

  Future<void> _handleClickMe(message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Required Fields!'),
          content: Text(message),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future auth(String mail, String pass) async {
    if (tool.Functions.validateEmail(mail)) {
      http.Response response = await http.post(
          'https://qqv.oex.mybluehost.me/api/login',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{'email': mail, 'password': pass}));
      data = json.decode(response.body);
      if (data['response'] == true) {
        var box = await Hive.openBox('app_data');
        box.put('token', data['token']);
      }
      return data['response'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height >= 775.0
            ? MediaQuery.of(context).size.height
            : 775.0,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: 0,
                top: 0,
                right: 0,
                bottom: 0,
              ),
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width * 1,
                      color: Colors.black12,
                      child: Padding(
                          padding: const EdgeInsets.only(
                            left: 100,
                            top: 50,
                            right: 100,
                            bottom: 30,
                          ),
                          child: FittedBox(
                            child: Image.asset(
                              "assets/img/Motionlaw-logogold-cr.png",
                            ),
                          )))
                ],
              ),
            ),
            Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                FittedBox(
                  child: Image.asset(
                    "assets/img/DC-Immigration-Law-Firm.png",
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width,
                  ),
                  //fit: BoxFit.fitWidth,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 0,
                top: 20,
                right: 0,
                bottom: 0,
              ),
              child: SizedBox(
                width: double.infinity,
                child: IconButton(
                  color: Theme.Colors.loginGradientButton,
                  icon: FaIcon(FontAwesomeIcons.userFriends),
                  iconSize: 40,
                  onPressed: () {},
                ),
              ),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    myFocusNodePassword.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodeName.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _pageController = PageController();
  }

  void showInSnackBar(String value, String warn) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: (warn == "info") ? Colors.lightBlue : Colors.deepOrange,
      duration: Duration(seconds: 3),
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
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 190.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextFormField(
                          focusNode: myFocusNodeEmailLogin,
                          controller: loginEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.black,
                              size: 14.0,
                            ),
                            hintText: "EMAIL ADDRESS",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 14.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodePasswordLogin,
                          controller: loginPasswordController,
                          obscureText: _obscureTextLogin,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.lock,
                              size: 14.0,
                              color: Colors.black,
                            ),
                            hintText: "PASSWORD",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 14.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleLogin,
                              child: Icon(
                                _obscureTextLogin
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 14.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 220.0),
                  decoration: new BoxDecoration(
                    color: Theme.Colors.loginGradientButton,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: CupertinoButton(
                      //highlightColor: Colors.transparent,
                      padding: EdgeInsets.all(0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 128.0),
                          child: Text(
                            (submit == false) ? "LOGIN" : "LOADING...",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontFamily: "WorkSansBold"),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (loginEmailController.text == "") {
                          _handleClickMe(
                              'Before continue, you must fill the required fields');
                          return false;
                        }
                        if (loginPasswordController.text == "") {
                          _handleClickMe('Password field is required!');
                          return false;
                        }
                        setState(() {
                          submit = !submit;
                        });
                        auth(loginEmailController.text,
                                loginPasswordController.text)
                            .then((response) {
                          print(response);
                          if (response == true) {
                            Navigator.pushNamed(context, '/loading');
                            Timer(Duration(seconds: 3),
                                () => Navigator.pushNamed(context, '/home'));
                          } else {
                            _handleClickMe(
                                'The username or password you entered is incorrect!');
                            submit = !submit;
                          }
                        });
                      })),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: FlatButton(
                onPressed: () {},
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 16.0,
                      fontFamily: "WorkSansMedium"),
                )),
          ),
        ],
      ),
    );
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }
}
