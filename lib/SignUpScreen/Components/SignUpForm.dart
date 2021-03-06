import 'package:flutter/material.dart';

import 'package:passwordmanager/Components/constants.dart';
import 'package:passwordmanager/Components/form_error.dart';
import 'package:passwordmanager/Db/database.dart';
import 'package:passwordmanager/SignInScreen/signinscreen.dart';
import 'package:passwordmanager/main.dart';
import 'package:sqflite/sqflite.dart';

class SignUpForm extends StatefulWidget {
  static String? user;
  static String? password;
  static String? confirmPassword;
  static var digest;
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  // Define a function that inserts dogs into the database
  Future<void> insertUser(User user) async {
    final db = await MyApp.database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the dogs from the dogs table.
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

  Future<void> updateUser(User user) async {
    // Get a reference to the database.
    final db = await MyApp.database;

    // Update the given Dog.
    await db.update(
      'users',
      user.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUser(int id) async {
    // Get a reference to the database.
    final db = await MyApp.database;

    // Remove the Dog from the database.
    await db.delete(
      'users',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  final _formKey = GlobalKey<FormState>();
  bool? remember = false;
  final List<String?> errors = [];

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
    var _id = 0;
    var _user;
    var _password;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // buildEmailFormField(),
          // SizedBox(height: 30),
          buildUserFormField(),
          SizedBox(height: 30),
          buildPasswordFormField(),
          SizedBox(height: 30),
          buildConfirmPasswordFormField(),
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
              _user = SignUpForm.user.toString();
              _password = SignUpForm.password.toString();
              var fido = User(
                id: _id + 1,
                name: _user,
                password: _password,
              );
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                removeError(error: kEmailNullError);
                removeError(error: kEmptyFieldError);
                removeError(error: kPassNullError);
                await insertUser(fido);

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
              Navigator.pushNamed(context, SignInScreen.routeName);
            },
            child: Text(
              'Have an Account? Sign In',
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
        onSaved: (newValue) => SignUpForm.password = newValue,
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

  Container buildConfirmPasswordFormField() {
    return Container(
      height: 50,
      width: 500,
      child: TextFormField(
        obscureText: true,
        onSaved: (newValue) => SignUpForm.confirmPassword = newValue,
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
          labelText: "Confirm Password",
          hintText: "Re-enter your password",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
        ),
      ),
    );
  }

  // Container buildEmailFormField() {
  //   return Container(
  //     height: 50,
  //     width: 500,
  //     child: TextFormField(
  //       keyboardType: TextInputType.emailAddress,
  //       onSaved: (newValue) => SignUpForm.email = newValue,
  //       onChanged: (value) {
  //         if (value.isNotEmpty) {
  //           removeError(error: kEmailNullError);
  //         } else if (emailValidatorRegExp.hasMatch(value)) {
  //           removeError(error: kInvalidEmailError);
  //         }
  //         return null;
  //       },
  //       validator: (value) {
  //         if (value!.isEmpty) {
  //           addError(error: kEmailNullError);
  //           return "";
  //         } else if (!emailValidatorRegExp.hasMatch(value)) {
  //           addError(error: kInvalidEmailError);
  //           return "";
  //         }
  //         return null;
  //       },
  //       decoration: InputDecoration(
  //         errorStyle: TextStyle(color: Colors.white),
  //         labelText: "Email",
  //         hintText: "Enter your email ID",
  //         // If  you are using latest version of flutter then lable text and hint text shown like this
  //         // if you r using flutter less then 1.20.* then maybe this is not working properly
  //         floatingLabelBehavior: FloatingLabelBehavior.always,
  //         //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
  //       ),
  //     ),
  //   );
  // }

  Container buildUserFormField() {
    return Container(
      height: 50,
      width: 500,
      child: TextFormField(
        keyboardType: TextInputType.text,
        onSaved: (newValue) => SignUpForm.user = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kEmailNullError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kEmailNullError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.white),
          labelText: "Username",
          hintText: "Enter a username",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
        ),
      ),
    );
  }
}
