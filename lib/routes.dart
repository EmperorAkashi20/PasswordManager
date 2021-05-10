import 'package:flutter/widgets.dart';
import 'package:passwordmanager/Dashboard/dashboard.dart';
import 'package:passwordmanager/SignInScreen/signinscreen.dart';
import 'package:passwordmanager/SignUpScreen/signupscreen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SignInScreen.routeName: (context) => SignInScreen(),
  Dashboard.routeName: (context) => Dashboard(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
};
