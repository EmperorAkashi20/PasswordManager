import 'package:flutter/material.dart';
import 'package:passwordmanager/Components/constants.dart';
import 'package:passwordmanager/Components/form_error.dart';
import 'package:passwordmanager/Db/database.dart';
import 'package:passwordmanager/SignUpScreen/signupscreen.dart';

import '../../main.dart';

class SignInForm extends StatefulWidget {
  static String? user;
  static String? password;
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  bool? remember = false;
  final List<String?> errors = [];

  Future<List<User>> users() async {
    final db = await MyApp.database;

    final List<Map<String, dynamic>> maps = await db.query('users');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        name: maps[i]['name'],
        password: maps[i]['password'],
      );
    });
  }

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.blueGrey.shade200,
            radius: 35,
            child: Text(
              'R',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 35,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 30),
          buildUserFormField(),
          SizedBox(
            height: 30,
          ),
          buildPasswordFormField(),
          SizedBox(height: 30),
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.black87,
              minimumSize: Size(180, 50),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              side: BorderSide(color: Colors.white),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                removeError(error: kEmailNullError);
                removeError(error: kEmptyFieldError);
                removeError(error: kPassNullError);
                print(await users());
              } else {
                _formKey.currentState!.reset();
              }
            },
            child: Text(
              'Continue',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(height: 30),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, SignUpScreen.routeName);
            },
            child: Text(
              'New User? Create An Account',
              style: TextStyle(
                color: Colors.blueGrey.shade600,
              ),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormError(errors: errors),
          ),
        ],
      ),
    );
  }

  Container buildPasswordFormField() {
    return Container(
      height: 50,
      width: 500,
      child: TextFormField(
        obscureText: true,
        onSaved: (newValue) => SignInForm.password = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kPassNullError);
          } else if (value.length >= 2) {
            removeError(error: kShortPassError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kPassNullError);
            return "";
          } else if (value.length < 2) {
            addError(error: kShortPassError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.white),
          labelText: "Password",
          hintText: "Enter your password",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
        ),
      ),
    );
  }

  Container buildUserFormField() {
    return Container(
      height: 50,
      width: 500,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue) => SignInForm.user = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kEmailNullError);
          } else if (emailValidatorRegExp.hasMatch(value)) {
            removeError(error: kInvalidEmailError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kEmailNullError);
            return "";
          } else if (!emailValidatorRegExp.hasMatch(value)) {
            addError(error: kInvalidEmailError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.white),
          labelText: "Username",
          hintText: "Enter your username",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
        ),
      ),
    );
  }
}
