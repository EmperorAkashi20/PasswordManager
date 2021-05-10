import 'package:flutter/widgets.dart';
import 'package:passwordmanager/SignInScreen/signinscreen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SignInScreen.routeName: (context) => SignInScreen(),
};
