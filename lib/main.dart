import 'package:flutter/material.dart';
import 'package:flutter_app/ui/login_page.dart';
import 'package:flutter_app/ui/home.dart';
import 'package:flutter_app/ui/common/loading.dart';
import 'package:flutter_app/style/theme.dart' as Theme;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

LoginPage appAuth = new LoginPage();
Widget defaultHome = new LoginPage();

void main(context) async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  bool _result = await appAuth.checkStatus();
  if ( _result == true) {
    defaultHome = new HomePage();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return new MaterialApp(
      title: 'Motion Law.',
      theme: new ThemeData(
          primaryColor: Theme.Colors.motionTmBlue
      ),
      home: defaultHome,
      routes: {
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/loading': (context) => LoadingPage()
      }
    );
  }
}