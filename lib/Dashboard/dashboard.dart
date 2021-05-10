import 'package:flutter/material.dart';
import 'package:passwordmanager/Dashboard/Components/BOdy.dart';

class Dashboard extends StatelessWidget {
  static String routeName = '/dashboard';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
