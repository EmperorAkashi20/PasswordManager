import 'package:flutter/material.dart';
import 'package:passwordmanager/SignInScreen/Components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = '/SignIn';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
