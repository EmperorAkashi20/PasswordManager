import 'package:flutter/material.dart';
import 'package:passwordmanager/routes.dart';

import 'Components/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(),
      debugShowCheckedModeBanner: false,
      title: 'Password Manager',
      theme: theme(),
      routes: routes,
      initialRoute: '', //OnBoardingScreen.routeName,
    );
  }
}
