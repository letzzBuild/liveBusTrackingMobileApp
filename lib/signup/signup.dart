import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bustracker/projectConfig.dart' as config;

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late String username;
  late String email;
  late String password;
  bool isloading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  void signUpRequest(String name, String email, String password) async {
    var data = jsonEncode({
      "fullname": name,
      "email": email,
      "password": password,
    });
    var response = await http.post(
      Uri.http(config.BaseUrl, "user/add/user/"),
      body: data,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var signupdata = jsonDecode(response.body);
    print(signupdata);

    if (signupdata['status'] == 1) {
      Navigator.pushNamed(context, '/login');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green[300],
        content: const Text(
          "Registred Successfully..!",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green[300],
        content: const Text(
          "fail to register",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ));
    }
  }

  String? validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return null;
    else
      return null;
  }

  String? validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
            text: 'S',
            style: TextStyle(
                color: Colors.purple[900],
                fontWeight: FontWeight.bold,
                fontSize: 60)),
        TextSpan(
            text: 'ign', style: TextStyle(color: Colors.black, fontSize: 40)),
        TextSpan(
          text: 'u',
          style: TextStyle(
              color: Colors.purple[900],
              fontWeight: FontWeight.bold,
              fontSize: 40),
        ),
        TextSpan(
          text: 'p',
          style: TextStyle(color: Colors.purple[900], fontSize: 30),
        ),
        TextSpan(
          text: '?',
          style: TextStyle(color: Colors.purple[900], fontSize: 50),
        ),
        TextSpan(
          text: '?',
          style: TextStyle(color: Colors.purple[900], fontSize: 30),
        ),
        TextSpan(
          text: '?',
          style: TextStyle(color: Colors.purple[900], fontSize: 20),
        ),
      ]),
    );
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome!",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Create an account here...",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 60),
                  _title(),
                  SizedBox(height: 20),
                  Material(
                    elevation: 5,
                    shadowColor: Colors.grey,
                    child: TextFormField(
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "This field is Required";
                        }
                        return null;
                      },
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        prefixIcon:
                            Icon(Icons.person, size: 20, color: Colors.black),
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: 'Enter you name',
                        labelText: 'Name',
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Material(
                    elevation: 5,
                    shadowColor: Colors.grey,
                    child: TextFormField(
                      validator: (value) => value!.isEmpty
                          ? "Email is required"
                          : validateEmail(value),
                      controller: _emailController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        prefixIcon:
                            Icon(Icons.email, size: 20, color: Colors.black),
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: 'Email',
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Material(
                    elevation: 5,
                    shadowColor: Colors.grey,
                    child: TextFormField(
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "This field is required";
                        }
                        if (value != null && value.length < 4) {
                          return 'Must be more than 3 charater';
                        }
                        return null;
                      },
                      controller: _passController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 20,
                          color: Colors.black,
                        ),
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'password',
                        hintStyle: TextStyle(color: Colors.grey),
                        labelText: 'password',
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  MaterialButton(
                    child: Text("SignUp"),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        username = _nameController.text;
                        email = _emailController.text;
                        password = _passController.text;
                        signUpRequest(username, email, password);
                      }
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}
