import 'package:flutter/material.dart';
import 'package:passwordmanager/Components/custom_suffix_icon.dart';
import 'package:passwordmanager/routes.dart';
import 'package:passwordmanager/size_config.dart';

import 'SignInScreen/signinscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  SizeConfig();
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
      initialRoute: SignInScreen.routeName,
    );
  }
}
