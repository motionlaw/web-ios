import 'package:flutter/material.dart';
import 'package:flutter_app/ui/modules/login_page.dart';
import 'package:flutter_app/ui/modules/home.dart';
import 'package:flutter_app/ui/modules/communications.dart';
import 'package:flutter_app/ui/modules/chat.dart';
import 'package:flutter_app/ui/modules/settings.dart';
import 'package:flutter_app/ui/modules/payment.dart';
import 'package:flutter_app/ui/modules/support.dart';
import 'package:flutter_app/ui/modules/refer.dart';
import 'package:flutter_app/ui/modules/reviews.dart';
import 'package:flutter_app/ui/common/loading.dart';
import 'package:flutter_app/style/theme.dart' as Theme;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

import 'ui/modules/settings.dart';

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
    return MaterialApp(
      title: 'Motion Law.',
      theme: new ThemeData(
          primaryColor: Theme.Colors.motionTmBlue
      ),
      home: defaultHome,
      routes: {
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/loading': (context) => LoadingPage(),
        '/communication': (context) => CommunicationPage(),
        '/chat': (context) => ChatPage(),
        '/payment': (context) => PaymentPage(),
        '/settings': (context) => SettingsPage(),
        '/support' : (context) => SupportPage(),
        '/refer' : (context) => ReferPage(),
        '/reviews' : (context) => ReviewsPage()
      }
    );
  }
}