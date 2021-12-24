import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:petani_kopi/screen/login/login_main.dart';
import 'package:petani_kopi/service/locator.dart';
import 'package:petani_kopi/service/route_generator.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'OpenSans'),
      navigatorKey: locator<NavigatorService>().navigatorKey,
      onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
      title: 'Petani Kopi',
      home: const LoginMainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
