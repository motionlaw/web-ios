import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/nav-drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Map data;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => new _HomePageState();
}

_asyncMethod(context) async {
  /*var box = await Hive.openBox('app_data');
  print('Name: ${box.get('token')}');
  if( box.get('token') ){
    http.Response response = await http.post('http://qqv.oex.mybluehost.me/api/user',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${box.get('token')}'
        }
    );
    data = json.decode(response.body);
    print(data);
  }*/
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _asyncMethod(context);
  }
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: Text('Hello World'),
      ),
    );
  }
}
