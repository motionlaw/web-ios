import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'dart:async';

_logout(context) async {
  Navigator.pushNamed(context, '/loading');
  var box = await Hive.openBox('app_data');
  http.Response response = await http.post("https://qqv.oex.mybluehost.me/api/logout",
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${box.get('token')}'
    }
  );
  await box.delete('token');
  var timer = Timer(Duration(seconds: 2), () => {
    Navigator.pushNamed(context, '/login')
  });
}
class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Align(
              alignment: Alignment.centerLeft,
              child : SizedBox(
                  child: Image.asset(
                      'assets/img/Motionlaw-logogold.png',
                      height:110
                  )
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Communication'),
            onTap: () => {Navigator.pushNamed(context, '/communication')},
          ),
          ListTile(
            leading: Icon(Icons.alternate_email),
            title: Text('Chat'),
            onTap: () => {Navigator.pushNamed(context, '/chat')},
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Make a Payment'),
            onTap: () => {Navigator.pushNamed(context, '/payment')},
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Email Us'),
            onTap: () => {Navigator.pushNamed(context, '/support')},
          ),
          ListTile(
            leading: Icon(Icons.accessibility_sharp),
            title: Text('Refer a Friend'),
            onTap: () => {Navigator.pushNamed(context, '/refer')},
          ),
          ListTile(
            leading: Icon(Icons.app_blocking_rounded),
            title: Text('Reviews'),
            onTap: () => {Navigator.pushNamed(context, '/reviews')},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.pushNamed(context, '/settings')},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {
              _logout(context)
            },
          ),
        ],
      ),
    );
  }
}