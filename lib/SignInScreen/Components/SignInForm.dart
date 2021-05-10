import 'package:flutter/material.dart';
import 'package:passwordmanager/Components/constants.dart';
import 'package:passwordmanager/Components/form_error.dart';
import 'package:passwordmanager/size_config.dart';

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
            backgroundColor: Colors.white,
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
          SizedBox(
            height: 30,
          ),
          buildUserFormField(),
          SizedBox(
            height: 30,
          ),
          buildPasswordFormField(),
          SizedBox(
            height: 30,
          ),
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
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                removeError(error: kEmailNullError);
                removeError(error: kEmptyFieldError);
                removeError(error: kPassNullError);
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
          Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(100),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormError(errors: errors),
              ),
            ],
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
          labelText: "Email",
          hintText: "Enter your email",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
        ),
      ),
    );
  }
}
