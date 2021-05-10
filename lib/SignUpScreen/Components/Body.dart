import 'package:flutter/material.dart';

import 'SignUpForm.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueGrey, Colors.grey.shade300],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'SIGN UP',
                    style: TextStyle(
                      color: Colors.blueGrey.shade800,
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Please Create an Account to Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SignUpForm(),
              SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
