import 'package:flutter/material.dart';
import 'package:passwordmanager/Components/custom_suffix_icon.dart';
import 'package:passwordmanager/routes.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'SignInScreen/signinscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MyApp.database = openDatabase(
    join(await getDatabasesPath(), 'user_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, password TEXT)',
      );
    },
    version: 1,
  );
  MyApp.detailsDatabase = openDatabase(
    join(await getDatabasesPath(), 'details_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE details(id INTEGER PRIMARY KEY, name TEXT, password TEXT)',
      );
    },
    version: 1,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static var prefs;
  static var user;
  static var email;
  static var name;
  static var pan;
  static var hash;
  static var database;
  static var detailsDatabase;
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
